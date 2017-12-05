library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity mem is
  port(clk, read, write : in std_logic;
       S_MAR_F : in std_logic_vector(7 downto 0);
       S_MDR_F : in std_logic_vector(15 downto 0);
       data : out std_logic_vector(15 downto 0));
end mem;

architecture BEHAVIOR of mem is

subtype RAM_WORD is std_logic_vector(15 downto 0);
type RAM_TYPE is array (0 to 255) of RAM_WORD;
impure function init_ram_file(RAM_FILE_NAME : in string) return RAM_TYPE is
file RAM_FILE : TEXT is in RAM_FILE_NAME;
variable RAM_FILE_LINE : line;
variable RAM_DIN : RAM_TYPE;
begin
  for I in RAM_TYPE'range loop
    readline(RAM_FILE, RAM_FILE_LINE);
    hread(RAM_FILE_LINE, RAM_DIN(I));
  end loop;
  return RAM_DIN;
end function;

signal RAM_DATA : RAM_TYPE := init_ram_file("mem2.txt");
signal addr : std_logic_vector(7 downto 0);

begin
  data <= RAM_DATA(conv_integer(addr));
  process(clk) begin
    if clk'event and clk = '1' then
      if write = '1' then
        RAM_DATA(conv_integer(S_MAR_F)) <= S_MDR_F;
      elsif read = '1' then
        addr <= S_MAR_F;
      else
        null;
      end if;
    end if;
  end process;

end BEHAVIOR;
