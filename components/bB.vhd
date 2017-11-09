-- s_ctl is std_logic_vector of the flag.
-- (s_ctl = [GR, PR, MAR, MDR, addr])

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity bB is
  port(GR, PR, MAR, MDR : in std_logic_vector(15 downto 0);
       addr   : in std_logic_vector(7 downto 0);
       s_ctl  : in std_logic_vector(4 downto 0);
       busB    : out std_logic_vector(15 downto 0));
end bB;

architecture BEHAVIOR of bB is
begin
  busB <= GR  when s_ctl = "10000"
    else  PR  when s_ctl = "01000"
    else  MAR when s_ctl = "00100"
    else  MDR when s_ctl = "00010"
    else  "00000000" & addr when s_ctl = "00001"
    else  "XXXXXXXXXXXXXXXX";
end BEHAVIOR;
