#!/bin/bash

#https://blog.dockbit.com/templating-your-dockerfile-like-a-boss-2a84a67d28e9

deploy() {
	str="
  s!%%TAG%%!$TAG!g;
"

	sed -r "$str" "$1"
}

TAGS=(
	#  5.6
	#  5.6-prod
	#  7.0
	#  7.0-prod
	#  7.1
	#  7.1-prod
	#  7.2
	#  7.2-prod
	#  7.3
	#  7.3-prod
	#  7.4
	8.0
	8.1
	8.2
	8.3
	8.4
)

ENTRYPOINT=entrypoint-after.sh

IFS='
'
# shellcheck disable=SC2048
for TAG in ${TAGS[*]}; do

	if [ -d "$TAG" ]; then
		rm -Rf "$TAG"
	fi

	mkdir "$TAG"
	deploy Dockerfile.template >"$TAG"/Dockerfile

	if [ -f "$ENTRYPOINT" ]; then
		cp $ENTRYPOINT "$TAG"
	fi

	cp -r patch "$TAG"

done
