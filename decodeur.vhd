library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodeur is

PORT(
	I: in  std_logic_vector(31 downto 0);
	OP : out std_logic_vector(7 downto 0);
	A : out std_logic_vector(15 downto 0);
	B : out std_logic_vector(15 downto 0);
	C : out std_logic_vector(15 downto 0));
end decodeur;

architecture Behavioral of decodeur is
signal op_temps:std_logic_vector(7 downto 0);
begin
op_temps<= I(31 downto 24);
OP<=op_temps;
-- 06 afc
-- 07 load
-- 08 store
--	0E jmp
-- 0F jmpc
	
with op_temps select 	  
	A	<= 	x"00"& x"00"	when x"0E" ,
			x"00"& I(7 downto 0)	when x"0F",
			I (23 downto 8) when x"08",
			x"00"& I(23 downto 16) when others;	
	
	
with op_temps select 	  
	B<= 	I(15 downto 0)	when x"06" | x"07",
			I(23 downto 8) 	when x"0E" | x"0F",
			x"00"&I(7 downto 0) when x"08",
			x"00"& I(15 downto 8) 	when others;

	C(7 downto 0) <= I(7 downto 0) when op_temps=x"00"
													or op_temps=x"01"
													or op_temps=x"02"
													or op_temps=x"03"
													or op_temps=x"04"
													or op_temps=x"09"
													or op_temps=x"0a"
													or op_temps=x"0b"
													or op_temps=x"0c"
													or op_temps=x"0d"
													or op_temps=x"0f"
												else x"00";
end Behavioral;

