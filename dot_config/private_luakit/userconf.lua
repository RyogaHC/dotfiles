local modes = require "modes"
modes.remap_binds("command", {
    {"<Control-i>", "<Tab>"},
})

local select = require "select"
select.label_maker = function (s)
    local chars = s.charset("fjeiwoa;dkslghru")
    return s.trim(s.sort(s.reverse(chars)))
end


local follow = require "follow"
follow.pattern_maker = follow.pattern_styles.match_label


local settings = require "settings"
settings.window.default_search_engine = "duckduckgo"
