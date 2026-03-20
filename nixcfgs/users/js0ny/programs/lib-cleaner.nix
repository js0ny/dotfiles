{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkOption
    mkIf
    types
    mapAttrs'
    nameValuePair
    optionalString
    escapeShellArg
    getExe
    ;

  cfg = config.my.cleanup;

  jobType = types.submodule ({name, ...}: {
    options = {
      path = mkOption {
        type = types.str;
        description = "Directory to clean.";
      };

      olderThan = mkOption {
        type = types.int;
        default = 7;
        description = "Delete entries older than this many days.";
      };

      filesOnly = mkOption {
        type = types.bool;
        default = false;
        description = "Only delete regular files.";
      };

      recursive = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to recurse into subdirectories.";
      };

      onCalendar = mkOption {
        type = types.str;
        default = "daily";
        description = "systemd timer schedule.";
      };

      dryRun = mkOption {
        type = types.bool;
        default = false;
        description = "Print what would be deleted without deleting.";
      };
    };
  });

  mkCleanupScript = jobName: job:
    pkgs.writeShellApplication {
      name = "cleanup-${jobName}";
      runtimeInputs = with pkgs; [fd coreutils gnused];
      text = ''
        job_name=${escapeShellArg jobName}
        dir=${escapeShellArg job.path}
        dry_run=${
          if job.dryRun
          then "true"
          else "false"
        }

        log() {
          printf '[cleanup:%s] %s\n' "$job_name" "$*"
        }

        if [ ! -d "$dir" ]; then
          log "skip: directory does not exist: $dir"
          exit 0
        fi

        log "start"

        cmd=(
          fd
          "." "$dir"
          "--hidden"
          "--no-ignore"
          ${optionalString (!job.recursive) ''"--max-depth" "1"''}
          ${optionalString job.filesOnly ''"--type" "file"''}
          "--changed-before" "${toString job.olderThan}d"
          "--absolute-path"
        )

        count="$("''${cmd[@]}" --print0 | tr -dc '\0' | wc -c)"
        log "matched=$count"

        if [ "$count" -eq 0 ]; then
          log "nothing to do"
          exit 0
        fi

        if [ "$dry_run" = "true" ]; then
          log "dry-run: matched entries:"
          "''${cmd[@]}" | sed 's/^/  /'
          log "done (dry-run)"
        else
          log "deleting matched entries..."
          # 批量安全删除
          "''${cmd[@]}" --print0 --exec-batch rm -rf --
          log "done"
        fi
      '';
    };
in {
  options.my.cleanup.jobs = mkOption {
    type = types.attrsOf jobType;
    default = {};
    description = "Cleanup jobs.";
  };

  config = mkIf (cfg.jobs != {}) {
    systemd.user.services =
      mapAttrs' (
        jobName: job:
          nameValuePair "cleanup-${jobName}" {
            Unit = {
              Description = "Cleanup job ${jobName}";
            };

            Service = {
              Type = "oneshot";
              ExecStart = getExe (mkCleanupScript jobName job);
            };
          }
      )
      cfg.jobs;

    systemd.user.timers =
      mapAttrs' (
        jobName: job:
          nameValuePair "cleanup-${jobName}" {
            Unit = {
              Description = "Timer for cleanup job ${jobName}";
            };

            Timer = {
              OnCalendar = job.onCalendar;
              Persistent = true;
            };

            Install = {
              WantedBy = ["timers.target"];
            };
          }
      )
      cfg.jobs;
  };
}
