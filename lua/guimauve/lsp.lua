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
