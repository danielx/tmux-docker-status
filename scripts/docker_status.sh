#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/helpers.sh"

docker_option_string="@docker_icon"

docker_icon=""

docker_count() {
	CONTAINERS="-1"
	if is_osx; then
		if command_exists "docker"; then
			if [[ $(ps -ef | grep -c 'com.docker.docker') -gt 1 ]]; then
				CONTAINERS=$(docker ps -q | wc -l | tr -d ' ')
			fi
		fi
	fi

	if is_linux; then
		if command_exists "docker"; then
			if [[ $(ps -ef | grep dockerd) -gt 1 ]]; then
				CONTAINERS=$(docker ps -q | wc -l | tr -d ' ')
			fi
		fi
	fi

	echo "$CONTAINERS"
}

print_docker_status() {
	# spacer fixes weird emoji spacing
	if [[ $(docker_count) -ge 0 ]]; then
		printf "$(get_tmux_option "$docker_option_string" "$docker_icon") $(docker_count)"
	fi
}

main() {
	print_docker_status
}
main
