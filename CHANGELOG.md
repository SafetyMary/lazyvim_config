# Version History

- WIP
  - Control lazy extras from :LazyExtra
  - Missing markdown file rename support from marksman LSP
    - [Github issue](https://github.com/artempyanykh/marksman/issues/153)

- v2.5.0
  - Solved mypy venv issue
  - Allow todo author in todo-comments
    - Enabled back TD002

- v2.4.0
  - Stacked bufferline
  - High resolution dashboard pic
  - Ruff link python version
  - Add custom remap to paste from yank register
  - Linter allow use of assert statements
  - Add docker file lsp support

- v2.3.0
  - Update sqlfluff configs
  - Use 'default' preset for snacks picker (for better vertical notification hist)
  - Dynamic win position for trouble symbols
  - Add pic to startup dashboard
  - bugfix: min width for zen mode width

- v2.2.0
  - Replace pylsp with basedpyright
    - More popular and support
    - Better support for code symbols
  - Remove nix language support
  - Disable lazyvim check order

- v2.1.1
  - Ignore docstring return statement check

- v2.1.0
  - Force markdown formatter to be always on even if there is no linter errors
  - Use CTRL-HJKL to resize windows (CTRL-J only works after zellij version 0.41.2)
    - <https://github.com/zellij-org/zellij/pull/3746>
  - Disable dimming in zen mode
  - Re-enable animate
  - Dynamic layout for grag far (vertical and horizontal monitor)
  - set python3 host prog, for dedicated venv for neovim

- v2.0.0
  - Revamp LSP setup
    - LSP (for navigation only)
      - Use bare pylsp (disable all linters)
    - Linting
      - Use ruff to replace all linters (enable all rules with preview rules enabled)
    - Static type checker
      - Install mypy separately using strict mode
  - Add nix language support (nixfmt formatter not support in Mason yet, need to local install)
  - Re-enable lazygit panel jumping via numbers
  - Add back borders in blink cmp

- v1.2.0
  - Config lazygit
    - No ff for merging
    - Customize git log
    - Dynamic vertical and horizontal layout
  - Migrating to LazyVim v14
    - Dynamic vertical and horizontal layout for new snacks terminal
    - Dynamic vertical and horizontal layout for fzf (replaced telescope)
    - Tab selection for fzf
    - Config zen mode width
    - Removed border configs
    - Customize keybinds for blink auto completion

- v1.1.0
  - Config linters
    - set max line length of markdownlint-cli-2 to 120
    - set max line length of sqlfluff to 120

- v1.0.0
  - Lazy extras
    - Language support
      - python
      - markdown
      - json
      - toml
      - sql
    - Coding
      - mini surround
    - Editor
      - telescope
      - Super Tab
        - Use tab for auto completion
    - UI
      - treesitter context
  - LSP
    - Show server sources for LSP errors
    - Configure pylsp
      - line length
      - Use flake8, pydocstyle (google), pylint, rope_completion
      - Add mypy and rope
    - Disable inlay hints
  - UI
    - Add boarder to all floating windows
      - lspconfig diagnostics
      - auto completetion
      - Mason
      - Noice
      - lspconfig
    - Dynamic layout strategy for telescope
    - Add color column at 120 char
    - Add fold signs
  - Editor
    - Disable autowrite
    - Add spell check for all file types
