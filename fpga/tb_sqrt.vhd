-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "12/12/2017 22:59:59"
                                                            
-- Vhdl Test Bench template for design  :  sqrt
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
USE ieee.std_logic_unsigned.all;

ENTITY tb_sqrt IS
END tb_sqrt;
ARCHITECTURE sqrt_arch OF tb_sqrt IS
-- constants                                                 
-- signals                                                   
SIGNAL btn : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL hex0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL hex1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL hex2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL hex3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL led : STD_LOGIC_VECTOR(9 DOWNTO 0);
--SIGNAL pulse : STD_LOGIC;
SIGNAL sw : STD_LOGIC_VECTOR(9 DOWNTO 0);
COMPONENT sqrt
	PORT (
	btn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	hex0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	hex1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	hex2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	hex3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	led : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	--pulse : IN STD_LOGIC;
	sw : IN STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : sqrt
	PORT MAP (
-- list connections between master ports and signals
	btn => btn,
	hex0 => hex0,
	hex1 => hex1,
	hex2 => hex2,
	hex3 => hex3,
	led => led,
	--pulse => pulse,
	sw => sw
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list 
  btn <= "111";
  sw <= "0000000000";

  wait for 70000 ns;
	btn <= "110";
	sw(7 downto 0) <= X"00";
	
  wait for 50 ns;
	btn <= "101";
	sw(7 downto 0) <= X"fe";
	
  wait for 50 ns;
	btn <= "011";	

  wait for 140000 ns;
  btn <= "110";
  sw(7 downto 0) <= X"50";

  wait for 50 ns;
  btn <= "101";
  sw(7 downto 0) <= X"c3";

  wait for 50 ns;
  btn <= "011";

  wait for 70000 ns;
WAIT;                                                        
END PROCESS always;                                          
END sqrt_arch;
