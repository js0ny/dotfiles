final: prev: {
  wechat-uos-sandboxed = prev.nur.repos.xddxdd.wechat-uos-sandboxed.override {
    buildFHSEnvBubblewrap = args:
      prev.buildFHSEnvBubblewrap (
        args
        // {
          extraPreBwrapCmds =
            ''
              if [[ -z "''${WECHAT_DATA_DIR}" ]]; then
                WECHAT_DATA_DIR="''${WECHAT_SANDBOX_DIR:-$HOME/.sandbox/.per-app/wechat}"
              fi
            ''
            + (if args ? extraPreBwrapCmds then args.extraPreBwrapCmds else "");
          targetPkgs =
            pkgs:
            (if args ? targetPkgs then args.targetPkgs pkgs else []) ++ [pkgs.util-linux];
        }
      );
  };
}
