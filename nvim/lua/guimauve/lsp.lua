local nvim_lsp = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

-- Provide settings first!
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

lsp_installer.on_server_ready(function (server) server:setup {} end)

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async
_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef tab lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
end

nvim_lsp.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
}

local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}

local formatters = {
    prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}

local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier"
}

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

-- use .ts snippets in .tsx files
vim.g.vsnip_filetypes = {
    typescriptreact = {"typescript"}
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn["compe#confirm"]()
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    else
        return t("<Tab>")
    end
end


nvim_lsp.hls.setup{on_attach=on_attach}
nvim_lsp.pyright.setup({on_attach=on_attach})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        signs = true,
    }
    )

vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

vim.api.nvim_set_keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {noremap = true, silent = true})

require"compe".setup {
    preselect = "always",
    source = {
        path = true,
        buffer = true,
        vsnip = true,
        nvim_lsp = true,
        nvim_lua = true
    }
}

-- Start rust_analyzer with neovim when opening *.rs files
require('lspconfig').rust_analyzer.setup {
    on_attach = rust_analyzer_on_attach
}
