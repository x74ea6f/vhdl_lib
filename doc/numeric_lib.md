---
title: numeric_lib
subtitle: vhdl_lib
date: 2021-08-17
author: 
---

# numeric_lib
signed, unsgined, std_logic_vectorの演算のライブラリです。  
- 四則演算  
- ビット演算
- クリップ  
- 丸め  
- 他  

unsigned/signedは関数名共通です。  
std_logic_vector用は、signedであれば関数名の末尾に"_s", unsignedでは末尾に"_u"が付きます。  
また、unsignedとsignedの演算であれば、関数名の末尾に"_us"と付きます。  
(例: f_add_us(): unsigned + signed)  
また2個の引数がある場合、ビット幅は同じである必要はありません。  

| Function/Procedure | description|
| - | - |
| [f_add()](#f_add) | + |
| [f_sub()](#f_sub) | - |
| [f_mul()](#f_mul) | * |
| [f_div()](#f_div) | / |
| [f_or_reduce()](#f_or_reduce) | bit or |
| [f_and_reduce()](#f_and_reduce) | bit and |
| [f_clip()](#f_clip) | clip |
| [f_truncate()](#f_truncate) | round |
| [f_round_to_ward_zero()](#f_round_to_ward_zero) | round |
| [f_round_half_up()](#f_round_half_up) | round |
| [f_round_to_even()](#f_round_to_even) | round |
| [f_round()](#f_round) | round |
| [clog2()](#clog2) | log2(x) for cal bit width |
| [f_increment()](#f_increment) | Increment for Counter |


## f_add()
`function f_add(a,b: in unsigned) return unsigned;`  
`function f_add_u(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_add(a: in unsigned; b: in signed) return signed;`  
`function f_add_us(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_add(a: in signed; b: in unsigned) return signed;`  
`function f_add_su(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_add(a,b: in signed) return signed;`  
`function f_add_s(a,b: in std_logic_vector) return std_logic_vector;`  

aとbの加算を行い、ビット拡張した値を返します。出力ビット幅は、aとbのビット幅の大きな方+1ビットです。

## f_sub()
`function f_sub(a,b: in unsigned) return signed;`  
`function f_sub_u(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_sub(a: in unsigned; b: in signed) return signed;`  
`function f_sub_us(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_sub(a: in signed; b: in unsigned) return signed;`  
`function f_sub_su(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_sub(a,b: in signed) return signed;`  
`function f_sub_s(a,b: in std_logic_vector) return std_logic_vector;`  
`  
aとbの減算を行い、ビット拡張した値を返します。出力ビット幅は、aとbのビット幅の大きな方+1ビットです。

## f_mul()
`function f_mul(a, b: in unsigned) return unsigned;`  
`function f_mul_u(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_mul(a: in unsigned; b: in signed) return signed;`  
`function f_mul_us(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_mul(a: in signed; b: in unsigned) return signed;`  
`function f_mul_su(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_mul(a,b: in signed) return signed;`  
`function f_mul_s(a,b: in std_logic_vector) return std_logic_vector;`  

aとbの乗算を行い、ビット拡張した値を返します。出力ビット幅は、aとbのビット幅を足したビット幅です。


## f_div()
`function f_div(a: in unsigned; b: in unsigned) return unsigned;`  
`function f_div_u(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_div(a: in unsigned; b: in signed) return signed;`  
`function f_div_us(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_div(a: in signed; b: in unsigned) return signed;`  
`function f_div_su(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_div(a: in signed; b: in signed) return signed;`  
`function f_div_s(a,b: in std_logic_vector) return std_logic_vector;`  

aとbの除算を行い、ビット拡張した値を返します。出力ビット幅は、b(除数)がunsignedの場合a(被除数)のビット幅、b(除数)がsignedの場合はa(被除数)のビット幅+1ビットです。

## f_or_reduce()
`function f_or_reduce(a: in unsigned) return std_logic;`  
`function f_or_reduce(a: in signed) return std_logic;`  
`function f_or_reduce(a: in std_logic_vector) return std_logic;`  

全ビットのorを取った値を返します。

## f_and_reduce()
`function f_and_reduce(a: in unsigned) return std_logic;`  
`function f_and_reduce(a: in signed) return std_logic;`  
`function f_and_reduce(a: in std_logic_vector) return std_logic;`  

全ビットのandを取った値を返します。

## f_clip()
`function f_clip(a: in unsigned; constant n: in natural) return unsigned;`  
`function f_clip_u(a: in std_logic_vector; constant n: in natural) return std_logic_vector;`  
`function f_clip(a: in signed; constant n: in natural) return signed;`  
`function f_clip_s(a: in std_logic_vector; constant n: in natural) return std_logic_vector;`  

nビットでクリップしたaを返します。出力ビット幅は、nビットとなります。

## f_truncate()
`function f_truncate(a: unsigned; constant len: natural) return unsigned;`  
`function f_truncate(a: signed; constant len: natural) return signed;`  

aの丸めを行い、lenで指定したビット幅を出力します。丸め方法は、切り捨てです。

## f_round_toward_zero()
`function f_round_toward_zero(a: signed; constant len: natural) return signed;`  

aの丸めを行い、lenで指定したビット幅を出力します。丸め方法は、0への丸めです。

## f_round_half_up()
`function f_round_half_up(a: unsigned; constant len: natural) return unsigned;`  
`function f_round_half_up(a: signed; constant len: natural) return signed;`  

aの丸めを行い、lenで指定したビット幅を出力します。丸め方法は、0捨1入です。

## f_round_to_even()
`function f_round_to_even(a: unsigned; constant len: natural) return unsigned;`  
`function f_round_to_even(a: signed; constant len: natural) return signed;`  

aの丸めを行い、lenで指定したビット幅を出力します。丸め方法は、偶数への丸めです。


## f_round()
`alias f_round is f_round_half_up[unsigned, natural return unsigned];`  
`alias f_round is f_round_half_up[signed, natural return signed];`  
f_round_half_up()へのaliasです。


## clog2()
`function clog2(a: positive) return positive;`  
log2の計算を行います。  
小数点以下は切り上げを行い、自然数を返します。  
RAMのWord数からアドレスビット幅の計算等で使用します。  
Verilogの$clog2()相当。    
(real使っているため、合成用回路での使用は非推奨)  
### Example
```VHDL
constant DEPTH: positive:= 256;
constant ADDRESS_WIDTH: positive:= clog2(DEPTH); -- 8
```

## f_increment()
`function f_increment(slv: std_logic_vector) return std_logic_vector;`  
std_logic_vectorに1を加算し、返します。  
オーバフローの考慮はしません(0xFFは0x00を返す)。  
カウンターで使用します。  
