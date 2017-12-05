-- My Hello World.
-- Kazuya Sakai, Ph.D.
-- Tokyo Metropolitan University
-- 10-05-2015

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu is 
    port(func : in std_logic_vector(2 downto 0);
        A, B : in std_logic_vector(15 downto 0);
        C : out std_logic_vector(15 downto 0)
    );
end alu;

architecture BEHAVIOR of alu is 

	--signal q : std_logic_vector(15 downto 0);

begin
    --C <= q;

-- ALU
    process(func, A, B) begin
        if(func = "000") then
            C <= A + B;
        else
            C <= "0000000000000000";
        end if;
    end process;

end BEHAVIOR;