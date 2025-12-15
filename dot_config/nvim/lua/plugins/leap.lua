return {
	'ggandor/leap.nvim',
	lazy = true,
	event = 'VeryLazy',
	config = function()
		-- require('leap').set_default_mappings()
		vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
		vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
	end
}
