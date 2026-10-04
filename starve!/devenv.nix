{ pkgs, ... }:

{
  packages = [
    pkgs.luajit
    pkgs.bun
    pkgs.unzip
  ];

  languages.javascript = {
    enable = true;
    bun.enable = true;
  };

  languages.lua = {
    enable = true;
    package = pkgs.luajit;
  };

  scripts = {
    extract.exec = ''
      ZIP_PATH="$HOME/.steam/steam/steamapps/common/Don't Starve Together/data/databundles/scripts.zip"
      TARGET_DIR="docs/databundles"

      if [ ! -f "$ZIP_PATH" ]; then
        echo "Error: scripts.zip not found at $ZIP_PATH" >&2
        exit 1
      fi

      mkdir -p "$TARGET_DIR"
      unzip -q -o "$ZIP_PATH" -d "$TARGET_DIR"
      luajit docs/utils/dishes_exctractor/main.lua
    '';
    download-icons.exec = "bun run docs/utils/download_icons/download_icons.ts";
  };
}
