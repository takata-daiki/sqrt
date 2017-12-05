-- My Hello World.
-- Kazuya Sakai, Ph.D.
-- Tokyo Metropolitan University
-- 10-05-2015

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity TOY_CPU is
    port(clk, rst : in std_logic;
        imem : in std_logic_vector(15 downto 0);
        g0, g1, g2 : out std_logic_vector(15 downto 0);
        a, b, c : out std_logic_vector(15 downto 0);
        func2 : out std_logic_vector(2 downto 0);
        op2 : out std_logic_vector(3 downto 0);
        gra2, grb2 : out std_logic_vector(3 downto 0)
    );
end TOY_CPU;

architecture BEHAVIOR of TOY_CPU is

    component alu
    port(func : in std_logic_vector(2 downto 0);
        A, B : in std_logic_vector(15 downto 0);
        C : out std_logic_vector(15 downto 0)
    );
    end component;

    component decode
    port(I : in std_logic_vector(15 downto 0);
        func : out std_logic_vector(2 downto 0);
        op : out std_logic_vector(3 downto 0);
        GRA, GRB : out std_logic_vector(3 downto 0)
    );
    end component;

    -- GR
    signal gr0, gr1, gr2 : std_logic_vector(15 downto 0);

    -- ALU signal
    signal func : std_logic_vector(2 downto 0);
    signal alu_a, alu_b, alu_c : std_logic_vector(15 downto 0);

    -- DECODE signal
    signal op : std_logic_vector(3 downto 0);
    signal GRA, GRB : std_logic_vector(3 downto 0);

    -- PC
    signal pc : std_logic_vector(15 downto 0);

    --
    signal we : std_logic_vector(1 downto 0);

begin

    alu_1 : alu port map(func => func, A => alu_a, B => alu_b, C => alu_c);
    decode_1 : decode port map(imem, func, op, GRA, GRB);

    g0 <= gr0;
    g1 <= gr1;
    g2 <= gr2;
    a <= alu_a;
    b <= alu_b;
    c <= alu_c;
    func2 <= func;
    gra2 <= GRA;
    grb2 <= GRB;
    op2 <= op;
    

    -- ALU_A Out
    -- execute when the inputs are changed
    process (op, GRA, GRB) begin
        if (op = "1000" and GRA = "0001") then -- LAD r0, alu_c
            gr0 <= "000000000000" & GRB;
            we <= "01";
        elsif (op = "1000" and GRA = "0010") then -- LAD r1, alu_c
            gr1 <= "000000000000" & GRB;
            we <= "01";
        elsif (op = "1001" and GRA = "0001" and GRB = "0011") then
            gr0 <= gr2; -- LAD r0, r2
        end if;
    end process;

    -- ALU_A IN
    process(op) begin
        if (op = "0100") then
            alu_a <= gr0;
            alu_b <= gr1;
            we <= "10";
        end if;
    end process;

    process(alu_c) begin
        if (op = "0100") then
            gr2 <= alu_c;
            we <= "00";
        end if;
    end process;

    process(clk) begin
        if (clk' event and clk = '1') then
            if (rst = '0') then
                pc  <= "0000000000000000";
            else
                pc <= pc + "0000000000000001";
                
            end if;
        end if;
    end process;
end BEHAVIOR;
