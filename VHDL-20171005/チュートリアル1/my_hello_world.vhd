-- My Hello World.
-- Kazuya Sakai, Ph.D.
-- Tokyo Metropolitan University
-- 08-18-2015

-- Include packages --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- entity 
entity hello_world is
    port(a, b: in std_logic_vector(3 downto 0);
         q   : out std_logic_vector(3 downto 0)
    );
end hello_world;

-- Architecture
architecture RTL of hello_world is
begin
    q <= a + b;
    assert false report "Hello World."
    severity note;
end RTL;
