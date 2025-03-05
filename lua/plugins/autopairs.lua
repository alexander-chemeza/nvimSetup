local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

npairs.add_rules({
	Rule('"""', '"""', "python"), -- Automatically close triple quotes in Python files
})
