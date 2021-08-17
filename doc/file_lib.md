---
title: file_lib
subtitle: vhdl_lib
date: 2021-08-17
author: 
---

# file_lib
VHDLのファイル読み込みのライブラリです。  
std.textioのラッパーライブラリです。  

| function/procedure |
| - |
| [read_line()](#read_line) |
| [read()](#read) |
| [comma2space()](#comma2space)


## read_line()
`procedure read_line(file f: text; l: inout line; is_csv: boolean:=False);`  
textioのreadline()のラッパー。fから1行読み出し、lに格納する。  
is_csv=Trueの時は、カンマからスペースへの変換(comma2space())を行う。


## read()
`procedure read(ln: inout line; intv: out integer_vector);`  
`procedure read(ln: inout line; rlv: out real_vector);`  
lnからinteger_vector(real_vector)を抽出する。  
intv(rlv)のサイズ分のInteger(Real)をReadし、intv(rlv)に格納する。  
(integer, realは, textioのread()関数で取得)  

## comma2space()
`procedure comma2space(ln: inout line);`  
lnの文字列をカンマからスペースへ変換を行う。  
csvを読み出し用。  

