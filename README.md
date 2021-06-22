
# vhdl_lib
VHDL library.

## About
Simple and General useful VHDL library.  

## Packages
read each doc for more details.

### str_lib
- String library for log output & debug text output.  
- Print to display, print()  
- Variable to string, to_str(), +, /  

#### doc
[./doc/str_lib.md](./doc/str_lib.md)  

#### source
[./src/str_lib.vhd](./src/str_lib.vhd)  

#### test(example)
- [test_str_lib1.vhd](./test/test_str_lib1.vhd)
- [test_str_lib2.vhd](./test/test_str_lib2.vhd)
- [test_str_lib3.vhd](./test/test_str_lib3.vhd)

### sim_lib
- Testbench Library.  
- Create clock, reset. Wait clock  
- Create random value.  
- Check data and expected.  

#### doc
[./doc/sim_lib.md](./doc/sim_lib.md)  

#### source
[./src/sim_lib.vhd](./src/sim_lib.vhd)  

#### test(example)
- [test_sim_lib1.vhd](./test/test_sim_lib1.vhd)
- [test_sim_lib2.vhd](./test/test_sim_lib2.vhd)
- [test_sim_lib3.vhd](./test/test_sim_lib3.vhd)

### numeric_lib
- numeric(signed, unsigned) calc. add, sub, mul, div.
- clip, round.

#### doc
[./doc/numeric_lib.md](./doc/numeric_lib.md)  

#### source
[./src/numeric_lib.vhd](./src/numeric_lib.vhd)  

#### test(example)
- [test_numeric_lib1.vhd](./test/test_numeric_lib1.vhd)
- [test_numeric_lib2.vhd](./test/test_numeric_lib2.vhd)
- [test_numeric_lib3.vhd](./test/test_numeric_lib3.vhd)

### file_lib
- textio wrapper for read csv file.

#### doc
[./doc/file_lib.md](./doc/file_lib.md)  

#### source
[./src/file_lib.vhd](./src/file_lib.vhd)  

#### test(example)
- [test_file_lib1.vhd](./test/test_file_lib1.vhd)

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

## Test run
### by vivado(xsim)
```
$ cd test
$ bash run.sh test_str_lib1.vhd
```
(modify run.sh for your environment.)

### by modelsim(vsim)
```
$ cd test
$ bash run_modelsim.sh test_str_lib1.vhd
```
(modify run_modelsim.sh for your environment.)

## License
MIT
