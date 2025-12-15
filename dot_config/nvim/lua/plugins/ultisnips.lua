return {
	"SirVer/ultisnips",
	init = function ()
		vim.cmd([[
		let g:UltiSnipsExpandTrigger="<tab>"
		let g:UltiSnipsJumpForwardTrigger="<tab>"
		let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
		]])
	end,
	lazy = true,
	event = "InsertEnter"
}
