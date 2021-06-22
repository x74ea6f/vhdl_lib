---
title: debug_lib_manual
subtitle: 
date: 2021-06-xx
author: 
---

# debug_lib
## About
VHDL simulation debug library(package).  
Simple and General useful.  

## Functions

- print() : for Terminal log, Simple textio Wrapper.
- to_str() : SomeType to string.
- "+" : String + SomeType = String
- rand_slv(): return random std_logic_vector
- make_clock(): make clock
- make_reset(): make reset
- wait_clock(): wait clock
- check(): check compare

### SomeType
Support type for function of to_str(), "+".

| SomeType | | 
| - | - |
| bit | bit_vector |
| boolean | boolean_vector |
| integer | integer_vector |
| real | real_vector |
| std_logic | std_logic_vector |
| signed | unsigned |

## Usage
1. Add "src/debug_lib.vhd" to compile files.
1. Add code to testbench.
    ```VHDL: tb.vhd
    library work;
    use work.debug_lib.all;
    ~~~
        print("Hello world! " + v_int); -- String + Integer
        print("StdLogiVector=" + v_slv & ", ", false); -- false: not flush
        print("Integer=" & to_str(v_int, HEX)); -- flush
    ```

## Testbench exmaple
Code:  
```VHDL
print("Hello world! " + v_int); -- String + Integer
print("StdLogiVector=" + v_slv & ", ", false); -- false: not flush
print("Integer=" & to_str(v_int, HEX)); -- flush
```
see all. [../example/debug_lib_example.vhd](../example/debug_lib_example.vhd)

Result:  
```bash
Hello world! 123
StdLogiVector=0x1AB, Integer=0x0000007B
Finish @100ns
```
## Tips
### + Operator
"+" is Operator function of "string + [SomeType](#sometype)".

#### Example:
| Code | Return String | Description | 
| - | - | - |
| "Hello" & "World" | "HelloWorld" | String & String, defined on standard lib |
| "Value=" + 1234 | "Value=1234" | String + Integer |
| "Value=" + 3.14 | "Value=3.140000e+00" | String + Real |
| "Values=" + integer_vector'(1,2,3)| "Value=(1,2,3)" | String + IntegerVector |
| "Value=" + v_bl | "Value=true" | String + boolean |
| "Value=" + v_slv | "Value=0x12" | String + std_logic_vector |
| "A=" + 12 & ", B=" + 34 | "A=12, B=34" | Complex |
```VHDL
variable v_bl: boolean:= True; 
variable v_slv: std_logic_vector(7 down to 0):= X"12";
```
