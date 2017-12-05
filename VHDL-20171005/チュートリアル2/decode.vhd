-- My Hello World.
-- Kazuya Sakai, Ph.D.
-- Tokyo Metropolitan University
-- 10-05-2015

library ieee;
use ieee.std_logic_1164.all;

entity decode is 
    port(I : in std_logic_vector(15 downto 0);
        func : out std_logic_vector(2 downto 0);
        op : out std_logic_vector(3 downto 0);
        GRA, GRB : out std_logic_vector(3 downto 0)
    );
end decode;

architecture BEHAVIOR of decode is 
    signal op_t : std_logic_vector (15  downto 12);

begin
    op <= I(15 downto 12);
    op_t <= I (15 downto 12);
    GRA <= I(11 downto 8);	-- GRA decoder
    GRB <= I(3 downto 0);	-- GRB decoder

    process(op_t) begin
        if (op_t = "0100") then -- ADD
            func <= "000";
        end if;
    end process;

end BEHAVIOR;
