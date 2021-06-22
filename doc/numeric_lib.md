
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
`function f_clip(a: in signed; constant n: in natural) return signed;`  

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


