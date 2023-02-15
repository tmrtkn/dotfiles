local navic = require("nvim-navic")


require("lspconfig").tsserver.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}
