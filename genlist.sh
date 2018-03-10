#!/usr/bin/env zsh

cd $(dirname $0)/Formula && (for f in *; printf '- [%s]( %s )\n' "${f/.rb/}" "$(gsed -n 's/^.*homepage "\(.*\)"/\1/p' $f)") | sort

