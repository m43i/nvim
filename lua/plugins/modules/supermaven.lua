return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			-- keymaps = {
			-- 	accept_suggestion = "<C-a>",
			-- },
			-- color = {
			-- 	suggestion_color = "#727169",
			-- },
			disable_inline_completion = true,
			disable_keymaps = true,
		})
	end,
}
