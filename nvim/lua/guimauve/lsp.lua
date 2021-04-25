local nvim_lsp = require'lspconfig'
local on_attach = function(client)
  require('completion').on_attach(client)
end

nvim_lsp.tsserver.setup({on_attach=on_attach})
nvim_lsp.pyright.setup({on_attach=on_attach})
nvim_lsp.hls.setup({on_attach=on_attach})

nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importMergeBehavior = "last",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = true
        },
      }
    }
  })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    signs = true,
  }
  )
vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

vim.api.nvim_set_keymap("n", "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {noremap = true, silent = true})

-- TODO - Configure formatting for js/ts and remove ALE altogether?
