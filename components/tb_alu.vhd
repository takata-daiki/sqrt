library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu_tb is 
end alu_tb;

architecture BEHAVIOR of alu_tb is

-- Definitions --
constant STEP  : time := 10 ns; -- A clock cycle is set to be 10ns --
signal func : std_logic_vector(3 downto 0);
signal busA : std_logic_vector(15 downto 0);
signal busB : std_logic_vector(15 downto 0);
signal inZ  : std_logic;
signal inS  : std_logic;
signal inO  : std_logic;
signal outZ : std_logic;
signal outS : std_logic;
signal outO : std_logic;
signal busC : std_logic_vector(15 downto 0);

component alu is 
    port(
        func : in std_logic_vector(3 downto 0);
        busA : in std_logic_vector(15 downto 0);
        busB : in std_logic_vector(15 downto 0);
        inZ  : in std_logic;
        inS  : in std_logic;
        inO  : in std_logic;
        outZ : out std_logic;
        outS : out std_logic;
        outO : out std_logic;
        busC : out std_logic_vector(15 downto 0)
    );
end component;

-- Main --
begin
    uut : alu port map(
        func => func,
        busA => busA,
        busB => busB,
        inZ  => inZ ,
        inS  => inS ,
        inO  => inO ,
        outZ => outZ,
        outS => outS,
        outO => outO,
        busC => busC );
    
    -- clk_process: process
    -- begin
    --     clk <= '0';
    --     wait for STEP/2;  --for 0.5 ns signal is '0'.
    --     clk <= '1';
    --     wait for STEP/2;  --for next 0.5 ns signal is '1'.
    -- end process;
    
    tb_alu: process
    begin
        func <= "0000";
        busA <= "0001000100010001";
        busB <= "0100010001000100";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;
        func <= func + "0001";
        wait for STEP * 4;        
        --wait;
    end process;

end BEHAVIOR;
