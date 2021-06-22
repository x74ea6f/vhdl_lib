
# numeric_lib
signed, unsgined, std_logic_vectorの演算のライブラリです。
- 四則演算
- 丸め
- クリップ

unsigned/signedは関数名共通です。  
std_logic_vector用は、signedであれば関数名の末尾に"_s", unsignedでは末尾に"_u"が付きます。また、unsignedとsignedの演算であれば、関数名の末尾に"_us"と付きます。  
(例: f_add_us(): unsigned + signed)  
またビット幅は、a,bで同じである必要はありません。  

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
| [f_round_to_ward_zero()](#f_sub) | round |
| [f_round_half_up()](#f_round_half_up) | round |
| [f_round_to_even()](#f_round_to_even) | round |

## f_add()
`function f_add(a,b: in unsigned) return unsigned;`  
`function f_add_u(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_add(a: in unsigned; b: in signed) return signed;`  
`function f_add_us(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_add(a: in signed; b: in unsigned) return signed;`  
`function f_add_su(a,b: in std_logic_vector) return std_logic_vector;`  
`function f_add(a,b: in signed) return signed;`  
`function f_add_s(a,b: in std_logic_vector) return std_logic_vector;`  

aとbの加算を行い、ビット拡張した値を返します。

## f_sub()
