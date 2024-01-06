return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require('copilot').setup({
            panel = { enabled = false },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<c-a>",
                    accept_word = false,
                    accept_line = false,
                    next = "<c-n>",
                    prev = "<c-p>",
                    dismiss = "<C-e>",
                },
            },
            filetypes = {
                yaml = true,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 16.x
            server_opts_overrides = {},
        })

        -- vim.keymap.set('i', '<Tab>', function()
        --     if require("copilot.suggestion").is_visible() then
        --         require("copilot.suggestion").accept()
        --     else
        --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        --     end
        -- end, { desc = "Super Tab" })
    end,
}
