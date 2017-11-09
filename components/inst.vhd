library ieee; 
use ieee.std_logic_1164.all; 
use IEEE.std_logic_signed.all; 
 
 
entity inst is  
     port( 
         clock : in std_logic; 
         busA  : in std_logic_vector(15 downto 0); 
         latch : in std_logic;  
         Mlang : out std_logic_vector(15 downto 0)
     ); 
end inst;

architecture BEHAVIOR of inst is  
 



begin 

process(clock) begin
      if(clock'event and clock = '1')then
          if(latch = '1')then
            Mlang <= busA;
          else
            null;
          end if;
       else
         null;
      end if;
  end process;

end BEHAVIOR; 