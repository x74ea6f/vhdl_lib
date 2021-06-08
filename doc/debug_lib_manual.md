---
title: debug_lib_manual
subtitle: 
date: 2021-06-xx
author: 
---

# debug_lib
## about
VHDL simulation debug library(package).  
Simple and General usage.  

## Functions
- print() : for Terminal log, Simple textio Wrapper.
- to_str() : standard types to string.
- "+" : String + StandardTypes = String
- 

# Install
`git clone https://github.com/x74ea6f/vhdl_lib.git`

# Usage
1. Add "src/debug_lib.vhd" to compile files.
1. Add "use" to testbench.
    ```VHDL: tb.vhd
    library work;
    use work.debug_lib.all;
    ```
1. Add code to Your TestBench.
    ```VHDL:tb.vhd
        print("Hello world! " + v_int); -- String + Integer
        print("StdLogiVector=" + v_slv & ", ", false); -- false: not flush
        print("Integer=" & to_str(v_int, HEX)); -- flush
    ```
1. glad.

## Testbench exmaple
run [./example/debug_lib_example.vhd](./example/debug_lib_example.vhd)

```
Hello world! 123
StdLogiVector=0x1AB, Integer=0x0000007B
Finish @100ns
```

# License
MIT.
