library ieee; 
 use ieee.std_logic_1164.all; 
 use IEEE.std_logic_signed.all; 

---SI=[MDR,GR]

entity busA is  
     port( 
          
	 clock:in std_logic;
	 MDR:in std_logic_vector(15 downto 0);
	 GR:in std_logic_vector(15 downto 0);
	 SI:in std_logic_vector(1 downto 0);
	 busA_out:out std_logic_vector(15 downto 0)
	);
end busA; 

---architecture

architecture BEHAVIOR of busA is
begin

busA_out <=MDR when SI = "01"
else GR when SI="10"
else "XXXXXXXXXXXXXXXX";

end BEHAVIOR;
