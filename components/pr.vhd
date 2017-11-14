library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity pr is
  port(clk, S_PRlat, S_s_inc : in std_logic;
       S_BUS_C : in std_logic_vector(15 downto 0);
       S_PR_F : out std_logic_vector(15 downto 0));
end pr;

architecture BEHAVIOR of pr is
begin
  S_PR_F <= S_BUS_C when (clk and S_PRlat) = '1'
    else    S_BUS_C + "0000000000000001" when (clk and S_s_inc) = '1'
    else    "XXXXXXXXXXXXXXXX";
end BEHAVIOR;
