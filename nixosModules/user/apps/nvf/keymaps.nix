{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.nvf.enable {
    programs.nvf.settings.vim.keymaps = [
      {
        key = "<C-t>";
        mode = "n";
        action = ":ToggleTerm dir=%:p:h<CR>";
      }
      {
        key = "<C-o>";
        mode = "n";
        action = ":Oil";
      }
    ];
  };
}
