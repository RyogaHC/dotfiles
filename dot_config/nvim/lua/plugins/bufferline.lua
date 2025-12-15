return {
	'akinsho/bufferline.nvim',
	lazy = true,
	event = "BufRead",
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require("bufferline").setup{}
	end
}
