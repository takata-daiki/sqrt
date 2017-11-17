library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mem is
  port(clk, read, write, S_MEMlat : in std_logic;
       S_MAR_F : in std_logic_vector(7 downto 0);
       S_MDR_F : in std_logic_vector(15 downto 0);
       data : out std_logic_vector(15 downto 0));
end mem;

architecture BEHAVIOR of mem is

subtype RAM_WORD is std_logic_vector(15 downto 0);
type RAM_ARRAY is array (0 to 255) of RAM_WORD;
signal RAM_DATA : RAM_ARRAY;
signal addr : std_logic_vector(7 downto 0);

begin
  data <= RAM_DATA(conv_integer(addr));
  process(clk) begin
    if clk'event and clk = '1' then
      if read = '1' then
        addr <= S_MAR_F;
      elsif write = '1' then
        RAM_DATA(conv_integer(S_MAR_F)) <= S_MDR_F;
      else
        null;
      end if;
    end if;
  end process;

end BEHAVIOR;
