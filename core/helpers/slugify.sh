#!/usr/bin/env bash

# alias slugify.
alias slugify='sed -r s/[^a-zA-Z0-9.]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z'
