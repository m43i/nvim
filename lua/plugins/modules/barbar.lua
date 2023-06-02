return {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-web-devicons" },
    config = function()
        vim.keymap.set('n', '<leader>n', ':BufferNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>p', ':BufferPrevious<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>c', ':BufferClose<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>N', ':BufferMoveNext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>P', ':BufferMovePrevious<CR>', { noremap = true, silent = true })

        local nvim_tree_events = require('nvim-tree.events')
        local bufferline_api = require('bufferline.api')

        local function get_tree_size()
            return require 'nvim-tree.view'.View.width
        end

        nvim_tree_events.subscribe('TreeOpen', function()
            bufferline_api.set_offset(get_tree_size())
        end)

        nvim_tree_events.subscribe('Resize', function()
            bufferline_api.set_offset(get_tree_size())
        end)

        nvim_tree_events.subscribe('TreeClose', function()
            bufferline_api.set_offset(0)
        end)
    end,
}
