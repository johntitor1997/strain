#!/bin/bash

hoge='A'
fugo='A'

if [ $hoge = $fugo ]; then
  echo "文字列は同じです"
else
  echo "文字列は違います"
fi
