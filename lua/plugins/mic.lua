return {
  -- Install lazy extras
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Install mason packs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", -- Used to format Lua code
        "python-lsp-server",
        "ruff",
        "sqlfluff",
        "prettier",
        "markdownlint-cli2",
        "markdown-toc",
        "jq",
        "shellcheck",
        "shfmt",
        "bash-language-server",
      },
    },
  },
}
