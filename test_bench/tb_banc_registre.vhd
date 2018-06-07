--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:02:10 05/29/2018
-- Design Name:   
-- Module Name:   /home/hamid/processeur/tb_banc_registre.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: banc_registre
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
 
ENTITY tb_banc_registre IS
END tb_banc_registre;
 
ARCHITECTURE behavior OF tb_banc_registre IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT banc_registre
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         w : IN  std_logic;
         AA : IN  std_logic_vector(3 downto 0);
         AB : IN  std_logic_vector(3 downto 0);
         AW : IN  std_logic_vector(3 downto 0);
         DATA : IN  std_logic_vector(15 downto 0);
         QA : OUT  std_logic_vector(15 downto 0);
         QB : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal w : std_logic := '0';
   signal AA : std_logic_vector(3 downto 0) := (others => '0');
   signal AB : std_logic_vector(3 downto 0) := (others => '0');
   signal AW : std_logic_vector(3 downto 0) := (others => '0');
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: banc_registre PORT MAP (
          clk => clk,
          rst => rst,
          w => w,
          AA => AA,
          AB => AB,
          AW => AW,
          DATA => DATA,
          QA => QA,
          QB => QB
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		rst <= '0';
		wait for clk_period;
		
		rst <= '1';
      AA <= x"0";
		AB <= x"1";
		AW <= x"1";
		DATA <= x"ABCD";
		W <= '0';
      wait for clk_period;	

		AA <= x"0";
		AB <= x"1";
		W <= '0';
		wait for clk_period;	
		
      wait;
   end process;

END;
