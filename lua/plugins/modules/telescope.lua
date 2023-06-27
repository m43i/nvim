return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
    config = function()
        require("telescope").setup {
            defaults = {
                file_ignore_patterns = { "node_modules", ".git" },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({
                        previewer        = false,
                        initial_mode     = "normal",
                        sorting_strategy = 'ascending',
                        layout_strategy  = 'horizontal',
                        layout_config    = {
                            horizontal = {
                                width = 0.5,
                                height = 0.4,
                                preview_width = 0.6,
                            },
                        },
                    })
                },
            },
        }

        require("telescope").load_extension('ui-select')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        vim.keymap.set('n', '<leader>lsd', builtin.lsp_definitions, {})
        vim.keymap.set('n', '<leader>lsi', builtin.lsp_implementations, {})

        local function fan12_find_files()
            builtin.find_files({
                prompt_title = "Find Files for Fan12",
                cwd = vim.fn.getcwd() .. "/wp-content/plugins/fan12-dynamic-shop/",
            })
        end

        local function fan12_diagnostics()
            builtin.diagnostics({
                prompt_title = "Diagnostics for Fan12",
                cwd = vim.fn.getcwd() .. "/wp-content/plugins/fan12-dynamic-shop/",
            })
        end

        local function fan12_live_grep()
            builtin.live_grep({
                prompt_title = "Live Grep for Fan12",
                cwd = vim.fn.getcwd() .. "/wp-content/plugins/fan12-dynamic-shop/",
            })
        end

        function Fan12Search()
            vim.keymap.set('n', '<leader>ff', fan12_find_files, {})
            vim.keymap.set('n', '<leader>fg', fan12_live_grep, {})
            vim.keymap.set('n', '<leader>fd', fan12_diagnostics, {})
        end

        if vim.fn.getcwd() == "/Users/malteeiting/dev/fan12/fan12-docker" then
            Fan12Search()
        end
    end,
}
