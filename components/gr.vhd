library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity gr is
  port(clk, S_GRlat : in std_logic;
       S_ctl_a, S_ctl_b, S_ctl_c : in std_logic_vector(3 downto 0);
       S_BUS_C : in std_logic_vector(15 downto 0);
       S_BUS_A, S_BUS_B : out std_logic_vector(15 downto 0));
end gr;

architecture BEHAVIOR of gr is

signal S_GR0_F, S_GR1_F, S_GR2_F, S_GR3_F, S_GR4_F, S_GR5_F, S_GR6_F, S_GR7_F,
  S_GR8_F, S_GR9_F, S_GR10_F, S_GR11_F, S_GR12_F, S_GR13_F, S_GR14_F, S_GR15_F
   : std_logic_vector(15 downto 0);

begin
  process(clk, S_GRlat, S_ctl_c, S_BUS_C) begin
    if (clk and S_GRlat) = '1' then
      case S_ctl_c is
        when "0000" => S_GR0_F <= S_BUS_C;
        when "0001" => S_GR1_F <= S_BUS_C;
        when "0010" => S_GR2_F <= S_BUS_C;
        when "0011" => S_GR3_F <= S_BUS_C;
        when "0100" => S_GR4_F <= S_BUS_C;
        when "0101" => S_GR5_F <= S_BUS_C;
        when "0110" => S_GR6_F <= S_BUS_C;
        when "0111" => S_GR7_F <= S_BUS_C;
        when "1000" => S_GR8_F <= S_BUS_C;
        when "1001" => S_GR9_F <= S_BUS_C;
        when "1010" => S_GR10_F <= S_BUS_C;
        when "1011" => S_GR11_F <= S_BUS_C;
        when "1100" => S_GR12_F <= S_BUS_C;
        when "1101" => S_GR13_F <= S_BUS_C;
        when "1110" => S_GR14_F <= S_BUS_C;
        when "1111" => S_GR15_F <= S_BUS_C;
        when others => null;
      end case;
    end if;
  end process;

  process(S_GR0_F, S_GR1_F, S_GR2_F, S_GR3_F, S_GR4_F, S_GR5_F, S_GR6_F,
          S_GR7_F, S_GR8_F, S_GR9_F, S_GR10_F, S_GR11_F, S_GR12_F, S_GR13_F,
          S_GR14_F, S_GR15_F, S_ctl_a, S_ctl_b) begin
    case S_ctl_a is
      when "0000" => S_BUS_A <= S_GR0_F;
      when "0001" => S_BUS_A <= S_GR1_F;
      when "0010" => S_BUS_A <= S_GR2_F;
      when "0011" => S_BUS_A <= S_GR3_F;
      when "0100" => S_BUS_A <= S_GR4_F;
      when "0101" => S_BUS_A <= S_GR5_F;
      when "0110" => S_BUS_A <= S_GR6_F;
      when "0111" => S_BUS_A <= S_GR7_F;
      when "1000" => S_BUS_A <= S_GR8_F;
      when "1001" => S_BUS_A <= S_GR9_F;
      when "1010" => S_BUS_A <= S_GR10_F;
      when "1011" => S_BUS_A <= S_GR11_F;
      when "1100" => S_BUS_A <= S_GR12_F;
      when "1101" => S_BUS_A <= S_GR13_F;
      when "1110" => S_BUS_A <= S_GR14_F;
      when "1111" => S_BUS_A <= S_GR15_F;
      when others => null;
    end case;
    case S_ctl_b is
      when "0000" => S_BUS_B <= S_GR0_F;
      when "0001" => S_BUS_B <= S_GR1_F;
      when "0010" => S_BUS_B <= S_GR2_F;
      when "0011" => S_BUS_B <= S_GR3_F;
      when "0100" => S_BUS_B <= S_GR4_F;
      when "0101" => S_BUS_B <= S_GR5_F;
      when "0110" => S_BUS_B <= S_GR6_F;
      when "0111" => S_BUS_B <= S_GR7_F;
      when "1000" => S_BUS_B <= S_GR8_F;
      when "1001" => S_BUS_B <= S_GR9_F;
      when "1010" => S_BUS_B <= S_GR10_F;
      when "1011" => S_BUS_B <= S_GR11_F;
      when "1100" => S_BUS_B <= S_GR12_F;
      when "1101" => S_BUS_B <= S_GR13_F;
      when "1110" => S_BUS_B <= S_GR14_F;
      when "1111" => S_BUS_B <= S_GR15_F;
      when others => null;
    end case;
  end process;

end BEHAVIOR;
