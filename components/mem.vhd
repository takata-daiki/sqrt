library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mem is
  port(clk, read, write : in std_logic;
       S_MAR_F : in std_logic_vector(7 downto 0);
       S_MDR_F : in std_logic_vector(15 downto 0);
       data : out std_logic_vector(15 downto 0);
       TB_switch : in std_logic;
       TB_addr   : in std_logic_vector(7 downto 0);
       TB_w_data : in std_logic_vector(15 downto 0));
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
      if TB_switch = '1' then
        RAM_DATA(conv_integer(TB_ADDR)) <= TB_w_data;
      elsif write = '1' then
        RAM_DATA(conv_integer(S_MAR_F)) <= S_MDR_F;
      elsif read = '1' then
        addr <= S_MAR_F;
      else
        null;
      end if;
    end if;
  end process;

end BEHAVIOR;
