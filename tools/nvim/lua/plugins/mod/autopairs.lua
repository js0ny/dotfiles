return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    npairs.setup()
    npairs.add_rule(Rule("$", "$", "markdown"))
    npairs.add_rule(Rule("\\(", "\\)", "tex"))
    npairs.add_rule(Rule("\\[", "\\]", "tex"))

    npairs.add_rules({
      Rule("%(", "%)", "cmd"):with_pair(function(opts)
        if vim.fn.getcmdtype() == ":" then
          return true
        end
      end),
    })
  end,
}
