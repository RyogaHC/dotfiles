local inmath = function ()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local generate_matrix = function(args)
	local rows = tonumber(args[1][1]) or 1
	local cols = tonumber(args[2][1]) or 1
	local nodes = {}
	local ins_idx = 1
	for r = 1, rows do
		for c = 1, cols do
			table.insert(nodes, i(ins_idx))
			if c < cols then
				table.insert(nodes, t(" & "))
			end
			ins_idx = ins_idx + 1
		end
		if r < rows then
			table.insert(nodes, t({" \\\\ ", ""}))
		end
	end
	return sn(nil, nodes)
end
-- local function test (args)
-- 	res = args[1]
-- 	return res
-- end
return {
	s({
		trig = "//",
		snippetType = "autosnippet"
	}, fmt(
			[[
		\frac{{{1}}}{{{2}}}
		]],
			{
				i(1, "1"),
				i(2, "x"),
			}
		), {condition = inmath}),
	s(
		{
			trig = "mk",
			snippetType = "autosnippet"
		},
		fmt(
			[[
			${1}$
		]],
			{
				i(1)
			}
		)
	),
	s(
		{
			trig = "beg",
			snippetType = "autosnippet"
		},
		fmt(
			[[
			\begin{{{1}}}
				{2}
			\end{{{3}}}
			]],
			{
				i(1),
				i(2),
				rep(1)
			}
		)
	),
	s({
		trig = [[([\%d[A-Za-z\\]+[\%d\w\^{}]*)/]],
		-- trig = [[((?:\\?[A-Za-z]+|(?:\%d+))(?:\^|_){\%d+}|(?:\\?[A-Za-z]+|(?:\%d+))(?:\^|_)\%d|\\?[A-Za-z]+|\%d+)/]],
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		priority = 1000,
	}, {
			t("\\frac{"),
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("}{"),
			i(1),
			t("}"),
			i(0),
		},
		{condition = inmath}
	),
	s({ trig = ".*%)%/", regTrig = true, wordTrig = false, snippetType = "autosnippet" }, {
		f(function(_, snip)
			local stripped = snip.trigger:sub(1, -2)
			local depth = 0
			local j = #stripped

			while j > 0 do
				local char = stripped:sub(j, j)
				if char == ")" then
					depth = depth + 1
				elseif char == "(" then
					depth = depth - 1
				end

				if depth == 0 then
					break
				end
				j = j - 1
			end

			local prefix = stripped:sub(1, j - 1)
			local inside = stripped:sub(j + 1, -2)
			return prefix .. "\\frac{" .. inside .. "}"
		end, {}),
		t("{"), i(1), t("}"), i(0)
	}),
	s({ trig = "([A-Za-z])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		f(function(_, snip)
			return snip.captures[1] .. "_" .. snip.captures[2]
		end, {}),
{condition = inmath}
	),
	s({ trig = "([A-Za-z])_(%d%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		f(function(_, snip)
			return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
		end, {}),
		{condition = inmath}
	),
	s({
		trig = "==",
		snippetType = "autosnippet",
		wordTrig = false
	}, fmt(
			[[
		&= {1} \\
		]],
			{
				i(1, "0"),
			}
		), {condition = inmath}),
	s(
		{
			trig = "ali",
			snippetType = "autosnippet"
		},
		fmt(
			[[
			\begin{{align*}}
				{1}
			\end{{align*}}
			]],
			{
				i(1),
			}
		)
	),
	s({
		trig = "lr",
		snippetType = "autosnippet",
		wordTrig = false
	}, fmt(
			[[
			\left( {1} \right)
		]],
			{
				i(1),
			}
		), {condition = inmath}),
	s({
		trig = "*",
		wordTrig = false,
		snippetType = "autosnippet",
	},
	t("\\cdot "),
		{
			condition = inmath
		}),
	s({
		trig = "lim",
		snippetType = "autosnippet"
	}, fmt(
			[[
			\lim_{{{1} \to {2}}} 
		]],
			{
				i(1, "x"),
				i(2, "\\infty"),
			}
		), {condition = inmath}),
	s(
		{
			trig = "sk",
			snippetType = "autosnippet",
			wordTrig = false

		},
		fmt(
			[[
			\sqrt{{{1}}} 
			]],
			{
				i(1, "2"),
			}
		),
		{
			condition = inmath
		}
	),
	s({
		trig = "sr",
		wordTrig = false,
		snippetType = "autosnippet",
	},
	t("^2 "),
		{
			condition = inmath
		}),
	s({
		trig = "kb",
		wordTrig = false,
		snippetType = "autosnippet",
	},
	t("^3 "),
		{
			condition = inmath
		}),
	s(
		{
			trig = "td",
			snippetType = "autosnippet",
			wordTrig = false
		},
		fmt(
			[[
			^{{{1}}} 
			]],
			{
				i(1),
			}
		),
		{
			condition = inmath
		}
	),
	s(
		{
			trig = "__",
			wordTrig = false,
			snippetType = "autosnippet"
		},
		fmt(
			[[
			_{{{1}}} 
			]],
			{
				i(1),
			}
		),
		{
			condition = inmath
		}
	),
	s(
		{
			trig = "oo",
			snippetType = "autosnippet"
		},
		t(
			"\\infty "

		),
		{
			condition = inmath
		}
	),
	s(
		"temp", fmt(
			[[
\documentclass{{jlreq}}

\usepackage{{amsmath, amssymb}}
\usepackage{{ascmac}}

\title{{{1}}}

\begin{{document}}
\maketitle
	{2}
\end{{document}}

				]],
			{
				i(1),
				i(2)
			}
		)
	),
	s(
		{
			trig = "dint",
			snippetType = "autosnippet",
		},
		fmt(
			[[
			\int_{{{1}}}^{{{2}}} {3} dx
			]],
			{
				i(1, "0"),
				i(2, "\\infty"),
				i(3)
			}
		),
		{condition = inmath}
	),
	-- s(
	-- 	{
	-- 		trig = "->",
	-- 		snippetType = "autosnippet",
	-- 	},
	-- 	t("\\to "),
	-- 	{condition = inmath}
	-- ),
	s(
		{
			trig = "!=",
			snippetType = "autosnippet",
		},
		t("\\neq "),
		{condition = inmath}
	),
	s(
		{
			trig = ">=",
			snippetType = "autosnippet",
		},
		t("\\ge "),
		{condition = inmath}
	),
	s(
		{
			trig = "<=",
			snippetType = "autosnippet",
		},
		t("\\le "),
		{condition = inmath}
	),
	s(
		{
			trig = "it",
			snippetType = "autosnippet"
		},
		fmt(
			[[
			\intertext{{{1}}} 
			]],
			i(1)
		),
		{condition = inmath}
	),
	s(
		{
			trig = "sum",
			snippetType = "autosnippet",
		},
		fmt(
			[[
			\sum_{{{1}}}^{{{2}}} 
			]],
			{
				i(1, "k=1"),
				i(2, "n")
			}
		),
		{condition = inmath}
	),
	s(
		{
			trig = "int",
			snippetType = "autosnippet",
		},
		fmt(
			[[
			\int {1} dx
			]],
			i(1)
		),
		{condition = inmath}
	),
	s({trig = "([bBpvV])mat.(%d)(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet"},
		d(1, function(_, snip)
			local type = snip.captures[1]
			local rows = tonumber(snip.captures[2])
			local cols = tonumber(snip.captures[3])

			local names = {p="pmatrix", b="bmatrix", B="Bmatrix", v="vmatrix", V="Vmatrix"}
			local name = names[type]

			local nodes = {}
			table.insert(nodes, t("\\begin{" .. name .. "}"))
			table.insert(nodes, t({"", "\t"}))

			local ins_idx = 1
			for r = 1, rows do
				for c = 1, cols do
					table.insert(nodes, i(ins_idx))
					if c < cols then
						table.insert(nodes, t(" & "))
					end
					ins_idx = ins_idx + 1
				end
				if r < rows then
					table.insert(nodes, t({ " \\\\ ", "\t" }))
				end
			end

			table.insert(nodes, t({"", "\\end{" .. name .. "}"}))
			return sn(nil, nodes)
		end),
		{condition = inmath}
	),
	s({
		trig = [[([A-Za-z0-9\\]+)([\,.][\.,])]], 
		regTrig = true, 
		wordTrig = false, 
		snippetType = "autosnippet"
	}, 
		f(function(_, snip)
			return "\\vec{" .. snip.captures[1] .. "}"
		end, {}),
		{condition = inmath}
	),
	s({
		trig = "||",
		snippetType = "autosnippet",
		wordTrig = false
	}, fmt(
			[[
			\left| {1} \right|
		]],
			{
				i(1),
			}
		), {condition = inmath}),
	s({
		trig = "aa",
		snippetType = "autosnippet",
		wordTrig = false
	}, fmt(
			[[
			\left[ {1} \right]
		]],
			{
				i(1),
			}
		), {condition = inmath}),
	s({
		trig = "bb",
		snippetType = "autosnippet",
		wordTrig = false
	}, fmt(
			[[
			\left\{{ {1} \right\}}
		]],
			{
				i(1),
			}
		), {condition = inmath}),
	s({
		trig = "([%w]+)",
		regTrig = true,
		wordTrig = false,
		snippetType = "autosnippet",
		condition = function(line_to_cursor, matched_trigger)
			local list = {sin=1, cos=1, tan=1, arccot=1, cot=1, csc=1, ln=1, log=1, exp=1, star=1, perp=1, pi=1, alpha=1, beta=1, theta=1, Delta=1, to=1}
			if not list[matched_trigger] then return false end

			local prefix = line_to_cursor:sub(1, -(#matched_trigger + 1))
			return not prefix:find("\\$")
		end
	}, {
			f(function(_, snip) return "\\" .. snip.captures[1] end),
		}),
	s({trig = "tab.(%d)(%d)", regTrig = true, snippetType="autosnippet"},
		d(1, function(_, snip)
			local cols = tonumber(snip.captures[1])
			local rows = tonumber(snip.captures[2])

			local nodes = {}
			table.insert(nodes, t("\\begin{tabular}{"))

			table.insert(nodes, i(1, string.rep("c", cols)))
			table.insert(nodes, t({"}", "\\hline", ""}))

			local ins_idx = 2
			for r = 1, rows do
				for c = 1, cols do
					table.insert(nodes, t("\t"))
					table.insert(nodes, i(ins_idx))
					if c < cols then
						table.insert(nodes, t(" & "))
					else
						table.insert(nodes, t({ " \\\\ \\hline", "" }))
					end
					ins_idx = ins_idx + 1
				end
			end

			table.insert(nodes, t("\\end{tabular}"))
			return sn(nil, nodes)
		end)
	),


}
