
# vhdl_lib
VHDL library.

## About
Simple and General useful VHDL library.  

## Packages
### str_lib
- String library for log output & debug text output.  
- Print to display, print()  
- Variable to string, to_str(), +, /  
doc: [./doc/str_lib](./doc/str_lib.md)  
source: [./src/str_lib.vhd](./src/str_lib.vhd)  

### sim_lib
- Testbench Library.  
- Create clock, reset. Wait clock  
- Create random value.  
- Check data and expected.  
doc: [./doc/sim_lib](./doc/sim_lib.md)  
source: [./src/sim_lib.vhd](./src/sim_lib.vhd)  

### numeric_lib
- numeric(signed, unsigned) calc. add, sub, mul, div.
- clip, round.
doc: [./doc/numeric_lib](./doc/numeric_lib.md)  
source: [./src/numeric_lib.vhd](./src/numeric_lib.vhd)  

## Usage
1. Add Library file(s) to compile files.  
  (example: "src/str_lib.vhd")
1. Add code to testbench.
    ```VHDL: tb.vhd
    library work;
    use work.str_lib.all;
    ~~~
        print("Hello world! " + v_int); -- String + Integer
    ```

## Testbench exmaple
see [example](./example/)

## License
MIT
