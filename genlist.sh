#!/usr/bin/env zsh

cd $(dirname $0)/Formula
echo "## Formulas in this tap"
(for f in *; do
  printf -- '- [%s]( %s ) -- version %s\n' "${f/.rb/}" "$(gsed -n 's/^.*homepage "\(.*\)"/\1/p' $f)" "$(gsed -n 's/^.*version "\(.*\)"/\1/p' $f)" | sed 's/-- version \(\|git0\)$//'
done
) | sort

