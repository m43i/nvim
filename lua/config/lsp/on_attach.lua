M = {}
M.on_attach = function(client, bufnr)
    local is_nuxt = require("lspconfig").util.root_pattern("nuxt.config.ts")(vim.fn.getcwd())
    local active_clients = vim.lsp.get_active_clients()

    if client.name == "volar" and is_nuxt then
        for _, active_client in ipairs(active_clients) do
            if active_client.name == "tsserver" then
                active_client.stop()
            end
        end
    end

    if client.name == "tsserver" and is_nuxt then
        client.stop()
    end

    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

return M;
