-- [TODO] Test for unsigned/signed vector.
-- in Vivado, function can not return array(?).
-- 

library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.finish;

use work.numeric_lib.all;
use work.str_lib.all;


entity test_numeric_lib3 is
    generic(
        LEN_ROUND: positive := 4
    );
end entity;

architecture SIM of test_numeric_lib3 is
    subtype unsigned_vv is unsigned(3 downto 0);
    -- subtype unsigned_vv is unsigned(natural range <>);
    type unsigned_v is array(natural range <>) of unsigned_vv;

    procedure print(u_v: unsigned_v) is
    begin
        for i in u_v'range loop
            print(to_str(u_v(i)) & ",", end_line=>False);
        end loop;
        print("");
    end procedure;


    function get_uv(n: natural) return unsigned_v is
        variable u_v: unsigned_v(0 to n-1);
    begin
        for i in u_v'range loop
            u_v(i) := X"5";
        end loop;
        return u_v;
    end function;



    --[TODO] Add to library.
    type slv_vector is array (natural range <>, natural range <>) of std_logic;
    type unsigned_vector is array (natural range <>, natural range <>) of std_logic;
    type signed_vector is array (natural range <>, natural range <>) of std_logic;

    procedure print(u_v: unsigned_vector) is
        variable v: unsigned(u_v'range(2));
    begin
        for i in u_v'range(1) loop
            for j in u_v'range(2) loop
                v(j) := u_v(i,j);
            end loop;
            print(to_str(v) & ",", False);
        end loop;
        print("");
    end procedure;

    function get(u_v: unsigned_vector; n: natural) return unsigned is
        variable v: unsigned(u_v'range(2));
    begin
        for i in v'range loop
            v(i) := u_v(n, i);
        end loop;
        return v;
    end function;

    -- [TODO] can this systhesis?
    procedure set(u_v: inout unsigned_vector; n: natural; v: unsigned) is
    begin
        for j in u_v'range(2) loop
            u_v(n, j):= v(j);
        end loop;
    end procedure;


    --[TODO] not work in xsim.
    function set_func(u_v: unsigned_vector; n: natural; v: unsigned) return unsigned_vector is
        variable u_v2: unsigned_vector(u_v'range(1), u_v'range(2)):=(others=>(others=>'1'));
    begin
        for i in u_v'range(1) loop
            for j in u_v'range(2) loop
                if i=n then
                    u_v2(i, j):= v(j);
                else
                    u_v2(i, j):= u_v(i, j);
                end if;
            end loop;
        end loop;
        return u_v2;
    end function;

    --[TODO] not work in xsim.
    function get_u_vec(n,m: natural) return unsigned_vector is
        variable u_v: unsigned_vector(0 to n-1, m-1 downto 0):=(others=>(others=>'1'));
    begin
        for i in u_v'range(1) loop
            for j in u_v'range(2) loop
                u_v(i, j):= '1';
            end loop;
        end loop;
        return u_v;
    end function;
    

begin
    process is
        variable u_v: unsigned_v(0 to 2):=(
            to_unsigned(12, 4),
            to_unsigned(13, 4),
            to_unsigned(14, 4)
        );

       variable u_v2: unsigned_vector(0 to 2, 3 downto 0);
       variable u_v3: unsigned_vector(0 to 2, 3 downto 0);
    begin
        print(u_v);
        print(get_uv(3));

        for i in u_v2'range(1) loop
            for j in u_v2'range(2) loop
                u_v2(i,j) := u_v(i)(j);
            end loop;
        end loop;
        print(u_v2);

        -- u_v2 := set(u_v2, 1, to_unsigned(1, 4));
        set(u_v2, 1, to_unsigned(1, 4));
        print(u_v2);
        print(to_str(get(u_v2, 1)));
        print(u_v2);

        print("TEST");
        u_v3 := set_func(u_v2, 1, to_unsigned(1, 4));
        print(u_v3);

        print(get_u_vec(5,4));

        finish(0);
    end process;
end architecture;

