vim.cmd.source('~/.vimrc')

vim.opt.runtimepath:append({ '~/.vim', '~/.vim/after' })
vim.opt.packpath:append('~/.vim')

vim.diagnostic.config({ virtual_text = true })

vim.lsp.config('ruby_lsp', {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(
      { 'mise', 'exec', '--', 'ruby-lsp' },
      dispatchers,
      { cwd = config.cmd_cwd or config.root_dir }
    )
  end,
})

local servers = {
  ruby_lsp = 'mise',
  ts_ls = 'typescript-language-server',
  gopls = 'gopls',
  lua_ls = 'lua-language-server',
}

for name, cmd in pairs(servers) do
  if vim.fn.executable(cmd) == 1 then
    vim.lsp.enable(name)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>k', vim.lsp.buf.hover, opts)

    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
