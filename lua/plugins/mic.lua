-- My preferred line length
local line_length = 120

-- Add border to lspconfig diagnostics (https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization)
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- show source in lspconfig
vim.diagnostic.config({
  virtual_text = {
    source = "if_many", -- Or "if_many"
  },
  float = {
    source = "if_many", -- Or "if_many"
  },
})

-- check screen size for layout
local function layout()
  local layout_table = {
    fzf_lua = nil,
    snacks = {
      terminal = {
        position = nil,
      },
      lazygit = {
        portraitMode = nil,
        mainPanelSplitMode = nil,
        enlargedSideViewLocation = nil,
      },
    },
  }
  -- cannot compare width against height, as they return char and row count
  if (vim.api.nvim_win_get_width(0) / 2) >= 100 then -- 0 means current window
    -- horizontal
    layout_table.fzf_lua = "horizontal"
    layout_table.snacks.terminal.position = "right"
    layout_table.portraitMode = "auto"
    layout_table.snacks.lazygit.mainPanelSplitMode = "horizontal"
    layout_table.snacks.lazygit.enlargedSideViewLocation = "left"
    return layout_table
  else
    -- vertical
    layout_table.fzf_lua = "vertical"
    layout_table.snacks.terminal.position = "bottom"
    layout_table.snacks.lazygit.portraitMode = "always"
    layout_table.snacks.lazygit.mainPanelSplitMode = "vertical"
    layout_table.snacks.lazygit.enlargedSideViewLocation = "top"
    return layout_table
  end
end
return {

  -- Add extras
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.sql" },

  -- fzf lua config
  {
    "ibhagwan/fzf-lua",
    opts = {
      -- layout (https://github.com/LazyVim/LazyVim/discussions/3815)
      winopts = {
        preview = {
          vertical = "up:65%",
          horizontal = "right:60%",
          layout = layout().fzf_lua,
        },
      },
      -- super tab for selection (https://github.com/LazyVim/LazyVim/discussions/3657)
      keymap = {
        fzf = {
          ["tab"] = "down",
          ["shift-tab"] = "up",
        },
      },
    },
  },

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
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          -- NOTE: do not change file name or extension, make sure to test valid file names in CLI
          args = {
            "--config",
            vim.fn.expand("~/.config/nvim/lua/plugins/.markdownlint-cli2.jsonc"),
            "--",
          },
        },
        sqlfluff = {
          args = {
            "lint",
            "--format",
            "json",
            "--dialect",
            "postgres",
            "--config",
            vim.fn.expand("~/.config/nvim/lua/plugins/sqlfluff.cfg"),
          },
        },
      },
    },
  },

  -- LSP settings
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {
          mason = false,
          autostart = false,
        },
        ruff = {
          init_options = {
            settings = {
              lineLength = line_length,
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                flake8 = {
                  enabled = true,
                  maxLineLength = line_length,
                },
                pycodestyle = {
                  enabled = false, -- Included in flake8
                  maxLineLength = line_length,
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
                    tostring(line_length),
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

  -- Border settings for mason
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  -- Border settings for noice
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  -- Disable inlay hints
  {
    "neovim/nvim-lspconfig",
    opts = { inlay_hints = { enabled = false } },
  },

  -- lazygit config
  {
    "folke/snacks.nvim",
    opts = {
      zen = {
        win = {
          width = line_length + 20, -- add 20 for some ui elements on the right
        },
      },
      terminal = {
        win = {
          position = layout().snacks.terminal.position,
          height = 0.5,
          width = 0.5,
        },
      },
      lazygit = {
        win = {
          -- Mimic default args since terminal win config overrided default
          position = "float",
          height = 0.9,
          width = 0.9,
        },
        config = {
          gui = {
            portraitMode = layout().snacks.lazygit.portraitMode,
            mainPanelSplitMode = layout().snacks.lazygit.mainPanelSplitMode,
            enlargedSideViewLocation = layout().snacks.lazygit.enlargedSideViewLocation,
          },
          git = {
            branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --oneline {{branchName}} --",
            allBranchesLogCmd = "git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --oneline",
            merging = {
              args = "--no-ff",
            },
          },
        },
      },
    },
  },
}
