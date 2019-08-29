#!/bin/sh
pod repo update minlison
echo "-------发布 $1 到 minlison 库...-------"
pod repo push minlison MLSNetwork.podspec  --sources=https://github.com/Minlison/Specs.git,master --allow-warnings
echo "-------发布 $1 到 minlison 库完成-------"
pod repo update minlison
