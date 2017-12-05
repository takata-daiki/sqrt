library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb is
end tb;

architecture BEHAVIOR of tb is

-- Definitions --
constant STEP  : time := 10 ns; -- A clock cycle is set to be 10ns --
signal clk, read, write, S_MEMlat : std_logic;
signal S_MAR_F  : std_logic_vector(7 downto 0);
signal S_MDR_F  : std_logic_vector(15 downto 0);
signal data : std_logic_vector(15 downto 0);

component mem is
  port(clk, read, write, S_MEMlat : in std_logic;
       S_MAR_F : in std_logic_vector(7 downto 0);
       S_MDR_F : in std_logic_vector(15 downto 0);
       data : out std_logic_vector(15 downto 0));
end component;

-- Main --
begin
  uut : mem port map(clk, read, write, S_MEMlat, S_MAR_F, S_MDR_F, data);

  clk_process:
  process begin
    clk <= '0';
    wait for STEP/2;  --for 5 ns signal is '0'.
    clk <= '1';
    wait for STEP/2;  --for next 5 ns signal is '1'.
  end process;

  tb:
  process begin
    read <= '0';
    write <= '0';
    S_MEMlat <= '0';

    -- No action --
    wait for 10ns;
    write <= '1';

    wait for 10ns;
    write <= '0';

    wait for 10ns;
    S_MEMlat <= '1';

    wait for 10ns;
    S_MEMlat <= '0';

    wait for 10ns;
    read <= '1';

    wait for 10ns;
    read <= '0';

    -- RAM_DATA(1) <= 7777 --
    wait for 10ns;
    S_MAR_F <= "00000001";
    S_MDR_F <= "0111011101110111";

    wait for 10ns;
    S_MEMlat <= '1';

    wait for 10ns;
    S_MEMlat <= '0';

    wait for 10ns;
    write <= '1';

    wait for 10ns;
    write <= '0';

    -- RAM_DATA(2) <= 5555 (concurrent) --
    wait for 10ns;
    S_MAR_F <= "00000010";
    S_MDR_F <= "0101010101010101";

    wait for 10ns;
    S_MEMlat <= '1';
    write <= '1';

    wait for 10ns;
    S_MEMlat <= '0';
    write <= '0';

    -- data <= RAM_DATA(1) --
    wait for 10ns;
    S_MAR_F <= "00000001";

    wait for 10ns;
    S_MEMlat <= '1';

    wait for 10ns;
    S_MEMlat <= '0';

    wait for 10ns;
    read <= '1';

    wait for 10ns;
    read <= '0';

    -- data <= RAM_DATA(2) --
    wait for 10ns;
    S_MAR_F <= "00000010";

    wait for 10ns;
    S_MEMlat <= '1';

    wait for 10ns;
    S_MEMlat <= '0';

    wait for 10ns;
    read <= '1';

    wait for 10ns;
    read <= '0';

    -- data <= RAM_DATA(1) (concurrent) --
    wait for 10ns;
    S_MAR_F <= "00000001";

    wait for 10ns;
    S_MEMlat <= '1';
    read <= '1';

    wait for 10ns;
    S_MEMlat <= '0';
    read <= '0';

    wait;
  end process;
end BEHAVIOR;
