------------------------------------------------------------
-- A simple full adder
-- Author: Aaron Moser
-- Date: 10.01.2019
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port
    (
    i_opa: in std_logic;
    i_opb: in std_logic;
    i_c:   in std_logic;
    o_e:   out std_logic;
    o_g:   out std_logic;
    o_p:   out std_logic
    );
end;

architecture behaviour of full_adder is
begin
    o_e <= i_opa xor i_opb xor i_c;
    o_g <= i_opa and i_opb;
    o_p <= i_opa or i_opb;
end;
