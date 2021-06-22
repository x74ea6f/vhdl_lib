
# sim_lib
シミュレーション向けのVHDLライブラリです。
含まれる関数をアルファベット順に挙げます。

| Function/Procedure |
| - |
| [check()](#check) |
| [make_clock()](#make_clock) |
| [make_reset()](#make_reset) |
| [rand_slv()](#rand_slv) |
| [wait_clock()](#wait_clock) |

## check()
`procedure check(data, exp: std_logic_vector; msg:string:=""; show_result:boolean:=false);`  
`procedure check(data, exp: unsigned; msg:string:=""; show_result:boolean:=false);`  
`procedure check(data, exp: signed; msg:string:=""; show_result:boolean:=false);`  
データ(data)と期待値(exp)の比較を行い、不一致であれば、Errorをreport(アサート)します。show_resultがTrue時は、一致の場合でもログを出力します。また、msgに任意の文字列が入っている場合は、同時にログに出力します。

## make_clock()
`procedure make_clock(signal clk: out std_logic; constant half_period: in time);`  
クロックを生成します(clk)。half_periodには、半周期の時間を入力します。

### Example
```VHDL
process begin
    make_clock(clk, 5 ns); -- 100MHz=10ns clock
end process;
```

## make_reset()
`procedure make_reset(signal rstn: out std_logic; signal clk: in std_logic; constant cyc: in natural:=1);`  
負論理のリセットを生成します(rstn)。clkには、クロック信号、cycにclk何周期分遅延させるかを指定します。

### Example
```VHDL
process begin
    make_reset(rstn, clk, 5); -- reset
end process;
```

## rand()
`impure function rand_slv(constant size: positive ) return std_logic_vector;`  
呼び出し毎にランダムな、sizeで指定したビット幅のstd_logic_vectorを返します。Seedは固定されているため、Sim毎では同値となります。

### Example
```VHDL
variable slv: std_logic_vector(7 downto 0);
~~~
slv := rand_slv(8);
```

## wait_clock()
`procedure wait_clock(signal clk: std_logic; constant num: natural:=1);`   
クロック信号の立ち上がりをnum回待ちます。

### Example
```VHDL
wait_clock(clk, 5); -- wait clock rising, 5times
```
