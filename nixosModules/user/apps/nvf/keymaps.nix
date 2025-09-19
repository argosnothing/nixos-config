{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.nvf.enable {
    programs.nvf.settings.vim.keymaps = [
      {
        key = "<C-t>";
        mode = "n tnoremap";
        action = ":ToggleTerm";
      }
    ];
  };
}
