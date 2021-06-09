-- my calic lib

--
--
--
-- [VHDLでの乗算 - Qiita](https://qiita.com/sarakane/items/62969a54a9ae54759e7c)
-- [VHDLでの丸め - Qiita](https://qiita.com/ryo_i6/items/e85030be420aa572a5a9)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.std_logic_misc.all;

package numeric_lib is
    -- -- max(integer, integer)
    -- function f_max(a,b: in integer) return integer;

    -- Add , uL + uM = uN, N=Max(L,M)+1
    function f_add(a,b: in unsigned) return unsigned;
    function f_add_u(a,b: in std_logic_vector) return std_logic_vector;
    -- Add , sL + sM = sN, N=Max(L,M)+1
    function f_add(a,b: in signed) return signed;
    function f_add_s(a,b: in std_logic_vector) return std_logic_vector;
    -- Add , uL + sM = sN, N=Max(L,M)+1
    function f_add(a: in unsigned; b: in signed) return signed;
    function f_add_us(a,b: in std_logic_vector) return std_logic_vector;
    -- Add , sL + uM = sN, N=Max(L,M)+1
    function f_add(a: in signed; b: in unsigned) return signed;
    function f_add_su(a,b: in std_logic_vector) return std_logic_vector;

    --[TODO]
    -- Sub , uL + uM = uN, N=Max(L,M)+1
    -- Sub , sL + sM = sN, N=Max(L,M)+1
    -- Sub , uL + sM = sN, N=Max(L,M)+1
    -- Sub , sL + uM = sN, N=Max(L,M)+1

    -- Mul , sL * uM = s(L+M)
    function f_mult(a: in signed; b: in unsigned) return signed;
    function f_mult_s_u(a,b: in std_logic_vector) return std_logic_vector;
    --[TODO]
    -- Mul , uL * sM = s(L+M)
    -- Mul , sL * sM = s(L+M)
    -- Mul , uL * uM = u(L+M)

    -- Div , sL / uM = sL
    function f_div(a: in signed; b: in unsigned) return signed;
    function f_div_s_u(a,b: in std_logic_vector) return std_logic_vector;
    --[TODO]
    -- Div , uL / sM = sL
    -- Div , sL / sM = sL
    -- Div , uL / uM = uL

    -- or_reduce, unsigned
    function or_reduce(a: in unsigned) return std_logic;
    -- or_reduce, signed
    function or_reduce(a: in signed) return std_logic;
    -- and_reduce, unsigned
    function and_reduce(a: in unsigned) return std_logic;
    -- and_reduce, signed
    function and_reduce(a: in signed) return std_logic;

    -- clip M to N bit, unsigned.
    function f_clip(a: in unsigned; constant n: in natural) return unsigned;
    -- clip M to N bit, signed.
    function f_clip(a: in signed; constant n: in natural) return signed;

    -- truncate, sM.N to sM
    function f_truncate(a: signed; constant len: natural) return signed;
    -- round toward zero(RZ), sM.N to sM
    function f_round_toward_zero(a: signed; constant len: natural) return signed;
    -- round half up, sM.N to sM
    function f_round_half_up(a: signed; constant len: natural) return signed;
    -- round to even, sM.N to sM
    function f_round_to_even(a: signed; constant len: natural) return signed;
    --[TODO]
    -- truncate, uM.N to uM
    -- round half up, uM.N to uM
    -- round to even, uM.N to uM
end package;

package body numeric_lib is
    -- -- max(integer, integer)
    -- function f_max(a,b: in integer) return integer is
    -- begin
    --     return maximum(a, b);
    -- end function;
    -- function f_max(a,b: in integer) return integer is
    --     variable res: integer;
    -- begin
    --     res := a when (a>b) else b;
    --     return res;
    --     -- return (a when (a>b) else b); -- 何故かエラー。
    -- end function;

    -- unsigned + unsigned, uL + uM = uN, N=Max(L,M)+1
    function f_add(a,b: in unsigned) return unsigned is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(unsigned(a), n+1) + resize(unsigned(b), n+1);
    end function;

    function f_add_u(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_add(unsigned(a), unsigned(b)));
    end function;

    -- signed + signed, sL + sM = sN, N=Max(L,M)+1
    function f_add(a,b: in signed) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(a, n+1) + resize(b, n+1);
    end function;

    function f_add_s(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_add(signed(a), signed(b)));
    end function;

    -- Add , uL + sM = sN, N=Max(L,M)+1
    function f_add(a: in unsigned; b: in signed) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return signed(resize(a, n+1)) + resize(b, n+1);
    end function;

    function f_add_us(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_add(unsigned(a), signed(b)));
    end function;

    -- -- Add , uL + sM = sN, N=Max(L,M)+1
    -- function f_add(a: in unsigned; b: in signed) return signed is
    --     constant n: integer := maximum(a'length, b'length);
    -- begin
    --     return signed(resize(a, n+1)) + resize(b, n+1);
    -- end function;

    -- function f_add_us(a,b: in std_logic_vector) return std_logic_vector is
    -- begin
    --     return std_logic_vector(f_add(unsigned(a), signed(b)));
    -- end function;

    -- Add , sL + uM = sN, N=Max(L,M)+1
    function f_add(a: in signed; b: in unsigned) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(a, n+1) + signed(resize(b, n+1));
    end function;

    function f_add_su(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_add(signed(a), unsigned(b)));
    end function;


    -- signed * unsigned, sL * uM = sN, N=L+M
    function f_mult(a: in signed; b: in unsigned) return signed is
        variable aa: signed(a'length-1 downto 0);
        variable bb: signed(b'length downto 0);
        variable res: signed(a'length + b'length downto 0);
    begin
        aa := signed(a);
        bb := signed('0' & b);
        -- bb := signed(resize(unsigned(b), b'length + 1));
        res := aa * bb;
        return res(a'length + b'length downto 0); -- cut MSB
    end function;

    -- signed * unsigned, sL * uM = sN, N=L+M
    function f_mult_s_u(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_mult(signed(a), unsigned(b)));
    end function;

    -- signed / unsinged, sL / uM = sL
    function f_div(a: in signed; b: in unsigned) return signed is
        variable aa: signed(a'length-1 downto 0);
        variable bb: signed(b'length downto 0);
        variable res: signed(a'length-1 downto 0);
    begin
        aa := signed(a);
        bb := signed('0' & b);
        -- bb := signed(resize(unsigned(b), b'length + 1));
        if bb = 0 then
            -- 0/0=0, +n/0=+Max, -n/2=-Max
            if aa = 0 then
                res := (res'left=>'0', others=>'0');
            elsif aa > 0 then
                res := (res'left=>'0', others=>'1');
            else
                res := (res'left=>'1', others=>'0');
            end if;
            return res;
        end if;
        res := aa / bb;
        return res;
    end function;

    -- signed / unsinged, sL / uM = sL
    function f_div_s_u(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_div(signed(a), unsigned(b)));
    end function;

    -- or_reduce
    function or_reduce(a: in unsigned) return std_logic is
        variable ret : std_logic := '0';
    begin
        for i in a'range loop
            ret := ret or a(i);
        end loop;
        return ret;
    end function;

    -- or_reduce
    function or_reduce(a: in signed) return std_logic is
    begin
        return or_reduce(unsigned(a));
    end function;

    -- and_reduce
    function and_reduce(a: in unsigned) return std_logic is
        variable ret : std_logic := '1';
    begin
        for i in a'range loop
            ret := ret and a(i);
        end loop;
        return ret;
    end function;

    -- and_reduce
    function and_reduce(a: in signed) return std_logic is
    begin
        return and_reduce(unsigned(a));
    end function;

    -- Clip M to N bit, unsigned.
    function f_clip(a: in unsigned; constant n: in natural) return unsigned is
        alias aa : unsigned(a'length-1 downto 0) is a;
        variable bb: unsigned(n-1 downto 0);
    begin
        -- reduction OR
        if or_reduce(aa(aa'length-1 downto n))='1' then
            bb := (others=>'1');
        else
            bb := aa(n-1 downto 0);
        end if;
        return bb;
    end function;

    -- Clip M to N bit, signed.
    function f_clip(a: in signed; constant n: in natural) return signed is
        alias aa : signed(a'length-1 downto 0) is a;
        variable sign: std_logic;
        variable bb: signed(n-2 downto 0);
    begin
        sign := aa(aa'length-1); -- sign
        if sign='0' then -- >0
            if or_reduce(aa(aa'length-2 downto n-1))='1' then
                bb := (others=>'1');
            else
                bb := aa(n-2 downto 0);
            end if;
        else
            if and_reduce(aa(aa'length-2 downto n-1))='0' then
                bb := (others=>'0');
            else
                bb := aa(n-2 downto 0);
            end if;
        end if;
        return sign & bb;
    end function;

    -- truncate, sM.N to sM
    function f_truncate(a: signed; constant len: natural) return signed is
        alias aa: signed(a'length-1 downto 0) is a; -- sM.N
    begin
        return aa(aa'length-1 downto aa'length - len); -- sM
    end function;

    -- round toward zero(RZ), sM.N to sM
    -- >0: +0000, <0: +1111
    function f_round_toward_zero(a: signed; constant len: natural) return signed is
        alias aa: signed(a'length-1 downto 0) is a; -- sM.N
        variable aa_up: signed(len-1 downto 0); -- sM
        variable add: signed(a'length - len downto 0); -- s.N
        variable sum: signed(a'length downto 0); -- s(M+1).N
        constant c_min: signed(len-1 downto 0) := (others=>'1'); -- sM
    begin
        aa_up := aa(a'length-1 downto a'length-len); -- sM
        add := (add'length-1=>'0', others=>aa(aa'length-1)); -- {s,{N{s}}}
        add := (others=>'0') when aa_up=c_min else add; -- for clip Min
        sum := resize(aa, sum'length) + resize(add, sum'length); -- s(M+1).N
        return sum(aa'length-1 downto aa'length-len); -- sM
    end function;

    -- round half up, sM.N to sM
    -- 0: trunc, 1: up
    function f_round_half_up(a: signed; constant len: natural) return signed is
        alias aa: signed(a'length-1 downto 0) is a; -- sM.N
        variable aa_up: signed(len-1 downto 0); -- sM
        variable add: signed(1 downto 0); -- s.1
        variable sum: signed(len-1 downto 0); -- sM
        constant m_max: signed(len-1 downto 0) := (len-1=>'0', others=>'1'); -- sM
    begin
        aa_up := aa(a'length-1 downto a'length-len); -- sM
        add := '0' & aa(a'length-len-1); -- N'MSB
        add := "00" when aa_up=m_max else add; -- for Clip
        sum := aa_up + resize(add, sum'length); -- sM, NoOverflow
        return sum; -- sM
    end function;

    -- round to even, sM.N to sM
    -- if (not 1.1000) +0.1, else +0.0
    function f_round_to_even(a: signed; constant len: natural) return signed is
        alias aa: signed(a'length-1 downto 0) is a; -- sM.N
        variable aa_up: signed(len-1 downto 0); -- sM
        variable aa_down: signed(a'length-len-1 downto 0); -- .N(actually unsigned)
        variable add: signed(1 downto 0); -- s.1
        variable sum: signed(len-1 downto 0); -- sM
        constant m_max: signed(len-1 downto 0) := (len-1=>'0', others=>'1'); -- sM
        constant n_half: signed(a'length-len-1 downto 0) := (a'length-len-1=>'1', others=>'0'); -- .N(actually unsigned)
    begin
        aa_up := aa(a'length-1 downto a'length-len); -- sM
        aa_down := aa(a'length-len-1 downto 0); -- .N
        add := '0' & aa_down(aa_down'length-1); -- N'MSB, .0 or .1
        add := "00" when (aa_up(0)='0' and aa_down=n_half) else add; -- for to even
        add := "00" when aa_up=m_max else add; -- for Clip
        sum := aa_up + resize(add, sum'length); -- sM, NoOverflow
        return sum; -- sM
    end function;
end;
