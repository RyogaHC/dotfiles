-- For `plugins/markview.lua` users.
return {
    "OXY2DEV/markview.nvim",
    lazy = true,
    ft = {"typst", "markdown", "latex"},
    event = 'BufRead'

    -- Completion for `blink.cmp`
    -- dependencies = { "saghen/blink.cmp" },
};
