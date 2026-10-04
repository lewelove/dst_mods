#!/usr/bin/env fish

set -l root_dir (status dirname)
set -l steam_mods "$HOME/.local/share/Steam/steamapps/common/Don't Starve Together/mods"
set -l vbox_mods "$HOME/virtual/box/dev/dst_mods"

set -l rsync_flags \
    -av \
    --delete \
    --delete-excluded \
    --prune-empty-dirs \
    --exclude=".*" \
    --exclude="docs/" \
    --exclude="notes/" \
    --exclude="node_modules/" \
    --include="*/" \
    --include="*.lua" \
    --include="*.tex" \
    --include="*.xml" \
    --include="*.manifest" \
    --include="*.anim" \
    --include="*.zip" \
    --include="*.fev" \
    --include="*.fsb" \
    --exclude="*"

for mod in 'starve!' common_sense show_me_minimal place_closer
    rsync $rsync_flags "$root_dir/$mod/" "$steam_mods/$mod/"
end

rsync $rsync_flags "$root_dir/starve!/" "$vbox_mods/starve!/"
