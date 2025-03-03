return function(config)
  -- Environment
  config.set_environment_variables = {
    TERM = "xterm-256color",
    -- TERM_PROGRAM = "wezterm", -- wezterm already sets this
  }
  config.enable_wayland = false
end
