#!/usr/bin/env sh

THEME=""
CURRENT_IMG=""

WALL_DIR="$HOME/.config/swww"
CACHE_DIR="$HOME/.cache/swww"

CFG_FILE="${WALL_DIR}/wall.ctl"
wallpaper_blur="$HOME/.config/swww/wall.png.blur"
wallpaper_set="$HOME/.config/swww/wall.png"

update_wallpaper()
{
	local wallpaper=$1
	#local current_wallpaper="${WALL_DIR}/${wallpaper}"
	#local cache_wallpaper="${CACHE_DIR}/${wallpaper}"

	echo ${wallpaper}

	if [ ! -d "${CACHE_DIR}/${THEME}" ] ; then
		mkdir -p ${CACHE_DIR}/${THEME}
	fi

	sed -i "/^1|/c\1|${THEME}|${wallpaper}" $CFG_FILE # replace current wallpaper
	ln -fs $wallpaper $wallpaper_set
}

set_wallpaper()
{
	swww img $wallpaper_set \
	--transition-bezier .43,1.19,1,.4 \
	--transition-type "grow" \
	--transition-duration 0.7 \
	--transition-fps 60 \
	--transition-pos "$( hyprctl cursorpos )"
}

while read -r line
do
	cfg=(${line//|/ })
	if [[ ${cfg[0]} -eq 1 ]] ; then
		THEME="${cfg[1]}"
		CURRENT_IMG="${cfg[2]}"
		break
	fi
done < "$CFG_FILE"

echo $THEME
echo $CURRENT_IMG

images=($WALL_DIR/$THEME/*)

#echo ${images[@]}

for (( i = 0 ; i < ${#images[@]} ; i++ ))
do
	if [[ ${images[i]} == ${CURRENT_IMG} ]] ; then
		next_index=$(( (i + 1) % ${#images[@]} ))

		update_wallpaper ${images[next_index]}
		break
	fi
done

#update_wallpaper "Catppuccin-Mocha/rain_world1.png"

# check daemon and set wall
swww query
if [ $? -eq 1 ] ; then
	swww init
fi

set_wallpaper
