local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics =  null_ls.builtins.diagnostics
  local completion = null_ls.builtins.completion

  null_ls.setup {
    debug = false,
    sources = {
      require("none-ls.diagnostics.yamllint"),
      require("none-ls.diagnostics.cpplint"),
      require("none-ls.formatting.jq"),
      require("none-ls.formatting.yq"),
      formatting.stylua,
      formatting.prettier,
      -- formatting.black,
      -- formatting.prettier.with {
      --   extra_filetypes = { "toml" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      -- },
      -- formatting.eslint,
      -- diagnostics.flake8.with { extra_args = { "--max-line-length", "120" }},
      completion.spell,
    },
  }
end

return M
