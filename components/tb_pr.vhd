-- Include packages --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb is
end tb;

architecture SIM of tb is

-- Definitions --
constant STEP : time := 10 ns; -- A clock cycle is set to be 100ns --
signal clk, S_PRlat, S_s_inc : std_logic;
signal S_BUS_C, S_PR_F : std_logic_vector(15 downto 0);

-- Modules declaration
component pr
port(clk, S_PRlat, S_s_inc : in std_logic;
     S_BUS_C : in std_logic_vector(15 downto 0);
     S_PR_F  : out std_logic_vector(15 downto 0));
end component;

-- Process --
begin
uut: pr port map(clk, S_PRlat, S_s_inc, S_BUS_C, S_PR_F);

    clk_process:
    process begin
        clk <= '0';
        wait for STEP/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for STEP/2;  --for next 0.5 ns signal is '1'.
    end process;

    tb:
    process begin
        S_BUS_C <= "0000000010001011";

        wait for 10ns;
        S_PRlat <= '1';

        wait for 30ns;
        S_PRlat <= '0';

	      wait for 50ns;
        S_s_inc <= '1';

        wait for 70ns;
        S_s_inc <= '0';

        wait;
    end process;
end SIM;
