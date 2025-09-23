if vim.g.neovide then
	vim.g.neovide_scale_factor= 0.5
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_position_animation_length = 0.1
	vim.g.neovide_opacity = 0.8
	vim.g.neovide_normal_opacity = 0.8
end

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g.mapleader = ' '
vim.o.mouse = ''

vim.keymap.set('n', '<C-h>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('kylechui/nvim-surround')
Plug('windwp/nvim-autopairs')
Plug('nvim-treesitter/nvim-treesitter')
Plug('vim-denops/denops.vim')
Plug('vim-skk/skkeleton')
Plug('folke/tokyonight.nvim')
-- Plug('Mofiqul/dracula.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('akinsho/bufferline.nvim')
Plug('ggandor/leap.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('numToStr/Comment.nvim')
Plug('tpope/vim-repeat')
Plug('NStefan002/screenkey.nvim')
Plug('David-Kunz/gen.nvim')
Plug('chomosuke/typst-preview.nvim')
Plug('akinsho/toggleterm.nvim')

Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
vim.call('plug#end')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("toggleterm").setup{
	open_mapping = [[<c-t>]]
}

require('Comment').setup()
require('leap').set_default_mappings()
require('nvim-treesitter.configs').setup{
	highlight = {
		enable = true
	},
	ensure_installed = {'typst', 'lua', 'vim', 'c'}
}

vim.cmd('colorscheme tokyonight-night')
-- vim.cmd('colorscheme dracula')

-- Lua
require('lualine').setup {
	options = {
		-- ... your lualine config
		theme = 'tokyonight'
		-- theme = 'dracula-nvim'
		-- ... your lualine config
	}
}

require("ibl").setup()

require("bufferline").setup{}

require("nvim-autopairs").setup({})
require("nvim-surround").setup({})

vim.fn['skkeleton#config']({
	globalDictionaries = {
		"~/.skk/SKK-JISYO.L"
	}
	--  eggLikeNewline = true,
	-- keepState = true,
	-- showCandidatesCount = 2,
	-- registerConvertResult = true,
})
-- vim.fn['skkeleton#register_keymap']('input', '/', 'abbrev')
vim.api.nvim_set_keymap('i', '<C-j>', '<Plug>(skkeleton-enable)', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-j>', '<Plug>(skkeleton-enable)', {noremap = true})

local cmp = require'cmp'


cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

			-- For `mini.snippets` users:
			-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
			-- insert({ body = args.body }) -- Insert at cursor
			-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			-- require("cmp.config").set_onetime({ sources = {} })
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	}, {
		{ name = 'skkeleton' }
	})
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
})
require("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', {
	capabilities = capabilities,
})

vim.lsp.enable('nil_ls')
vim.lsp.enable('tinymist')
vim.lsp.enable('pylsp')

-- require('lspconfig').nil_ls.setup{}
-- require('lspconfig').tinymist.setup{}
-- require('lspconfig').pylsp.setup{}

-- vim.api.nvim_create_autocmd("VimEnter",
-- {
	-- 	callback = function() require("screenkey").toggle() end
	-- })

	require('gen').setup({
		model = "gpt-oss", -- The default model to use.
		quit_map = "q", -- set keymap to close the response window
		retry_map = "<c-r>", -- set keymap to re-send the current prompt
		accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
		host = "localhost", -- The host running the Ollama service.
		port = "11434", -- The port on which the Ollama service is listening.
		display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split" or "vertical-split".
		show_prompt = false, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
		show_model = false, -- Displays which model you are using at the beginning of your chat session.
		no_auto_close = false, -- Never closes the window automatically.
		file = false, -- Write the payload to a temporary file to keep the command short.
		hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
		init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
		-- Function to initialize Ollama
		command = function(options)
			local body = {model = options.model, stream = true}
			return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
		end,
		-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
		-- This can also be a command string.
		-- The executed command must return a JSON object with { response, context }
		-- (context property is optional).
		-- list_models = '<omitted lua function>', -- Retrieves a list of model names
		result_filetype = "markdown", -- Configure filetype of the result buffer
		debug = false -- Prints errors and the command which is run.
	})
