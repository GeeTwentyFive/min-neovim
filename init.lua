-- init lazy.nvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	'neovim/nvim-lspconfig',

	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',

	'm4xshen/autoclose.nvim',
})


-- init nvim-cmp --
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, 
 }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')

  --lspconfig.clangd.setup { capabilities = capabilities }
  -- <-- Add other LSP servers here


-- init autoclose.nvim --
require('autoclose').setup()


vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.fillchars = { eob = ' ' }
vim.opt.shortmess = 'atToOFI'
vim.opt.clipboard = 'unnamedplus'

vim.g.netrw_banner = 0

vim.keymap.set({'n', 'i'}, '<F1>', '<Nop>')
vim.keymap.set('n', '<Tab>', '<cmd>E<cr>')
vim.keymap.set('n', '-', '<cmd>vsplit<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', '<F1>', vim.lsp.buf.hover)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.declaration)
    vim.keymap.set('n', '<F3>', vim.lsp.buf.definition)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.references)
  end,
})
