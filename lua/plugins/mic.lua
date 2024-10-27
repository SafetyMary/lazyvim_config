return {

  -- Add extras
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.editor.telescope" },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },
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
        "python-lsp-server", -- for additional python LSP
        "shellcheck", -- for bash
        "bash-language-server", --for bash
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                flake8 = {
                  enabled = true,
                  maxLineLength = 120,
                },
                pycodestyle = {
                  enabled = false, -- Included in flake8
                  maxLineLength = 120,
                },
                mccabe = {
                  enabled = false, -- Included in flake8
                },
                pyflakes = {
                  enabled = false, -- Included in flake8
                },
                pydocstyle = {
                  enabled = true,
                  convention = "google",
                },
                pylint = {
                  enabled = true,
                  args = {
                    "--max-line-length",
                    "120",
                  },
                },
                rope_autoimport = {
                  enabled = false,
                },
                rope_completion = {
                  enabled = true,
                  eager = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
