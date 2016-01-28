#!/bin/bash

base_dir=$1

if [ -z "$base_dir" ]; then
	echo Usage: create-cache-dirs /some/path
	exit 1
fi

if [ ! -d "$base_dir" ]; then
	echo Directory does not exist: $base_dir
	exit 1
fi