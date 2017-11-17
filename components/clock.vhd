
library ieee; 
 use ieee.std_logic_1164.all; 
 use IEEE.std_logic_unsigned.all; 
 
entity clock is 
	
end clock;
		
architecture BEHAVIOR of clock is
    
	constant STEP  : time := 10 ns; 
    	signal clk   : std_logic;	
		
		
    begin

    process begin
        
        clk <= '0';
        wait for STEP/2;  
        clk <= '1';
        wait for STEP/2;  
    end process;

end BEHAVIOR;