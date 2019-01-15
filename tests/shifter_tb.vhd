library ieee;
use ieee.std_logic_1164.all;

entity shifter_tb is
end shifter_tb;

architecture behaviour of shifter_tb is
    component shifter is
        port
        (
        i_op:   in std_logic_vector(15 downto 0);
        i_s:    in std_logic_vector(3 downto 0);
        o_r:    out std_logic_vector(15 downto 0);
        o_overflow:    out std_logic
        );
    end component;

    signal op_tb, r_tb:   std_logic_vector(15 downto 0);
    signal s_tb:          std_logic_vector(3 downto 0);
    signal v_tb: std_logic;

begin
    dut : shifter port map
    (
    i_op => op_tb,
    i_s => s_tb,
    o_r => r_tb,
    o_overflow => v_tb
    );

    stim_proc : process
    type pattern_type is record
        op : std_logic_vector(15 downto 0);
        s : std_logic_vector(3 downto 0);
        r : std_logic_vector(15 downto 0);
        c :std_logic;
    end record;

    type pattern_array is array(natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (("0000000000000001", "0001", "0000000000000010", '0'),
     ("0000000000000001", "1111", "1000000000000000", '0'),
     ("0101010101010101", "0001", "1010101010101010", '0'),
     ("0000000000000001", "0011", "0000000000001000", '0'),
     ("0000000010000000", "0011", "0000010000000000", '0'));

    begin
        for i in patterns'range loop
            op_tb <= patterns(i).op;
            s_tb <= patterns(i).s;
             wait for 1 ns;
             assert r_tb = patterns(i).r report "bad result" severity error;
             assert v_tb = patterns(i).c report "bad overflow value" severity error;
         end loop;

         assert false report "Shifter testbench finished" severity note;
         wait;
     end process;
end architecture;

