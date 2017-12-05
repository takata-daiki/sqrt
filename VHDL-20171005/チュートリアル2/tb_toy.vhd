-- My Hello World.
-- Kazuya Sakai, Ph.D.
-- Tokyo Metropolitan University
-- 10-05-2015

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
library STD;
use STD.textio.all;

entity tb_toy is
end tb_toy;

architecture RTL of tb_toy is

    -- Definitions --
    constant STEP  : time := 10 ns; -- A clock cycle is set to be 10ns --
    signal clk   : std_logic;
    signal rst   : std_logic;
    signal imem  : std_logic_vector(15 downto 0);
    signal g0,g1,g2 : std_logic_vector(15 downto 0);
    signal a,b,c : std_logic_vector(15 downto 0);
    signal func2 : std_logic_vector(2 downto 0);
    signal op2 : std_logic_vector(3 downto 0);
    signal gra2,grb2 : std_logic_vector(3 downto 0);

    -- Modules declaration
    component TOY_CPU
        port(clk, rst : in std_logic;
            imem : in std_logic_vector(15 downto 0);
            g0, g1, g2 : out std_logic_vector(15 downto 0);
            a, b, c : out std_logic_vector(15 downto 0);
            func2 : out std_logic_vector(2 downto 0);
            op2 : out std_logic_vector(3 downto 0);
            gra2, grb2 : out std_logic_vector(3 downto 0)
        );
    end component;

-- Process --
begin
    --clk <= clk;
    --rst <= rst;
    --imem <= imem;
    --g0 <= g0;
    --g1 <= g1;
    --a <= "0000000000000000";
    -- b <= "0000000000000000";
    --b <= b;
    --c <= c;
    --func2 <= func2;
    --op2 <= op2;
    --gra2 <= gra2;
    --grb2 <= grb2;

    uut: TOY_CPU port map( clk => clk, rst => rst, imem => imem
        , g0 => g0, g1 => g1, g2 => g2
        , a => a, b => b, c => c
        , func2 => func2, op2 => op2
        , gra2 => gra2, grb2 => grb2 );

    clk_process: process
    begin
        rst <= '0';
        clk <= '0';
        wait for STEP/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for STEP/2;  --for next 0.5 ns signal is '1'.
    end process;

    tb_toy: process
    --file input : TEXT open READ_MODE is "toy_cpu/mem.txt";
    --variable input_line : line;

    begin
        imem <= "1000000100000001"; -- LAD r0, #1
        wait for STEP * 4;
        imem <= "1000001000000011"; -- LAD r1, #3
        wait for STEP * 4;
        imem <= "0100000000000000"; -- ADD r0, r1
        wait for STEP * 4;
        imem <= "1000001000000101"; -- LAD r1, #5
        wait for STEP * 4;
        imem <= "1001000100000011"; -- LADR r0, r2
        wait for STEP * 4;
        imem <= "0100000000000000"; -- ADD r0, r1
        wait for STEP * 4;
        
        --wait;
    end process;
end RTL;