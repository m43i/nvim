return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP Support
        {
            "neovim/nvim-lspconfig",
        },
        { -- Optional
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.api.nvim_command, 'MasonUpdate')
            end,
        }, { "williamboman/mason-lspconfig.nvim" },

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
    },
    config = function()
        local lsp = require("lsp-zero")
        local nvim_lsp = require('lspconfig')

        lsp.preset("recommended")

        lsp.ensure_installed({
            "tsserver",
            "eslint",
            "rust_analyzer",
        })

        lsp.set_server_config({
            capabilities = {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                }
            }
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

        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        lsp.on_attach(function(client, bufnr)
            local is_nuxt = nvim_lsp.util.root_pattern("nuxt.config.ts")(vim.fn.getcwd())
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


        nvim_lsp.denols.setup {
            root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "import_map.json"),
        }

        nvim_lsp.tsserver.setup {
            root_dir = nvim_lsp.util.root_pattern("package.json"),
            single_file_support = false,
        }

        nvim_lsp.volar.setup {
            root_dir = nvim_lsp.util.root_pattern("nuxt.config.ts"),
            filetypes = { "vue", "typescript", "javascript" },
            on_attach = function(client)
                pcall(function() client.server_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true end)
            end,
        }

        nvim_lsp.svelte.setup {
            on_attach = function(client)
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    callback = function(ctx)
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
                    end,
                })
            end
        }

        nvim_lsp.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    }
                },
            }
        }

        nvim_lsp.eslint.setup {
            workingDirectory = {
                mode = "auto",
            },
        }

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true,
        })
    end,
}
