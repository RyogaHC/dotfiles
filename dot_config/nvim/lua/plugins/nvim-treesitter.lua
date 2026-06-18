return  {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup{
			highlight = {
				enable = true,
				disable = {
					"latex"
				}

			},
			-- indent = {
			-- 	enable = true,
			-- },
			ensure_installed = {'typst', 'lua', 'vim', 'c', 'commonlisp', 'python', 'bash', 'latex'},
		}
	end,
}
