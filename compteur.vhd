library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity compteur is 
	port(
		clk : in std_logic;
		alea : in std_logic;
		q : out std_logic_vector(15 downto 0)
		);--load + adr.load
end entity;

architecture Behavioral of compteur is

signal q_int : std_logic_vector(15 downto 0) := (others=>'0');
	
begin
	process (clk)
	begin	
		if (clk='1' and alea='0') then
			q_int <= q_int + 4;
				end if;
		if(clk='1' and alea='1') then
			q_int <= q_int - 4;
			end if;
	end process;
	
	q <= q_int;
	
end Behavioral;
