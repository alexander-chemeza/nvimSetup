vim.opt.termguicolors = true

function SetColor(color)
	color = color or "vscode"
	vim.cmd.colorscheme(color)
end

SetColor()
