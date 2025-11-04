return {
	"nvim-telescope/telescope-file-browser.nvim",
	config = function ()
		vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
	end,
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
}
