return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },

        -- Null-LSP
        { "jose-elias-alvarez/null-ls.nvim" },
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            "tsserver",
            "eslint",
            "rust_analyzer",
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings["<Tab>"] = nil
        cmp_mappings["<S-Tab>"] = nil

        lsp.setup_nvim_cmp({
            preselect = "none",
            mapping = cmp_mappings,
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            -- if client.name == "eslint" then
            --     vim.cmd.LspStop('eslint')
            --     return
            -- end

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
        end)

        lsp.configure("intelephense", {
            settings = {
                intelephense = {
                    format = {
                        braces = "k&r",
                    },
                    environment = {
                        includePath = {
                            "/Users/malteeiting/.composer/vendor/php-stubs/",
                            "/Users/malteeiting/.composer/vendor/wpsyntex/",
                        },
                    },
                    stubs = {
                        "apache",
                        "bcmath",
                        "bz2",
                        "calendar",
                        "com_dotnet",
                        "Core",
                        "ctype",
                        "curl",
                        "date",
                        "dba",
                        "dom",
                        "enchant",
                        "exif",
                        "FFI",
                        "fileinfo",
                        "filter",
                        "fpm",
                        "ftp",
                        "gd",
                        "gettext",
                        "gmp",
                        "hash",
                        "iconv",
                        "imap",
                        "intl",
                        "json",
                        "ldap",
                        "libxml",
                        "mbstring",
                        "meta",
                        "mysqli",
                        "oci8",
                        "odbc",
                        "openssl",
                        "pcntl",
                        "pcre",
                        "PDO",
                        "pdo_ibm",
                        "pdo_mysql",
                        "pdo_pgsql",
                        "pdo_sqlite",
                        "pgsql",
                        "Phar",
                        "posix",
                        "pspell",
                        "readline",
                        "Reflection",
                        "session",
                        "shmop",
                        "SimpleXML",
                        "snmp",
                        "soap",
                        "sockets",
                        "sodium",
                        "SPL",
                        "sqlite3",
                        "standard",
                        "superglobals",
                        "sysvmsg",
                        "sysvsem",
                        "sysvshm",
                        "tidy",
                        "tokenizer",
                        "xml",
                        "xmlreader",
                        "xmlrpc",
                        "xmlwriter",
                        "xsl",
                        "Zend OPcache",
                        "zip",
                        "zlib",
                        "wordpress",
                        "imagick",
                        "woocommerce",
                        "wp-cli",
                        "wpsyntex",
                        "wordpress-stubs",
                        "wp-cli-stubs",
                        "woocommerce-stubs",
                    },
                },
            },
        })

        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        lsp.format_mapping("<leader>gf", {
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["null-ls"] = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
            },
        })

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
        })

        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Replace these with the tools you have installed
                -- make sure the source name is supported by null-ls
                -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
                null_ls.builtins.formatting.prettierd.with({
                    env = {
                        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
                    },
                }),
            },
        })
    end,
}
