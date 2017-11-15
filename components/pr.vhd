library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity pr is
  port(clk, S_PRlat, S_s_inc : in std_logic;
       S_BUS_C : in std_logic_vector(15 downto 0);
       S_PR_F : out std_logic_vector(15 downto 0));
end pr;

architecture BEHAVIOR of pr is

signal rst : std_logic_vector(15 downto 0);

begin
  S_PR_F <= rst;
  process(clk, S_PRlat, S_s_inc) begin
    if (clk and S_PRlat) = '1' then
      rst <= S_BUS_C;
    elsif (clk and S_s_inc) = '1' then
      rst <= rst + 1;
    else
      null;
    end if;
  end process;
end BEHAVIOR;
