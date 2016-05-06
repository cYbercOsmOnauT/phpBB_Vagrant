#!/bin/bash

cacheDir=../log/htdocs/cache

# First clear twig cache
rm -rf ${cacheDir}/twig

# now the other files
for filename in ${cacheDir}/*
do
done;