#!/bin/sh
git submodule update --remote --merge
git add vim/pack
git commit -m 'Update plugins'
