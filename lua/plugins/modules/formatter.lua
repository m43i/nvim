return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
		},
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "v",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { { "biome", "prettierd" } },
				javascriptreact = { { "biome", "prettierd" } },
				typescript = { { "biome", "prettierd" } },
				typescriptreact = { { "biome", "prettierd" } },
				vue = { { "biome", "prettierd" } },
				svelte = { { "biome", "prettierd" } },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				lua = { "stylua" },
				["*"] = { "injected" },
			},
			formatters = {
				biome = {
					condition = function(ctx)
						return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
					end,
				},
				prettierd = {
					env = {
						string.format(
							"PRETTIERD_DEFAULT_CONFIG=%s",
							vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json")
						),
					},
				},
			},
		})
	end,
}
