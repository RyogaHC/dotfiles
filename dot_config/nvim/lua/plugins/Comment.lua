return {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
        -- add any options here
    },
    config = function()
	    require('Comment').setup()
    end
}

