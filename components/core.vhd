library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity core is
end core;

architecture BEHAVIOR of core is

    component alu
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
    end component;
    
    component bB
     port(
       S_GRB, S_PR_F, S_MAR_F, S_MDR_F : in std_logic_vector(15 downto 0);
       addr     : in std_logic_vector(7 downto 0);
       S_s_ctl  : in std_logic_vector(4 downto 0);
       S_BUS_B  : out std_logic_vector(15 downto 0)
       );
    end component;

    component bC
     port(
       S_BUS_C : inout std_logic_vector(15 downto 0)
       );
    end component;
        
    component busA
     port(           
	   clock:in std_logic;
	   MDR  :in std_logic_vector(15 downto 0);
	   GR   :in std_logic_vector(15 downto 0);
	   SI   :in std_logic_vector(1 downto 0);
	busA_out:out std_logic_vector(15 downto 0)
	);
    end component;
    
    component fr
    port(
        clk   : in std_logic;
        latch : in std_logic;
        inZF  : in std_logic;
        inSF  : in std_logic;
        inOF  : in std_logic;
        outZF : out std_logic;
        outSF : out std_logic;
        outOF : out std_logic
    );
    end component;
    
    component gr
      port(
       clk, S_GRlat : in std_logic;
       S_ctl_a, S_ctl_b, S_ctl_c : in std_logic_vector(3 downto 0);
       S_BUS_C : in std_logic_vector(15 downto 0);
       S_BUS_A, S_BUS_B : out std_logic_vector(15 downto 0)
       );
    end component;
    
    component inst
       port( 
         clock : in std_logic; 
         busA  : in std_logic_vector(15 downto 0); 
         latch : in std_logic;  
         Mlang : out std_logic_vector(15 downto 0)
     ); 
    end component;
    
    component MAR
     port( 
	clk, lat: in std_logic;
        busC  : in std_logic_vector(15 downto 0); 
        M_ad16: out std_logic_vector(15 downto 0);
        M_ad8 : out std_logic_vector(7 downto 0)
     ); 
    end component;
    
    component mdr
     port( 
         clock : in std_logic; 
         busC  : in std_logic_vector(15 downto 0); 
         latch : in std_logic;  
         memo  : in std_logic_vector(15 downto 0);
         sel   : in std_logic;  
         data  : out std_logic_vector(15 downto 0)
     ); 
    end component;
    
    component pr
     port(
       clk, S_PRlat, S_s_inc : in std_logic;
       S_BUS_C : in std_logic_vector(15 downto 0);
       S_PR_F : out std_logic_vector(15 downto 0)
       );
    end component;

    port(
    
    
    
    -- alu
        signal outZ : std_logic;
        signal outS : std_logic;
        signal outO : std_logic;
        signal busC : std_logic_vector(15 downto 0);
        
    -- bB
        signal S_BUS_B : std_logic_vector(15 downto 0)

    -- bC
        signal S_BUS_C : std_logic_vector(15 downto 0)
        
    -- busA
        signal busA_out: std_logic_vector(15 downto 0)
        
    -- fr
        signal outZF : std_logic;
        signal outSF : std_logic;
        signal outOF : std_logic;

    -- gr
        signal S_BUS_A : std_logic_vector(15 downto 0);
        signal S_BUS_B : std_logic_vector(15 downto 0);

    -- inst
        signal Mlang : std_logic_vector(15 downto 0);

    -- MAR  
        signal M_ad16: std_logic_vector(15 downto 0);
        signal M_ad8 : std_logic_vector(7 downto 0);

    -- mdr
        signal data  : std_logic_vector(15 downto 0);

    -- pr
        signal S_PR_F : std_logic_vector(15 downto 0);

begin

    alu_1 : alu port map(
    func => ,
    busA => busA_out,busB => S_BUS_B, inZ  => outZF,inS  => outSF,inO  => outOF,outZ => outZ,outS => outS,outO => outO, busC => busC,
    );
    
    bB_1 : bB port map(
     S_GRB => S_BUS_B,
     S_PR_F => S_PR_F, 
     S_MAR_F => M_ad16, 
     S_MDR_F => MDR,
     addr => --制御--
     S_s_ctl --制御:入力選択--
     S_BUS_B => S_GRB,
     );
     
     bC_1 : bC port map(
     S_BUS_C => S_BUS_C,
     S_BUS_C => S_BUS_C,
     );
     
    busA_1: busA port map(
     clock => --使っていない--
     MDR   => data
     GR    => S_BUS_A
     SI    => --制御信号busA--
     busA_out => busA
     );
     
    fr_1: fr port map(
     
     clk  
     latch
     inZF 
     inSF 
     inOF 
     outZF
     outSF
     outOF
     
     
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
