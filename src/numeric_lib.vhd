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

    --```
    -- Add
    --```
    -- uL + uM = uN, N=Max(L,M)+1
    function f_add(a,b: in unsigned) return unsigned;
    function f_add_u(a,b: in std_logic_vector) return std_logic_vector;
    -- uL + sM = sN, N=Max(L,M)+1
    function f_add(a: in unsigned; b: in signed) return signed;
    function f_add_us(a,b: in std_logic_vector) return std_logic_vector;
    -- sL + uM = sN, N=Max(L,M)+1
    function f_add(a: in signed; b: in unsigned) return signed;
    function f_add_su(a,b: in std_logic_vector) return std_logic_vector;
    -- sL + sM = sN, N=Max(L,M)+1
    function f_add(a,b: in signed) return signed;
    function f_add_s(a,b: in std_logic_vector) return std_logic_vector;

    --```
    -- Sub
    --```
    -- uL + uM = uN, N=Max(L,M)+1
    function f_sub(a,b: in unsigned) return signed;
    function f_sub_u(a,b: in std_logic_vector) return std_logic_vector;
    -- uL + sM = sN, N=Max(L,M)+1
    function f_sub(a: in unsigned; b: in signed) return signed;
    function f_sub_us(a,b: in std_logic_vector) return std_logic_vector;
    -- sL + uM = sN, N=Max(L,M)+1
    function f_sub(a: in signed; b: in unsigned) return signed;
    function f_sub_su(a,b: in std_logic_vector) return std_logic_vector;
    -- sL + sM = sN, N=Max(L,M)+1
    function f_sub(a,b: in signed) return signed;
    function f_sub_s(a,b: in std_logic_vector) return std_logic_vector;

    --```
    -- Mul
    --```
    -- uL * uM = u(L+M)
    function f_mul(a, b: in unsigned) return unsigned;
    function f_mul_u(a,b: in std_logic_vector) return std_logic_vector;
    -- uL * sM = s(L+M)
    function f_mul(a: in unsigned; b: in signed) return signed;
    function f_mul_us(a,b: in std_logic_vector) return std_logic_vector;
    -- sL * uM = s(L+M)
    function f_mul(a: in signed; b: in unsigned) return signed;
    function f_mul_su(a,b: in std_logic_vector) return std_logic_vector;
    -- sL * sM = s(L+M)
    function f_mul(a,b: in signed) return signed;
    function f_mul_s(a,b: in std_logic_vector) return std_logic_vector;

    --```
    -- Div
    --```
    -- uL / uM = uL
    function f_div(a: in unsigned; b: in unsigned) return unsigned;
    function f_div_u(a,b: in std_logic_vector) return std_logic_vector;
    -- uL / sM = s(L+1)
    function f_div(a: in unsigned; b: in signed) return signed;
    function f_div_us(a,b: in std_logic_vector) return std_logic_vector;
    -- sL / uM = sL
    function f_div(a: in signed; b: in unsigned) return signed;
    function f_div_su(a,b: in std_logic_vector) return std_logic_vector;
    -- sL / sM = s(L+1)
    function f_div(a: in signed; b: in signed) return signed;
    function f_div_s(a,b: in std_logic_vector) return std_logic_vector;

    --```
    -- Reduce
    --```
    -- or_reduce, unsigned
    function f_or_reduce(a: in unsigned) return std_logic;
    -- or_reduce, signed
    function f_or_reduce(a: in signed) return std_logic;
    -- and_reduce, unsigned
    function f_and_reduce(a: in unsigned) return std_logic;
    -- and_reduce, signed
    function f_and_reduce(a: in signed) return std_logic;

    --```
    -- Clip
    --```
    -- clip M to N bit, unsigned.
    function f_clip(a: in unsigned; constant n: in natural) return unsigned;
    -- clip M to N bit, signed.
    function f_clip(a: in signed; constant n: in natural) return signed;

    --```
    -- Round
    --```
    --[TODO]
    -- truncate, uM.N to uM
    function f_truncate(a: unsigned; constant len: natural) return unsigned;
    -- round half up, uM.N to uM
    function f_round_half_up(a: unsigned; constant len: natural) return unsigned;
    -- round to even, uM.N to uM
    function f_round_to_even(a: unsigned; constant len: natural) return unsigned;

    -- truncate, sM.N to sM
    function f_truncate(a: signed; constant len: natural) return signed;
    -- round toward zero(RZ), sM.N to sM
    function f_round_toward_zero(a: signed; constant len: natural) return signed;
    -- round half up, sM.N to sM
    function f_round_half_up(a: signed; constant len: natural) return signed;
    -- round to even, sM.N to sM
    function f_round_to_even(a: signed; constant len: natural) return signed;
end package;

package body numeric_lib is

    --```
    -- Add
    --```

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

    -- uL + sM = sN, N=Max(L,M)+1
    function f_add(a: in unsigned; b: in signed) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return signed(resize(a, n+1)) + resize(b, n+1);
    end function;

    function f_add_us(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_add(unsigned(a), signed(b)));
    end function;

    -- sL + uM = sN, N=Max(L,M)+1
    function f_add(a: in signed; b: in unsigned) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(a, n+1) + signed(resize(b, n+1));
    end function;

    function f_add_su(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_add(signed(a), unsigned(b)));
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

    --```
    -- Sub
    --```

    -- uL - uM = sN, N=Max(L,M)+1
    function f_sub(a,b: in unsigned) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(signed('0' & a), n+1) - resize(signed('0' & b), n+1);
    end function;

    function f_sub_u(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_sub(unsigned(a), unsigned(b)));
    end function;

    -- uL - sM = sN, N=Max(L,M)+1
    function f_sub(a: in unsigned; b: in signed) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(signed('0' & a), n+1) - resize(b, n+1);
    end function;

    function f_sub_us(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_sub(unsigned(a), signed(b)));
    end function;

    -- sL - uM = sN, N=Max(L,M)+1
    function f_sub(a: in signed; b: in unsigned) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(a, n+1) - resize(signed('0' & b), n+1);
    end function;

    function f_sub_su(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_sub(signed(a), unsigned(b)));
    end function;

    -- sL - sM = sN, N=Max(L,M)+1
    function f_sub(a,b: in signed) return signed is
        constant n: integer := maximum(a'length, b'length);
    begin
        return resize(a, n+1) - resize(b, n+1);
    end function;

    function f_sub_s(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_sub(signed(a), signed(b)));
    end function;

    --```
    -- Mul
    --```

    -- uL * uM = u(L+M)
    function f_mul(a, b: in unsigned) return unsigned is
    begin
        return a * b;
    end function;

    function f_mul_u(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_mul(unsigned(a), unsigned(b)));
    end function;

    -- uL * sM = s(L+M)
    function f_mul(a: in unsigned; b: in signed) return signed is
        variable res: signed(a'length + b'length downto 0);
    begin
        res := signed('0' & a) * b;
        return res(a'length + b'length-1 downto 0); -- cut MSB
    end function;

    function f_mul_us(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_mul(unsigned(a), signed(b)));
    end function;

    -- signed * unsigned, sL * uM = sN, N=L+M
    function f_mul(a: in signed; b: in unsigned) return signed is
        variable res: signed(a'length + b'length downto 0);
    begin
        res := a * signed('0' & b);
        return res(a'length + b'length-1 downto 0); -- cut MSB
    end function;

    -- signed * unsigned, sL * uM = sN, N=L+M
    function f_mul_su(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_mul(signed(a), unsigned(b)));
    end function;

    -- sL * sM = s(L+M)
    function f_mul(a,b: in signed) return signed is
    begin
        return a * b;
    end function;
    function f_mul_s(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_mul(signed(a), signed(b)));
    end function;


    --```
    -- high, low: Like integer'high, integer'low
    --```

    function f_high_s(constant n: positive) return signed is
        variable ret : signed(n-1 downto 0);
    begin
        ret := (ret'high=>'0', others=>'1');
        return ret;
    end function;

    function f_low_s(constant n: positive) return signed is
        variable ret : signed(n-1 downto 0);
    begin
        ret := (ret'high=>'1', others=>'0');
        return ret;
    end function;

    function f_zero_s(constant n: positive) return signed is
        variable ret : signed(n-1 downto 0);
    begin
        ret := (others=>'0');
        return ret;
    end function;

    function f_high_u(constant n: positive) return unsigned is
        variable ret : unsigned(n-1 downto 0);
    begin
        ret := (others=>'1');
        return ret;
    end function;

    function f_low_u(constant n: positive) return unsigned is
        variable ret : unsigned(n-1 downto 0);
    begin
        ret := (others=>'0');
        return ret;
    end function;

    function f_zero_u(constant n: positive) return unsigned is
        variable ret : unsigned(n-1 downto 0);
    begin
        ret := (others=>'0');
        return ret;
    end function;

    --```
    -- Div
    -- 0/0=0, +n/0=+Max, -n/0=-Max
    -- (*) 除数がsignedの時のビット幅は, 被除数のビット幅+1。
    -- uL/sM = s(L+1), sL/sM=s(L+1)
    -- 例として、両者が4bitの時、下記のように1bit増える。
    -- (u4/s3), 15/-1=-15, (s4)
    -- (s3/s3), -8/-1=8, (s4)
    --```

    -- uL / uM = uL
    function f_div(a: in unsigned; b: in unsigned) return unsigned is
        variable res: unsigned(a'length-1 downto 0);
    begin
        if b = 0 then
            if a > 0 then res := f_high_u(res'length); -- Max
            else res := f_low_u(res'length); -- a=0, 0
            end if;
        else 
            res := a / b;
        end if;
        return res;
        return res;
    end function;

    function f_div_u(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_div(unsigned(a), unsigned(b)));
    end function;

    -- uL / sM = s(L+1)
    function f_div(a: in unsigned; b: in signed) return signed is
        variable res: signed(a'length downto 0);
    begin
        if b = 0 then
            if a > 0 then res := f_high_s(res'length); -- Max
            else res := f_zero_s(res'length); -- a=0, 0
            end if;
        else 
            res := signed('0' & a) / signed(b);
        end if;
        return res;
    end function;

    function f_div_us(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_div(unsigned(a), signed(b)));
    end function;

    -- sL / uM = sL
    function f_div(a: in signed; b: in unsigned) return signed is
        variable res: signed(a'length-1 downto 0);
    begin
        if b = 0 then
            if a > 0 then res := f_high_s(res'length); -- Max
            elsif a < 0 then res := f_low_s(res'length); -- Min
            else res := f_zero_s(res'length); -- a=0, 0
            end if;
        else 
            res := signed(a) / signed('0' & b);
        end if;
        return res;
    end function;

    function f_div_su(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_div(signed(a), unsigned(b)));
    end function;

    -- sL / sM = s(L+1)
    function f_div(a: in signed; b: in signed) return signed is
        variable res: signed(a'length downto 0);
    begin
        if b = 0 then
            if a > 0 then res := f_high_s(res'length); -- Max
            elsif a < 0 then res := f_low_s(res'length); -- Min
            else res := f_zero_s(res'length); -- a=0, 0
            end if;
        else 
            res := resize(a, a'length+1) / resize(b, b'length+1);
        end if;
        return res;
    end function;

    function f_div_s(a,b: in std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(f_div(signed(a), signed(b)));
    end function;



    --```
    -- Reduce
    --```

    -- or_reduce
    function f_or_reduce(a: in unsigned) return std_logic is
        variable ret : std_logic := '0';
    begin
        for i in a'range loop
            ret := ret or a(i);
        end loop;
        return ret;
    end function;

    -- or_reduce
    function f_or_reduce(a: in signed) return std_logic is
    begin
        return f_or_reduce(unsigned(a));
    end function;

    -- and_reduce
    function f_and_reduce(a: in unsigned) return std_logic is
        variable ret : std_logic := '1';
    begin
        for i in a'range loop
            ret := ret and a(i);
        end loop;
        return ret;
    end function;

    -- and_reduce
    function f_and_reduce(a: in signed) return std_logic is
    begin
        return f_and_reduce(unsigned(a));
    end function;

    -- Clip M to N bit, unsigned.
    function f_clip(a: in unsigned; constant n: in natural) return unsigned is
        alias aa : unsigned(a'length-1 downto 0) is a;
        variable bb: unsigned(n-1 downto 0);
    begin
        -- reduction OR
        if aa >= (2**n) then
            bb := f_high_u(n);
        else
            bb := aa(n-1 downto 0);
        end if;
        return bb;
    end function;

    -- Clip M to N bit, signed.
    function f_clip(a: in signed; constant n: in natural) return signed is
        alias aa : signed(a'length-1 downto 0) is a;
        variable ret: signed(n-1 downto 0);
    begin
        if aa >= 2**(n-1) then
            ret := f_high_s(n);
        elsif aa< -(2**(n-1)) then
            ret := f_low_s(n);
        else
            ret := aa(n-1 downto 0);
        end if;
        return ret;
    end function;

    -- function f_clip(a: in unsigned; constant n: in natural) return unsigned is
    --     alias aa : unsigned(a'length-1 downto 0) is a;
    --     variable bb: unsigned(n-1 downto 0);
    -- begin
    --     -- reduction OR
    --     if f_or_reduce(aa(aa'length-1 downto n))='1' then
    --         bb := (others=>'1');
    --     else
    --         bb := aa(n-1 downto 0);
    --     end if;
    --     return bb;
    -- end function;
    -- function f_clip(a: in signed; constant n: in natural) return signed is
    --     alias aa : signed(a'length-1 downto 0) is a;
    --     variable sign: std_logic;
    --     variable bb: signed(n-2 downto 0);
    -- begin
    --     sign := aa(aa'length-1); -- sign
    --     if sign='0' then -- >0
    --         if f_or_reduce(aa(aa'length-2 downto n-1))='1' then
    --             bb := (others=>'1');
    --         else
    --             bb := aa(n-2 downto 0);
    --         end if;
    --     else
    --         if f_and_reduce(aa(aa'length-2 downto n-1))='0' then
    --             bb := (others=>'0');
    --         else
    --             bb := aa(n-2 downto 0);
    --         end if;
    --     end if;
    --     return sign & bb;
    -- end function;

    --[TODO]
    -- truncate, uM.N to uM
    function f_truncate(a: unsigned; constant len: natural) return unsigned is
        alias aa: unsigned(a'length-1 downto 0) is a; -- uM.N
    begin
        return aa(aa'length-1 downto aa'length - len); -- uM
    end function;

    -- round half up, uM.N to uM
    -- 0: trunc, 1: up
    function f_round_half_up(a: unsigned; constant len: natural) return unsigned is
        alias aa: unsigned(a'length-1 downto 0) is a; -- uM.N
        variable aa_up: unsigned(len-1 downto 0); -- uM
        variable add: std_logic; -- u.1
        variable sum: unsigned(len-1 downto 0); -- uM
        constant m_max: unsigned(len-1 downto 0) := (others=>'1'); -- uM
    begin
        aa_up := aa(a'length-1 downto a'length-len); -- uM
        add := aa(a'length-len-1); -- N'MSB
        add := '0' when aa_up=m_max else add; -- for Clip
        sum := aa_up + add; -- uM, NoOverflow
        return sum; -- uM
    end function;

    -- round to even, uM.N to uM
    -- if (not 1.1000) +0.1, else +0.0
    function f_round_to_even(a: unsigned; constant len: natural) return unsigned is
        alias aa: unsigned(a'length-1 downto 0) is a; -- uM.N
        variable aa_up: unsigned(len-1 downto 0); -- uM
        variable aa_down: unsigned(a'length-len-1 downto 0); -- .N(actually unsigned)
        variable add: std_logic; -- u.1
        variable sum: unsigned(len-1 downto 0); -- uM
        constant m_max: unsigned(len-1 downto 0) := (others=>'1'); -- uM
        constant n_half: unsigned(a'length-len-1 downto 0) := (a'length-len-1=>'1', others=>'0'); -- .N(actually unsigned)
    begin
        aa_up := aa(a'length-1 downto a'length-len); -- uM
        aa_down := aa(a'length-len-1 downto 0); -- .N
        add := aa_down(aa_down'length-1); -- N'MSB, .0 or .1
        add := '0' when (aa_up(0)='0' and aa_down=n_half) else add; -- for to even
        add := '0' when aa_up=m_max else add; -- for Clip
        sum := aa_up + add; -- uM, NoOverflow
        return sum; -- uM
    end function;

    -- truncate, sM.N to sM
    function f_truncate(a: signed; constant len: natural) return signed is
        alias aa: signed(a'length-1 downto 0) is a; -- sM.N
    begin
        return aa(aa'length-1 downto aa'length - len); -- sM
    end function;

    -- round toward zero(RZ), sM.N to sM
    -- >0: +0.000, <0: +0.1111
    function f_round_toward_zero(a: signed; constant len: natural) return signed is
        alias aa: signed(a'length-1 downto 0) is a; -- sM.N
        variable aa_up: signed(len-1 downto 0); -- sM
        variable add: signed(a'length - len downto 0); -- s.N
        variable sum: signed(a'length downto 0); -- s(M+1).N
    begin
        aa_up := aa(a'length-1 downto a'length-len); -- sM
        add := (add'length-1=>'0', others=>aa(aa'length-1)); -- {s,{N{s}}}
        -- add := (others=>'0') when aa_up=f_low_s(aa_up'length) else add; -- for clip Min
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
