-- TODO:
-- Debugger setups
return {
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPre",
    config = function()
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb",
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {},
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    cmd = "DapNew",
  },
  { "theHamsta/nvim-dap-virtual-text", opts = {}, cmd = "DapNew" },
  {
    "mfussenegger/nvim-dap-python",
    event = "BufReadPost",
    ft = "python",
    config = function()
      require("dap-python").setup("uv")
    end,
  },
}
