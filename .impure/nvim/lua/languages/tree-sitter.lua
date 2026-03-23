-- Grammars are managed by Nix via nvim-treesitter.withPlugins in plugins.nix
-- The :checkhealth nvim-treesitter report will show no "installed languages"
-- because it only checks its own managed directory, not the Nix store paths
-- This is a known false negative

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable tree-sitter highlighting and indentation",
	callback = function(args)
		local buf = args.buf
		local ok = pcall(vim.treesitter.start, buf)
		if ok then
			vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
