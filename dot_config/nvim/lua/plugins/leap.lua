return {
	'ggandor/leap.nvim',
	lazy = true,
	config = function()
		require('leap').set_default_mappings()
	end
}
