return function(config)
  -- Environment
  config.set_environment_variables = {
    TERM = "xterm-256color",
    TERM_PROGRAM = "wezterm",
  }
  config.enable_wayland = false
end
