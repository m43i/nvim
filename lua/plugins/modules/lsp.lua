return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", config = true, build = ":MasonUpdate" },
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim",       opts = {} },
        "folke/neodev.nvim",
        { "b0o/schemastore.nvim" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "saadparwaiz1/cmp_luasnip" },
        { "L3MON4D3/LuaSnip" },
    },
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(require("config.lsp.servers")),
        })
        require("lspconfig.ui.windows").default_options.border = "single"

        require("neodev").setup()

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["Tab"] = nil,
                ["S-Tab"] = nil,
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
            },
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = require("config.lsp.on_attach").on_attach,
                    settings = require("config.lsp.servers")[server_name],
                    filetypes = (require("config.lsp.servers")[server_name] or {}).filetypes,
                })

                require("lspconfig")["tsserver"].setup {
                    root_dir = require("lspconfig").util.root_pattern("package.json"),
                }

                require("lspconfig")["volar"].setup {
                    root_dir = require("lspconfig").util.root_pattern("nuxt.config.js"),
                }

                require("lspconfig")["denols"].setup {
                    root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc", "import_map.json"),
                }
            end,
        })

        vim.diagnostic.config({
            title = false,
            underline = true,
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                source = "always",
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = "",
            },
        })

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
    end,
}
