return {
	'nvim-lualine/lualine.nvim',
	lazy = true,
	event = "VimEnter",
	dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/tokyonight.nvim' },
	config = function()
		require('lualine').setup {
			options = {
				-- ... your lualine config
				theme = 'neopywal'
				-- theme = 'dracula-nvim'
				-- ... your lualine config
			}
		}
	end
}
