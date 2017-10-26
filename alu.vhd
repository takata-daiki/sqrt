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
signal ans      : std_logic_vector(15 downto 0);
signal atop     : std_logic;
signal btop     : std_logic;
signal ftop     : std_logic;

-- Main --
begin
    -- Calculate Process --
    process(func, busA, busB) begin
        case func is
            when "0101" =>
                ans <= busA + busB;
            when "0110" =>
                ans <= busA - busB;
            when others =>
                ans <= "XXXXXXXXXXXXXXXX";
        end case;
    end process;
    
    -- Answer Process --
    process(busA, busB, ans) begin
        atop <= busA(15);
        btop <= busB(15);
        ftop <= ans(15);
        busC <= ans;
        if(ans = "0000000000000000") then
            outZ <= '1';
        else
            outZ <= '0';
        end if;
    end process;
    
    -- Flag Process --
    process(func, atop, btop, ftop) begin
        case func is
            when "0101" =>
                if(((atop and btop) or (atop and not ftop) or (btop and not ftop)) = '1') then
                    outO <= '1';
                else
                    outO <= '0';
                end if;
                outS <= ftop;
            when "0110" =>
                if(((atop and btop) or (atop and not ftop) or (btop and not ftop)) = '1') then
                    outO <= '0';
                else
                    outO <= '1';
                end if;
                outS <= ftop;
            when others =>
                outS <= ftop;
        end case;
    end process;
end BEHAVIOR;

