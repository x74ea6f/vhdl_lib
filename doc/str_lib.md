# str_lib
デバッグ出力やログ出力用の、VHDL文字列ライブラリです。
ログ出力用のprint()や、各タイプから文字列への変換の関数があります。
(integer'image()等, to_string()のラッパーライブラリ)

含まれる関数をアルファベット順に挙げます。

| function/procedure |
| - |
| [+(plus)](#plus) |
| [/(slash)](#slash) |
| [print()](#print)
| [replace()](#replace) |
| [to_str()](#to_str) |

### supported type
[print()](#print), [to_str()](#to_str), [+](#+)の右辺, [/](#/)の右辺で、使用できるタイプを以下に示します。
(*) print()は、vectortypeは非対応。

| some type | vector type | 
| - | - |
| bit | bit_vector |
| boolean | boolean_vector |
| integer | integer_vector |
| real | real_vector |
| std_logic | std_logic_vector |
| |  signed
| | unsigned |

#### example:
| code | return string | description | 
| - | - | - |
| "hello" & "world" | "helloworld" | string & string, defined on standard lib |
| "value=" + 1234 | "value=1234" | string + integer |
| "value=" + 3.14 | "value=3.140000e+00" | string + real |
| "values=" + integer_vector'(1,2,3)| "value=(1,2,3)" | string + integervector |
| "value=" + v_bl | "value=true" | string + boolean |
| "value=" + v_slv | "value=0x12" | string + std_logic_vector |
| "a=" + 12 & ", b=" + 34 | "a=12, b=34" | complex |
| to_str(X"123") / 123 / 1.23 | "0x123,123,1.230000e+00" | use "/" for csv |
```VHDL
Variable v_bl: boolean:= true; 
variable v_slv: std_logic_vector(7 down to 0):= x"12";
```

## print()
`procedure print(v: character; end_line: boolean:=true);`
`procedure print(v: string; end_line: boolean:=true);`
`procedure print(v: bit; end_line: boolean:=true);`
`procedure print(v: boolean; end_line: boolean:=true);`
`procedure print(v: integer; end_line: boolean:=true);`
`procedure print(v: real; end_line: boolean:=true);`
`procedure print(v: time; end_line: boolean:=true);`
`procedure print(v: std_logic; end_line: boolean:=true);`
textioライブラリのwrite()のラッパー関数です。[サポートするタイプ](#supported-type)のvを文字列に変換し、ログに出力します。
end_line=true時にフラッシュします。end_line=false時はバッファリングし、次のend_line=trueを待ちます。
vectorタイプは対象外です。vectorタイプを出力したい場合は、`print(to_str(vec_type));`とto_str()を通す必要があります。

## to_str()
`function to_str(v: character) return string;`
`function to_str(v: bit) return string;`
`function to_str(v: boolean) return string;`
`function to_str(v: integer; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string;`
`function to_str(v: real) return string;`
`function to_str(v: time) return string;`
`function to_str(v: std_logic) return string;`

`function to_str(btv: bit_vector; ptype: PRINT_TYPE:=LOGIC_DEFAULT_TYPE; prefix: string:="0x") return string;`
`function to_str(blv: boolean_vector; append_parenthesis: boolean:=True) return string;`
`function to_str(intv: integer_vector; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x"; append_parenthesis: boolean:=True) return string;`
`function to_str(rlv: real_vector; append_parenthesis: boolean:=True) return string;`
`function to_str(tmv: time_vector; append_parenthesis: boolean:=True) return string;`
`function to_str(slv: std_logic_vector; ptype: PRINT_TYPE:=LOGIC_DEFAULT_TYPE; prefix: string:="0x") return string;`
`function to_str(s: signed; ptype: PRINT_TYPE:=SIGNED_DEFAULT_TYPE; prefix: string:="0x") return string;`
`function to_str(u: unsigned; ptype: PRINT_TYPE:=UNSIGNED_DEFAULT_TYPE; prefix: string:="0x") return string;`

[サポートするタイプ](#supported-type)を文字列stringに変換します。 [PRINT_TYPE](#print_type)を付けた場合、指定フォーマットの文字列へ変換します。[PRINT_TYPE](#print_type)は、上記、関数宣言を参照。またprefix(Default:"0x")を付けた場合、PRINT_TYPE=HEXの場合にprefix+HEXへと変換します。

### PRINT_TYPE
数値タイプ等で、2進数、10進数（符号有無)、16進数での変換を指定します。
```
type PRINT_TYPE is (
    HEX,
    DEC_S, -- signed
    DEC_U, -- unsigned
    BIN);
```

## "+"(plus)
`function "+" (l: string; r: character) return string;`
`function "+" (l: string; r: bit) return string;`
`function "+" (l: string; r: boolean) return string;`
`function "+" (l: string; r: integer) return string;`
`function "+" (l: string; r: real) return string;`
`function "+" (l: string; r: time) return string;`
`function "+" (l: string; r: std_logic) return string;`

`function "+" (l: string; r: bit_vector) return string;`
`function "+" (l: string; r: boolean_vector) return string;`
`function "+" (l: string; r: integer_vector) return string;`
`function "+" (l: string; r: real_vector) return string;`
`function "+" (l: string; r: time_vector) return string;`
`function "+" (l: string; r: std_logic_vector) return string;`
`function "+" (l: string; r: signed) return string;`
`function "+" (l: string; r: unsigned) return string;`
Operator function.  
lに、rを文字列へ変換(to_str())し、結合したl+rを返します。string + stringはできませんので、標準の"&"を使用してください。

## "/"(slash)
`function "/" (l: string; r: character) return string;`
`function "/" (l: string; r: bit) return string;`
`function "/" (l: string; r: boolean) return string;`
`function "/" (l: string; r: integer) return string;`
`function "/" (l: string; r: real) return string;`
`function "/" (l: string; r: time) return string;`
`function "/" (l: string; r: std_logic) return string;`

`function "/" (l: string; r: bit_vector) return string;`
`function "/" (l: string; r: boolean_vector) return string;`
`function "/" (l: string; r: integer_vector) return string;`
`function "/" (l: string; r: real_vector) return string;`
`function "/" (l: string; r: time_vector) return string;`
`function "/" (l: string; r: std_logic_vector) return string;`
`function "/" (l: string; r: signed) return string;`
`function "/" (l: string; r: unsigned) return string;`
Operator function.  
lに、rを文字列へ変換(to_str())し、カンマ区切りで結合したl,rを返します。csv形式。


## replace
`impure function replace(str, search, rep:string) return string;`
文字列strの中から、文字列searchを検索し、文字列repに置換する。






