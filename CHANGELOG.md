# Version History

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
