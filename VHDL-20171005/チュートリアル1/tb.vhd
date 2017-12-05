-- My Hello World.
-- Kazuya Sakai, Ph.D.
-- Tokyo Metropolitan University
-- 09-08-2015

-- Include packages --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb is
end tb;

architecture SIM of tb is

-- Definitions --
constant STEP  : time := 10 ns; -- A clock cycle is set to be 100ns --
signal CLK   : std_logic;
signal a     : std_logic_vector(3 downto 0);
signal b     : std_logic_vector(3 downto 0);
signal q     : std_logic_vector(3 downto 0);

-- Modules declaration
component hello_world
port(
    a    : in std_logic_vector(3 downto 0);
    b    : in std_logic_vector(3 downto 0);
    q    : out std_logic_vector(3 downto 0)
    );
end component;


-- Process --
begin
uut: hello_world port map( a => a, b => b, q => q );

    clk_process: process
    begin
        clk <= '0';
        wait for STEP/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for STEP/2;  --for next 0.5 ns signal is '1'.
    end process;

    tb: process
    begin
        wait for 10ns;
        a <= "1011";
        b <= "0001";
        
	wait for 50ns;
        a <= "0010";
        b <= "0101";

        wait;
    end process;
end SIM;