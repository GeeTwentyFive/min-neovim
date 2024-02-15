# Dependencies
[git](https://github.com/git/git)

# Installation
Place `init.lua` into Neovim config folder
- "*%LOCALAPPDATA%\nvim*" on Windows
- "*~/.config/nvim*" on Linux & Mac

# Usage
`Tab`  - Open directory browser

`-`    - Vertical split

**-- LSP --**

`F1`   - Hover

`F2`   - Go to declaration

`F3`   - Go to definition

`F4`   - Show references

# How to add an LSP server:

On line 72 & onward in `init.lua`, write `lspconfig.<NAME_OF_LSP_SERVER>.setup { capabilities = capabilities }` with `<NAME_OF_LSP_SERVER>` being the name of the LSP server you wish to use.

**Example:**
```
  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')

  lspconfig.clangd.setup { capabilities = capabilities }
  lspconfig.gopls.setup { capabilities = capabilities }
```
