-- Sim library.
-- ```
-- ```
--
--
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.math_real.uniform;
use ieee.math_real.floor;

library std;
use std.textio.all;

library work;
use work.str_lib.all;

package sim_lib is

    -- ```
    -- clock, reset
    -- ```
    procedure make_clock(signal clk: out std_logic; constant half_period: in time);
    procedure make_reset(signal clk: in std_logic; constant cyc: in natural:=1; signal rstn: out std_logic);
    procedure wait_clock(signal clk: std_logic; constant num: natural:=1);

    -- ```
    -- Random
    -- ```
    type rand_t is protected
        procedure rand(ret: out real);
    end protected;

    shared variable SR: rand_t;

    -- Random std_logic_vector
    impure function rand_slv(constant size: positive ) return std_logic_vector;

    -- ```
    -- Assert check Expedcted data.
    -- ```
    procedure check(data, exp: std_logic_vector; msg:string:=""; show_result:boolean:=false);
    procedure check(data, exp: unsigned; msg:string:=""; show_result:boolean:=false);
    procedure check(data, exp: signed; msg:string:=""; show_result:boolean:=false);


end package;

package body sim_lib is

    -- ```
    -- clock, reset
    -- ```
    -- make clock
    procedure make_clock(signal clk: out std_logic; constant half_period: in time) is
    begin
        wait for half_period;
        clk <= '1' when clk='0' else '0';
    end procedure;

    -- make reset
    procedure make_reset(signal clk: in std_logic; constant cyc: in natural:=1; signal rstn: out std_logic) is
    begin
        rstn <= '0';
        wait_clock(clk, cyc);
        rstn <= '1';
    end procedure;

    -- wait for Num clock rising.
    procedure wait_clock(signal clk: std_logic; constant num: natural:=1) is
    begin
        for i in 0 to num-1 loop
            wait until rising_edge(clk);
        end loop;
        -- wait for 1ns; -- ?
    end procedure;

    -- ```
    -- Random
    -- ```
    type rand_t is protected body 
        variable seed1: positive:=1;
        variable seed2: positive:=2;

        procedure rand(ret: out real) is
        begin
            uniform(seed1, seed2, ret);
        end procedure;
    end protected body rand_t;

    -- Random std_logic_vector
    impure function rand_slv(constant size: positive ) return std_logic_vector is
        variable x: real;
        variable ret: std_logic_vector(size-1 downto 0);
        variable size_s, size_t: natural;
    begin
        size_s := size;
        while 0 < size_s loop
            size_t := 31 when (size_s>31) else size_s; -- Max 31bit
            SR.rand(x);
            ret(size_s-1 downto size_s-size_t) := std_logic_vector(to_signed(integer(floor(x * (2.0 ** size_t))), size_t));
            size_s := size_s - size_t;
        end loop;
        return ret;
    end function;

    -- ```
    -- Assert check Expedcted data.
    -- ```
    procedure check_len(data, exp: integer; msg:string:=""; show_result:boolean:=false) is
        variable prefix: string(1 to msg'length+8);
        variable sp: positive := 1;
    begin
        prefix:= "[" &msg & "] Data=";
        sp:= 4 when msg'length=0 else 1; -- if nothing message, remove [].

        assert data=exp
        report "Length not match: " & prefix(sp to prefix'right) + data & ", Exp=" + exp
        severity ERROR;
    end procedure;

    procedure check_data(data, exp: string; msg:string:=""; show_result:boolean:=false) is
        variable prefix: string(1 to msg'length+8);
        variable sp: positive := 1;
    begin
        prefix:= "[" & msg & "] Data=";
        sp:= 4 when msg'length=0 else 1; -- if nothing message, remove "[] ".

        if show_result=True and data=exp then
            print(prefix(sp to prefix'right)  & data & ", Exp=" & exp);
        end if;

        assert data=exp
        report "Data not match: " & prefix(sp to prefix'right) & data & ", Exp=" & exp
        severity ERROR;
    end procedure;

    procedure check(data, exp: std_logic_vector; msg:string:=""; show_result:boolean:=false) is
    begin
        check_len(data'length, exp'length, msg, show_result);
        check_data(to_str(data), to_str(exp), msg, show_result);
    end procedure;

    procedure check(data, exp: unsigned; msg:string:=""; show_result:boolean:=false) is
    begin
        check_len(data'length, exp'length, msg, show_result);
        check_data(to_str(data), to_str(exp), msg, show_result);
    end procedure;

    procedure check(data, exp: signed; msg:string:=""; show_result:boolean:=false) is
    begin
        check_len(data'length, exp'length, msg, show_result);
        check_data(to_str(data), to_str(exp), msg, show_result);
    end procedure;

end package body;
