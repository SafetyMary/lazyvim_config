-- My preferred line length
local line_length = 120

-- Add boarder to lspconfig diagnostics (https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization)
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

  -- fzf_lua layout
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      opts.winopts = {
        preview = {
          vertical = "up:65%",
          horizontal = "right:60%",
          layout = layout().fzf_lua,
        },
      }
    end,
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

  -- Super Tab (https://www.lazyvim.org/configuration/recipes)
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- window borders (https://github.com/LazyVim/LazyVim/issues/2708)
  -- For everything except lspconfig diagnostics
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
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
