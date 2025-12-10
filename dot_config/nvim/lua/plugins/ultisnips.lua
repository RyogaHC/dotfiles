return {
	"SirVer/ultisnips",
	init = function ()
		vim.cmd([[
		let g:UltiSnipsExpandTrigger="<tab>"
		let g:UltiSnipsJumpForwardTrigger="<tab>"
		let g:UltiSnipsJumpBackwardTrigger="<c-b>"
		]])
	end
}
