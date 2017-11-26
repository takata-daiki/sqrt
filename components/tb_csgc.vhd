library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity tb_csgc is 
end tb_csgc;

architecture BEHAVIOR of tb_csgc is

-- Definitions --
constant STEP  : time := 10 ns; -- A clock cycle is set to be 10ns --
signal mnemo : std_logic_vector(3 downto 0) := "0000";
signal opeA  : std_logic_vector(3 downto 0) := "1011";
signal opeB  : std_logic_vector(7 downto 0) := "10010110";

signal clk       : std_logic;
signal mlang     : std_logic_vector(15 downto 0);
signal ba_ctl    : std_logic_vector(2 downto 0);
signal bb_ctl    : std_logic_vector(4 downto 0);
signal address   : std_logic_vector(7 downto 0);
signal gr_lat    : std_logic;
signal gra       : std_logic_vector(3 downto 0);
signal grb       : std_logic_vector(3 downto 0);
signal grc       : std_logic_vector(3 downto 0);
signal ir_lat    : std_logic;
signal fr_lat    : std_logic;
signal pr_lat    : std_logic;
signal pr_cnt    : std_logic;
signal mar_lat   : std_logic;
signal mdr_lat   : std_logic;
signal mdr_sel   : std_logic;
signal m_read    : std_logic;
signal m_write   : std_logic;
signal func      : std_logic_vector(3 downto 0);
signal phaseView : std_logic_vector(3 downto 0);

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

-- Main --
begin
    uut : csgc port map(
        clk       => clk    ,
        mlang     => mlang  ,
        ba_ctl    => ba_ctl ,
        bb_ctl    => bb_ctl ,
        address   => address,
        gr_lat    => gr_lat ,
        gra       => gra    ,
        grb       => grb    ,
        grc       => grc    ,
        ir_lat    => ir_lat ,
        fr_lat    => fr_lat ,
        pr_lat    => pr_lat ,
        pr_cnt    => pr_cnt ,
        mar_lat   => mar_lat,
        mdr_lat   => mdr_lat,
        mdr_sel   => mdr_sel,
        m_read    => m_read ,
        m_write   => m_write,
        func      => func,   
        phaseView => phaseView
    );
    
    mlang <= mnemo & opeA & opeB;
    
    clk_process: process
    begin
        clk <= '0';
        wait for STEP/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for STEP/2;  --for next 0.5 ns signal is '1'.
    end process;
    
    tb_csgc: process
    begin
	     if(phaseView = "0000") then
		      mnemo <= mnemo + "0001";
            wait for STEP;
		  else
            wait for STEP;
		  end if;
    end process;

end BEHAVIOR;
