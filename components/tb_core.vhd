library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb_core is
end tb_core;

architecture BEHAVIOR of tb_core is

    component core is
        port(
            switch_IP  : in std_logic;
            addr_IP    : in std_logic_vector(7 downto 0);
            w_data_IP  : in std_logic_vector(15 downto 0);
            clk_OP     : out std_logic; 
            data_OP    : out std_logic_vector(15 downto 0);
            GR0_OP,  GR1_OP,  GR2_OP,  GR3_OP,
            GR4_OP,  GR5_OP,  GR6_OP,  GR7_OP,
            GR8_OP,  GR9_OP,  GR10_OP, GR11_OP,
            GR12_OP, GR13_OP, GR14_OP, GR15_OP : out std_logic_vector(15 downto 0)
        );
    end component;

    signal switch_IP  : std_logic := '1';
    signal addr_IP    : std_logic_vector(7 downto 0)  := "00000011";
    signal w_data_IP  : std_logic_vector(15 downto 0) := "0000000000000000";
    signal clk_OP     : std_logic; 
    signal data_OP    : std_logic_vector(15 downto 0);
    signal GR0_OP,  GR1_OP,  GR2_OP,  GR3_OP,
           GR4_OP,  GR5_OP,  GR6_OP,  GR7_OP,
           GR8_OP,  GR9_OP,  GR10_OP, GR11_OP,
           GR12_OP, GR13_OP, GR14_OP, GR15_OP : std_logic_vector(15 downto 0);

begin
    core_a : core port map(
            switch_IP, addr_IP, w_data_IP,
            clk_OP, data_OP,
            GR0_OP,  GR1_OP,  GR2_OP,  GR3_OP,
            GR4_OP,  GR5_OP,  GR6_OP,  GR7_OP,
            GR8_OP,  GR9_OP,  GR10_OP, GR11_OP,
            GR12_OP, GR13_OP, GR14_OP, GR15_OP
    );

    process(clk_OP) begin
        if(clk_OP'event and (clk_OP and switch_IP) = '1') then
            case addr_IP is
                when "00000000" =>
                    w_data_IP <= "0011000001110101";
                    switch_IP <= '0';             
                when "00000001" =>
                    w_data_IP <= "0011000100010101";
                when "00000010" =>
                    w_data_IP <= "0101000000000001";
                when others =>
                    null;
            end case;     
            addr_IP <= addr_IP - "00000001";
        else
            null;
        end if;
    end process;

end BEHAVIOR;
