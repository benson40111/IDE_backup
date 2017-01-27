export TERM=screen-256color
if [ (tmux ls | grep -c "window") = "1"]; and [ (echo $TMUX) = "" ]
	tmux attach-session -d
else
	tmux
end
clear
screenfetch
function fish_prompt
	env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.prompt.sh left
end 

function fish_right_prompt
	env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.prompt.sh right
end
