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
- DBG.print : for Terminal log, Simple textio Wrapper.
- to_str() : standard types to string.
- "+" : String + StandardTypes = String
- 

# Install
`git clone [TODO] `

# Usage
1. Copy src/debug_lib.vhd to Your Local.
1. Add to compile files.
1. Add to testbench.
    ```VHDL: tb.vhd
    library work;
    use work.debug_lib.all;
    ```
1. Add code for Your TestBench.
    ```VHDL:tb.vhd
    DBG.print("Hello world! " + 123);
    ```

## Testbench sample all
```VHDL:tb.vhd
```

# License
MIT.
