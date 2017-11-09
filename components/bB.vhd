-- s_ctl is std_logic_vector of the flag.
-- (s_ctl = [GR, PR, MAR, MDR, addr])

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity bB is
  port(GR, PR, MAR, MDR : in std_logic_vector(15 downto 0)
       addr   : in std_logic_vector(7 downto 0)
       s_ctl  : in std_logic_vector(4 downto 0)
       busB    : out std_logic_vector(15 downto 0));
end bB;

architecture BEHAVIOR of bB is
begin
  case s_ctl is
    when "10000" => busB <= GR;
    when "01000" => busB <= PR;
    when "00100" => busB <= MAR;
    when "00010" => busB <= MDR;
    when "00001" => busB <= "00000000" & addr;
  end case;
end BEHAVIOR;
