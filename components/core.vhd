library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity core is
end core;

architecture BEHAVIOR of core is

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
	    SI    : in std_logic_vector(1 downto 0);
	    busA_out : out std_logic_vector(15 downto 0)
	);
    end component;

    component csgc is 
    port(
        clk      : in  std_logic;
        mlang    : in  std_logic_vector(15 downto 0);
        ba_ctl   : out std_logic_vector(2 downto 0);
        bb_ctl   : out std_logic_vector(4 downto 0);
        address  : out std_logic_vector(7 downto 0);
        gr_lat   : out std_logic;
        gra      : out std_logic_vector(3 downto 0);
        grb      : out std_logic_vector(3 downto 0);
        grc      : out std_logic_vector(3 downto 0);
        ir_lat   : out std_logic;
        fr_lat   : out std_logic;
        pr_lat   : out std_logic;
        pr_cnt   : out std_logic;
        mar_lat  : out std_logic;
        mdr_lat  : out std_logic;
        mdr_sel  : out std_logic;
        m_read   : out std_logic;
        m_write  : out std_logic;
        func     : out std_logic_vector(3 downto 0)
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
       S_BUS_A, S_BUS_B : out std_logic_vector(15 downto 0)
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
        data    : out std_logic_vector(15 downto 0)
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
    signal outZ : std_logic;
    signal outS : std_logic;
    signal outO : std_logic;
    -- signal busC : std_logic_vector(15 downto 0);
    --  -> S_BUS_C
        
    -- bB
    signal S_BUS_B_out : std_logic_vector(15 downto 0);

    -- bC
    signal S_BUS_C : std_logic_vector(15 downto 0);
        
    -- busA
    signal busA_out: std_logic_vector(15 downto 0);

    -- csgc
    signal ba_ctl   : std_logic_vector(2 downto 0);
    signal bb_ctl   : std_logic_vector(4 downto 0);
    signal address  : std_logic_vector(7 downto 0);
    signal gr_lat   : std_logic;
    signal gra      : std_logic_vector(3 downto 0);
    signal grb      : std_logic_vector(3 downto 0);
    signal grc      : std_logic_vector(3 downto 0);
    signal ir_lat   : std_logic;
    signal fr_lat   : std_logic;
    signal pr_lat   : std_logic;
    signal pr_cnt   : std_logic;
    signal mar_lat  : std_logic;
    signal mdr_lat  : std_logic;
    signal mdr_sel  : std_logic;
    signal m_read   : std_logic;
    signal m_write  : std_logic;
    signal func     : std_logic_vector(3 downto 0);
        
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
    signal data_mdr : std_logic_vector(15 downto 0);

    -- memory
    signal data_mem : std_logic_vector(15 downto 0);

    -- pr
    signal S_PR_F : std_logic_vector(15 downto 0);

begin

    clock_a : clock port map(
        pulse <= pulse
    );
    
    alu_a : alu port map(
        func <= func,
        busA <= busA_out,
        busB <= S_BUS_B_out,
        inZ  <= outZF,
        inS  <= outSF,
        inO  <= outOF,
        outZ <= outZ,
        outS <= outS,
        outO <= outO,
        busC <= S_BUS_C
    );
    
    bB_a : bB port map(
        S_GRB <= S_BUS_B,
        S_PR_F <= S_PR_F,
        S_MAR_F <= M_ad16,
        S_MDR_F <= data_mdr,
        addr    <= address,
        S_s_ctl <= bb_ctl,
        S_BUS_B <= S_BUS_B_out
    );

    bC_a : bC port map(
        S_BUS_C <= S_BUS_C
    );
        
    busA_a : busA port map(
	    clock <= pulse,
	    MDR   <= data_mdr,
	    GR    <= S_BUS_A,
	    ADDR  <= address,
	    SI    <= ba_ctl,
	    busA_out <= busA_out
	);

    csgc_a : csgc port map(
        clk      <= pulse,
        mlang    <= Mlang,
        ba_ctl   <= ba_ctl,
        bb_ctl   <= bb_ctl,
        address  <= address,
        gr_lat   <= gr_lat,
        gra      <= gra,
        grb      <= grb,
        grc      <= grc,
        ir_lat   <= ir_lat,
        fr_lat   <= fr_lat,
        pr_lat   <= pr_lat,
        pr_cnt   <= pr_cnt,
        mar_lat  <= mar_lat,
        mdr_lat  <= mdr_lat,
        mdr_sel  <= mdr_sel,
        m_read   <= m_read,
        m_write  <= m_write,
        func     <= func
    );
    
    fr_a : fr port map(
        clk   <= pulse,
        latch <= fr_lat,
        inZF  <= outZ,
        inSF  <= outS,
        inOF  <= outO,
        outZF <= outZF,
        outSF <= outSF,
        outOF <= outOF
    );
    
    gr_a : gr port map(
       clk <= pulse, 
       S_GRlat <= gr_lat,
       S_ctl_a <= gra, 
       S_ctl_b <= grb,
       S_ctl_c <= grc,
       S_BUS_C <= S_BUS_C,
       S_BUS_A <= S_BUS_A,
       S_BUS_B <= S_BUS_B
    );
    
    inst_a : inst port map( 
        clock <= pulse,
        busA  <= busA_out,
        latch <= ir_lat,
        Mlang <= Mlang
    ); 
    
    MAR_a : MAR port map( 
        clk <= pulse,
        lat <= mar_lat,
        busC <= S_BUS_C,
        M_ad16 <= M_ad16,
        M_ad8 <= M_ad8
    ); 
    
    mdr_a : mdr port map( 
        clock <= pulse,
        busC  <= S_BUS_C,
        latch <= mdr_lat,
        memo  <= data_mem,
        sel   <= mdr_sel,
        data  <= data_mdr
    ); 

    mem_a : mem port map(
        clk <= pulse,
        read <= m_read,
        write <= m_write,
        S_MAR_F <= m_ad8,
        S_MDR_F <= data_mdr,
        data    <= data_mem
    );
    
    pr_a : pr port map(
        clk <= pulse, 
        S_PRlat <= pr_lat, 
        S_s_inc <= pr_cnt,
        S_BUS_C <= S_BUS_C,
        S_PR_F <= S_PR_F
    );

end BEHAVIOR;
