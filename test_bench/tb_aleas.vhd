--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:25:33 06/06/2018
-- Design Name:   
-- Module Name:   /home/hamid/processeur/tb_aleas.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: aleas
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_aleas IS
END tb_aleas;
 
ARCHITECTURE behavior OF tb_aleas IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aleas
    PORT(
         li_di_op : IN  std_logic_vector(7 downto 0);
         li_di_b : IN  std_logic_vector(15 downto 0);
         di_ex_op : IN  std_logic_vector(7 downto 0);
         di_ex_a : IN  std_logic_vector(15 downto 0);
         ex_mem_op : IN  std_logic_vector(7 downto 0);
         ex_mem_a : IN  std_logic_vector(15 downto 0);
         s : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal li_di_op : std_logic_vector(7 downto 0) := (others => '0');
   signal li_di_b : std_logic_vector(15 downto 0) := (others => '0');
   signal di_ex_op : std_logic_vector(7 downto 0) := (others => '0');
   signal di_ex_a : std_logic_vector(15 downto 0) := (others => '0');
   signal ex_mem_op : std_logic_vector(7 downto 0) := (others => '0');
   signal ex_mem_a : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal s : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aleas PORT MAP (
          li_di_op => li_di_op,
          li_di_b => li_di_b,
          di_ex_op => di_ex_op,
          di_ex_a => di_ex_a,
          ex_mem_op => ex_mem_op,
          ex_mem_a => ex_mem_a,
          s => s
        );

   
   -- Stimulus process
   stim_proc: process
   begin		
		li_di_op <= x"06";
		li_di_b <= x"0001";
		di_ex_op <=	x"05";
		di_ex_a <= 	x"0001";
		ex_mem_op <= x"01";
		ex_mem_a <= x"0000";
      wait for 100 ns;	
		li_di_op <= x"05";
		li_di_b <= x"0001";
		di_ex_op <=	x"06";
		di_ex_a <= 	x"0001";
		ex_mem_op <= x"01";
		ex_mem_a <= x"0000";

      wait;
   end process;

END;
