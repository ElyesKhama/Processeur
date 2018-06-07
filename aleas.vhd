library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity aleas is 
	port(li_di_op : in std_logic_vector (7 downto 0);
		li_di_b : in std_logic_vector (15 downto 0);
		li_di_c : in std_logic_vector (15 downto 0);
		di_ex_op : in std_logic_vector (7 downto 0);
		di_ex_a : in std_logic_vector (15 downto 0);
		ex_mem_op : in std_logic_vector (7 downto 0);
		ex_mem_a : in std_logic_vector (15 downto 0);
		s : out std_logic  --1 si aléa, 0 sinon
		);
end entity;

architecture Behavioral of aleas is

signal li_di_read : std_logic;
signal di_ex_write: std_logic;
signal ex_mem_write: std_logic;
signal di_ex_conflit: std_logic;
signal ex_mem_conflit: std_logic;

begin

li_di_read <= '1' when li_di_op=x"01"
						or li_di_op=x"02"
						or li_di_op=x"03"
						or li_di_op=x"04"
						or li_di_op=x"05"
						or li_di_op=x"08"
						or li_di_op=x"09"
						or li_di_op=x"0a"
						or li_di_op=x"0b"
						or li_di_op=x"0c"
						or li_di_op=x"0d"
						else '0';

di_ex_write <= '1' when di_ex_op=x"01"
							or di_ex_op=x"02"
							or di_ex_op=x"03" 
							or di_ex_op=x"04" 
							or di_ex_op=x"05" 
							or di_ex_op=x"06" 
							or di_ex_op=x"07" 
							or di_ex_op=x"09" 
							or di_ex_op=x"0a" 
							or di_ex_op=x"0b" 
							or di_ex_op=x"0c" 
							or di_ex_op=x"0d"
						   else '0';

ex_mem_write <= '1' when ex_mem_op=x"01" 
							or ex_mem_op = x"02"
							or ex_mem_op = x"03"
							or ex_mem_op = x"04"
							or ex_mem_op = x"05"
							or ex_mem_op = x"06"
							or ex_mem_op = x"07"
							or ex_mem_op = x"09"
							or ex_mem_op = x"0a"
							or ex_mem_op = x"0b"
							or ex_mem_op = x"0c"
							or ex_mem_op = x"0d"
							else '0';

di_ex_conflit <= '1' when (li_di_b(7 downto 0) = di_ex_a (7 downto 0) or li_di_c(7 downto 0) = di_ex_a (7 downto 0)) else '0';
ex_mem_conflit <= '1' when (li_di_b(7 downto 0) = ex_mem_a(7 downto 0) or li_di_c(7 downto 0) = ex_mem_a(7 downto 0)) else '0';

s <= '1' when (li_di_read='1' and di_ex_write='1' and di_ex_conflit='1') or (li_di_read='1' and ex_mem_write='1' and ex_mem_conflit='1')
			else '0';
	
end Behavioral;
