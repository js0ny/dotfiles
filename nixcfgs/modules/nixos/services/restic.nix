# TODO: Configure restic backup
#
# This is a skeleton for services.restic.backups.
# NixOS provides `services.restic.backups.<name>` which creates systemd
# timers that run restic backup on a schedule.
#
# Steps to complete:
#   1. Add a restic repository password to sops secrets:
#      In secrets/secrets.yaml, add:
#        restic_repo_password: "your-secure-password"
#      Then reference it below via sops.secrets."RESTIC_REPO_PASSWORD"
#
#   2. Choose a backup repository backend and set `repository`:
#      - Local:  "/mnt/backup/restic-repo"
#      - SFTP:   "sftp:user@host:/path/to/repo"
#      - S3:     "s3:https://s3.amazonaws.com/bucket-name"
#      - B2:     "b2:bucket-name:/"
#      - Rclone: "rclone:remote:path"
#
#   3. For cloud backends, add credential env vars:
#      - S3:  AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
#      - B2:  B2_ACCOUNT_ID, B2_ACCOUNT_KEY
#      Store these in sops and pass them via `environmentFile`
#
#   4. Set `paths` to directories you want to back up
#
#   5. Set `exclude` patterns for files to skip
#
#   6. Set `timerConfig` for backup schedule (systemd timer syntax)
#
#   7. Optionally configure `pruneOpts` for automatic old snapshot cleanup
#
#   8. Initialize the repo: `restic -r <repository> init`
#
{config, ...}: {
  services.restic.backups = {
    # TODO: Rename this backup job as needed
    main = {
      # TODO: Set your restic repository URL (see step 2 above)
      repository = "/mnt/backup/restic-repo";

      # TODO: Add "RESTIC_REPO_PASSWORD" to sops secrets, then uncomment:
      # passwordFile = config.sops.secrets."RESTIC_REPO_PASSWORD".path;

      # TODO: For cloud backends, create an env file with credentials:
      # environmentFile = config.sops.secrets."RESTIC_ENV".path;

      # TODO: Set directories to back up
      paths = [
        # "/home/js0ny/Documents"
        # "/home/js0ny/Projects"
        # "/home/js0ny/Academia"
      ];

      # TODO: Set exclude patterns
      exclude = [
        ".cache"
        ".local/share/Trash"
        "node_modules"
        ".venv"
        "__pycache__"
        "target"  # Rust/Maven build artifacts
        "result"  # Nix build results
      ];

      # TODO: Set backup schedule (default: daily at 3am)
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;  # Run missed backups after sleep/shutdown
        RandomizedDelaySec = "1h";
      };

      # TODO: Uncomment to enable automatic snapshot pruning
      # pruneOpts = [
      #   "--keep-daily 7"
      #   "--keep-weekly 4"
      #   "--keep-monthly 6"
      #   "--keep-yearly 2"
      # ];
    };
  };
}
