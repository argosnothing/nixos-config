{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.nvf.enable {
    programs.nvf.settings.vim.keymaps = [
      {
        key = "<leader>t";
        mode = "n";
        action = ":ToggleTerm";
      }
    ];
  };
}
