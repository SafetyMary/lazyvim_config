return {
  -- Install lazy extras
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.editor.telescope" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.sql" },

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
