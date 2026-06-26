vim.lsp.enable({ 'pyright' })

-- 補完メニューは自動で出すが、先頭候補を自動選択しない (noselect)
vim.o.completeopt = 'menu,menuone,noselect'

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover,      opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename,      opts)
    vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  end,
})
