return {
	"vim-skk/skkeleton",
	dependencies = {"denops.vim"},
	config = function()
		vim.fn['skkeleton#config']({
			globalDictionaries = {
				"~/.skk/SKK-JISYO.L"
			},
		})
		vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-enable)', {noremap = true})
		vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-enable)', {noremap = true})

	end,
	event = "InsertEnter"
}
