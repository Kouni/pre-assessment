#!/usr/bin/env bash

# 這種功能的 case 比較常遇到是在某種一次性的情境使用，在考量快速完成且執行環境需求低的前提下，使用 shell script 完成
# 先將將非字母字元替換成換行分割單字後，進行排序並計算且降冪排列，為了符合需求格式顯示，再將 result 前的空白移除
# 最後 awk 是想到可能會有一個以上的最多次數（e.g. 最多次數 10 次的有兩個 word ），所以處理成出現最多次的 word 不管幾個都會一並印出(顯示全部最高次數 word)。

tr -sc '[:alpha:]' '\n' <words.txt | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr | awk 'NR==1 || $1==max {print; max=$1}' | sed 's/^ *//'
