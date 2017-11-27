library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb_core is
end tb_core;

architecture BEHAVIOR of tb_core is

    component core is
        port(
            tb_ctl     : in std_logic;
            read_IP    : in std_logic;
            write_IP   : in std_logic;
            S_MAR_F_IP : in  std_logic_vector(7 downto 0);
            S_MDR_F_IP : in  std_logic_vector(15 downto 0);
            clk_OP     : out std_logic; 
            data_OP    : out std_logic_vector(15 downto 0);
            GR0_OP,  GR1_OP,  GR2_OP,  GR3_OP,
            GR4_OP,  GR5_OP,  GR6_OP,  GR7_OP,
            GR8_OP,  GR9_OP,  GR10_OP, GR11_OP,
            GR12_OP, GR13_OP, GR14_OP, GR15_OP : out std_logic_vector(15 downto 0)
        );
    end component;

    signal tb_ctl     : in std_logic;
    signal read_IP    : in std_logic;
    signal write_IP   : in std_logic;
    signal S_MAR_F_IP : in  std_logic_vector(7 downto 0);
    signal S_MDR_F_IP : in  std_logic_vector(15 downto 0);
    signal clk_OP     : out std_logic; 
    signal data_OP    : out std_logic_vector(15 downto 0);
    signal GR0_OP,  GR1_OP,  GR2_OP,  GR3_OP,
           GR4_OP,  GR5_OP,  GR6_OP,  GR7_OP,
           GR8_OP,  GR9_OP,  GR10_OP, GR11_OP,
           GR12_OP, GR13_OP, GR14_OP, GR15_OP : std_logic_vector(15 downto 0);

begin
    core_a : core port map(
            tb_ctl, read_IP, write_IP,
            S_MAR_F_IP, S_MDR_F_IP,
            clk_OP, data_OP,
            GR0_OP,  GR1_OP,  GR2_OP,  GR3_OP,
            GR4_OP,  GR5_OP,  GR6_OP,  GR7_OP,
            GR8_OP,  GR9_OP,  GR10_OP, GR11_OP,
            GR12_OP, GR13_OP, GR14_OP, GR15_OP
    );

    


end BEHAVIOR;
