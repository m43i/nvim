return {
    "mhartington/formatter.nvim",
    config = function()
        local util = require "formatter.util"
        local prettier = function()
            return {
                exe = "prettierd",
                args = {
                    util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin = true,
            }
        end

        require("formatter").setup {
            filetype = {
                typescript = {
                    prettier,
                },
                javascript = {
                    prettier,
                },
                typescriptreact = {
                    prettier,
                },
                javascriptreact = {
                    prettier,
                },
            },
        }
    end,
}
