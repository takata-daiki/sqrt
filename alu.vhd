library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu is 
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
end alu;

architecture BEHAVIOR of alu is 

-- Definitions --
signal atop     : std_logic;
signal btop     : std_logic;
signal ftop     : std_logic;
signal ans      : std_logic_vector(15 downto 0);

-- Main --
begin
    -- Calculate Process --
    process(func, busA, busB) begin
        case func is
            when "0101" =>
                ans <= busA + busB;
            when "0110" =>
                ans <= busA - busB;
        end case;
    end process;
    
    -- Top Process --
    process(ans) begin
        atop <= busA(15)
        btop <= busB(15)
        ftop <= ans(15)
    end process;
    
    -- Flag Process --
    process() begin
        case func is
            when "0101" =>
                if() then
                busC <= busA + busB;
                flagO <= "0" 
            when "0110" =>
                bus
        end case;
    end process;

end BEHAVIOR;