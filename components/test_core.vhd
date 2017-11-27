library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity test_core is
end test_core;

architecture BEHAVIOR of test_core is

    component clock is
    port(
        pulse : out std_logic
    );
    end component;

    component alu is
    port(
        func : in  std_logic_vector(3 downto 0);
        busA : in  std_logic_vector(15 downto 0);
        busB : in  std_logic_vector(15 downto 0);
        inZ  : in  std_logic;
        inS  : in  std_logic;
        inO  : in  std_logic;
        outZ : out std_logic;
        outS : out std_logic;
        outO : out std_logic;
        busC : out std_logic_vector(15 downto 0)
    );
    end component;
    
    component bB is
    port(
        S_GRB, S_PR_F, S_MAR_F, S_MDR_F : in std_logic_vector(15 downto 0);
        addr     : in  std_logic_vector(7 downto 0);
        S_s_ctl  : in  std_logic_vector(4 downto 0);
        S_BUS_B  : out std_logic_vector(15 downto 0)
    );
    end component;

    component bC is
    port(
        S_BUS_C : inout std_logic_vector(15 downto 0)
    );
    end component;
        
    component busA is
    port(           
	    clock : in std_logic;
	    MDR   : in std_logic_vector(15 downto 0);
	    GR    : in std_logic_vector(15 downto 0);
	    ADDR  : in std_logic_vector(7 downto 0);
	    SI    : in std_logic_vector(2 downto 0);
	    busA_out : out std_logic_vector(15 downto 0)
	);
    end component;

    component csgc is 
    port(
        clk       : in  std_logic;
        mlang     : in  std_logic_vector(15 downto 0);
        ba_ctl    : out std_logic_vector(2 downto 0);
        bb_ctl    : out std_logic_vector(4 downto 0);
        address   : out std_logic_vector(7 downto 0);
        gr_lat    : out std_logic;
        gra       : out std_logic_vector(3 downto 0);
        grb       : out std_logic_vector(3 downto 0);
        grc       : out std_logic_vector(3 downto 0);
        ir_lat    : out std_logic;
        fr_lat    : out std_logic;
        pr_lat    : out std_logic;
        pr_cnt    : out std_logic;
        mar_lat   : out std_logic;
        mdr_lat   : out std_logic;
        mdr_sel   : out std_logic;
        m_read    : out std_logic;
        m_write   : out std_logic;
        func      : out std_logic_vector(3 downto 0);
	    phaseView : out std_logic_vector(3 downto 0)
    );
    end component;
    
    component fr is
    port(
        clk   : in  std_logic;
        latch : in  std_logic;
        inZF  : in  std_logic;
        inSF  : in  std_logic;
        inOF  : in  std_logic;
        outZF : out std_logic;
        outSF : out std_logic;
        outOF : out std_logic
    );
    end component;
    
    component gr is
    port(
       clk, S_GRlat : in std_logic;
       S_ctl_a, S_ctl_b, S_ctl_c : in std_logic_vector(3 downto 0);
       S_BUS_C : in std_logic_vector(15 downto 0);
       S_BUS_A, S_BUS_B : out std_logic_vector(15 downto 0);              
       GR0_View,  GR1_View,  GR2_View,  GR3_View,
       GR4_View,  GR5_View,  GR6_View,  GR7_View,
       GR8_View,  GR9_View,  GR10_View, GR11_View,
       GR12_View, GR13_View, GR14_View, GR15_View : out std_logic_vector(15 downto 0)
    );
    end component;
    
    component inst is
    port( 
        clock : in  std_logic; 
        busA  : in  std_logic_vector(15 downto 0); 
        latch : in  std_logic;  
        Mlang : out std_logic_vector(15 downto 0)
    ); 
    end component;
    
    component MAR is
    port( 
	    clk, lat : in  std_logic;
        busC     : in  std_logic_vector(15 downto 0); 
        M_ad16   : out std_logic_vector(15 downto 0);
        M_ad8    : out std_logic_vector(7 downto 0)
    ); 
    end component;
    
    component mdr is
    port( 
        clock : in  std_logic; 
        busC  : in  std_logic_vector(15 downto 0); 
        latch : in  std_logic;  
        memo  : in  std_logic_vector(15 downto 0);
        sel   : in  std_logic;  
        data  : out std_logic_vector(15 downto 0)
    ); 
    end component;

    component mem is
    port(
        clk, read, write : in std_logic;
        S_MAR_F : in  std_logic_vector(7 downto 0);
        S_MDR_F : in  std_logic_vector(15 downto 0);
        data    : out std_logic_vector(15 downto 0);
        TB_switch : in std_logic;
        TB_addr   : in std_logic_vector(7 downto 0);
        TB_w_data : in std_logic_vector(15 downto 0)
    );
    end component;
    
    component pr is
    port(
        clk, S_PRlat, S_s_inc : in std_logic;
        S_BUS_C : in  std_logic_vector(15 downto 0);
        S_PR_F  : out std_logic_vector(15 downto 0)
    );
    end component;

    -- clock
    signal pulse : std_logic;

    -- alu
    signal alu_fr_z : std_logic;
    signal alu_fr_s : std_logic;
    signal alu_fr_o : std_logic;
        
    -- bB
    signal busb_alu : std_logic_vector(15 downto 0);

    -- bC
    signal alu_busc_others : std_logic_vector(15 downto 0);
        
    -- busA
    signal busa_alu_ir: std_logic_vector(15 downto 0);

    -- csgc
    signal csgc_busa_ctl   : std_logic_vector(2 downto 0);
    signal csgc_busb_ctl   : std_logic_vector(4 downto 0);
    signal csgc_busab_addr : std_logic_vector(7 downto 0);
    signal csgc_gr_lat     : std_logic;
    signal csgc_gr_asel   : std_logic_vector(3 downto 0);
    signal csgc_gr_bsel   : std_logic_vector(3 downto 0);
    signal csgc_gr_csel   : std_logic_vector(3 downto 0);
    signal csgc_ir_lat     : std_logic;
    signal csgc_fr_lat     : std_logic;
    signal csgc_pr_lat     : std_logic;
    signal csgc_pr_cntup   : std_logic;
    signal csgc_mar_lat    : std_logic;
    signal csgc_mdr_lat    : std_logic;
    signal csgc_mdr_sel    : std_logic;
    signal csgc_mem_read   : std_logic;
    signal csgc_mem_write  : std_logic;
    signal csgc_alu_func   : std_logic_vector(3 downto 0);
    signal phaseView       : std_logic_vector(3 downto 0);
        
    -- fr
    signal fr_alu_z : std_logic;
    signal fr_alu_s : std_logic;
    signal fr_alu_o : std_logic;

    -- gr
    signal gr_busa : std_logic_vector(15 downto 0);
    signal gr_busb : std_logic_vector(15 downto 0);       
    signal GR0_View,  GR1_View,  GR2_View,  GR3_View,
           GR4_View,  GR5_View,  GR6_View,  GR7_View,
           GR8_View,  GR9_View,  GR10_View, GR11_View,
           GR12_View, GR13_View, GR14_View, GR15_View : std_logic_vector(15 downto 0);

    -- inst
    signal ir_csgc : std_logic_vector(15 downto 0);

    -- MAR  
    signal mar_busb : std_logic_vector(15 downto 0);
    signal mar_mem  : std_logic_vector(7 downto 0);

    -- mdr
    signal mdr_busab_mem : std_logic_vector(15 downto 0);

    -- memory
    signal mem_mdr   : std_logic_vector(15 downto 0);
    signal TB_switch : std_logic;
    signal TB_addr   : std_logic_vector(7 downto 0);
    signal TB_w_data : std_logic_vector(15 downto 0);

    -- pr
    signal pr_busb : std_logic_vector(15 downto 0);

    -- test_core
    signal addr_in   : std_logic_vector(7 downto 0) := "00000011";
    signal switch_in : std_logic := '1'; 

begin
    -- connect to entity
    -- TB_switch <= switch_IP;
    -- TB_addr   <= addr_IP;
    -- TB_w_data <= w_data_IP;
    -- clk_OP    <= pulse;
    -- data_OP   <= mem_mdr;
    -- GR0_OP  <= GR0_View;  GR1_OP  <= GR1_View;  GR2_OP  <= GR2_View;  GR3_OP  <= GR3_View;
    -- GR4_OP  <= GR4_View;  GR5_OP  <= GR5_View;  GR6_OP  <= GR6_View;  GR7_OP  <= GR7_View;
    -- GR8_OP  <= GR8_View;  GR9_OP  <= GR9_View;  GR10_OP <= GR10_View; GR11_OP <= GR11_View;
    -- GR12_OP <= GR12_View; GR13_OP <= GR13_View; GR14_OP <= GR14_View; GR15_OP <= GR15_View;
    TB_switch <= switch_in;

    clock_a : clock port map(
        pulse => pulse
    );
    
    alu_a : alu port map(
        func => csgc_alu_func,
        busA => busa_alu_ir,
        busB => busb_alu,
        inZ  => fr_alu_z,
        inS  => fr_alu_s,
        inO  => fr_alu_o,
        outZ => alu_fr_z,
        outS => alu_fr_s,
        outO => alu_fr_o,
        busC => alu_busc_others
    );
    
    bB_a : bB port map(
        S_GRB   => gr_busb,
        S_PR_F  => pr_busb,
        S_MAR_F => mar_busb,
        S_MDR_F => mdr_busab_mem,
        addr    => csgc_busab_addr,
        S_s_ctl => csgc_busb_ctl,
        S_BUS_B => busb_alu
    );

    bC_a : bC port map(
        S_BUS_C => alu_busc_others
    );
        
    busA_a : busA port map(
	    clock => pulse,
	    MDR   => mdr_busab_mem,
	    GR    => gr_busa,
	    ADDR  => csgc_busab_addr,
	    SI    => csgc_busa_ctl,
	    busA_out => busa_alu_ir
	);

    csgc_a : csgc port map(
        clk       => pulse,
        mlang     => ir_csgc,
        ba_ctl    => csgc_busa_ctl,
        bb_ctl    => csgc_busb_ctl,
        address   => csgc_busab_addr,
        gr_lat    => csgc_gr_lat,
        gra       => csgc_gr_asel,
        grb       => csgc_gr_bsel,
        grc       => csgc_gr_csel,
        ir_lat    => csgc_ir_lat,
        fr_lat    => csgc_fr_lat,
        pr_lat    => csgc_pr_lat,
        pr_cnt    => csgc_pr_cntup,
        mar_lat   => csgc_mar_lat,
        mdr_lat   => csgc_mdr_lat,
        mdr_sel   => csgc_mdr_sel,
        m_read    => csgc_mem_read,
        m_write   => csgc_mem_write,
        func      => csgc_alu_func,
        phaseView => phaseView
    );
    
    fr_a : fr port map(
        clk   => pulse,
        latch => csgc_fr_lat,
        inZF  => alu_fr_z,
        inSF  => alu_fr_s,
        inOF  => alu_fr_o,
        outZF => fr_alu_z,
        outSF => fr_alu_s,
        outOF => fr_alu_o
    );
    
    gr_a : gr port map(
       clk => pulse, 
       S_GRlat => csgc_gr_lat,
       S_ctl_a => csgc_gr_asel, 
       S_ctl_b => csgc_gr_bsel,
       S_ctl_c => csgc_gr_csel,
       S_BUS_C => alu_busc_others,
       S_BUS_A => gr_busa,
       S_BUS_B => gr_busb,
       GR0_View  => GR0_View,   GR1_View => GR1_View,   GR2_View => GR2_View,   GR3_View => GR3_View,
       GR4_View  => GR4_View,   GR5_View => GR5_View,   GR6_View => GR6_View,   GR7_View => GR7_View,
       GR8_View  => GR8_View,   GR9_View => GR9_View,  GR10_View => GR10_View, GR11_View => GR11_View,
       GR12_View => GR12_View, GR13_View => GR13_View, GR14_View => GR14_View, GR15_View => GR15_View
    );
    
    inst_a : inst port map( 
        clock => pulse,
        busA  => busa_alu_ir,
        latch => csgc_ir_lat,
        Mlang => ir_csgc
    ); 
    
    MAR_a : MAR port map( 
        clk    => pulse,
        lat    => csgc_mar_lat,
        busC   => alu_busc_others,
        M_ad16 => mar_busb,
        M_ad8  => mar_mem
    ); 
    
    mdr_a : mdr port map( 
        clock => pulse,
        busC  => alu_busc_others,
        latch => csgc_mdr_lat,
        memo  => mem_mdr,
        sel   => csgc_mdr_sel,
        data  => mdr_busab_mem
    ); 

    mem_a : mem port map(
        clk     => pulse,
        read    => csgc_mem_read,
        write   => csgc_mem_write,
        S_MAR_F => mar_mem,
        S_MDR_F => mdr_busab_mem,
        data    => mem_mdr,
        TB_switch => TB_switch,
        TB_addr   => TB_addr,
        TB_w_data => TB_w_data
    );
    
    pr_a : pr port map(
        clk     => pulse, 
        S_PRlat => csgc_pr_lat, 
        S_s_inc => csgc_pr_cntup,
        S_BUS_C => alu_busc_others,
        S_PR_F  => pr_busb
    );

    process(pulse) begin
        if(pulse'event and (pulse and switch_in) = '1') then
            TB_addr <= addr_in;
            case addr_in is
                when "00000000" =>
                    TB_w_data <= "0011000001110101";
                when "00000001" =>
                    TB_w_data <= "0011000100010101";
                when "00000010" =>
                    TB_w_data <= "0101000000000001";
                when "11111111" =>
                    switch_in <= '0';
                when others =>
                    null;
            end case;     
            addr_in <= addr_in - "00000001";
        else
            null;
        end if;
    end process;

end BEHAVIOR;
