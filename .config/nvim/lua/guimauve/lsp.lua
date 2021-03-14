local on_attach = function(client)
    require('completion').on_attach(client)
end
require('lspconfig').tsserver.setup{on_attach=on_attach}
require('lspconfig').pyright.setup{}
