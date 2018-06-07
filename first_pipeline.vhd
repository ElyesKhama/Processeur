library IEEE;
use IEEE.std_logic_1164.all;
Use IEEE.std_logic_UNSIGNED.all;
use IEEE.numeric_std.all;

entity first_pipeline is 
PORT(
	clk : in STD_logic;
	alea_in : in std_logic;
	Din1 : in std_logic_vector(7 downto 0);
	Din2 : in std_logic_vector(15 downto 0);
	Din3 : in std_logic_vector(15 downto 0);
	Din4 : in std_logic_vector(15 downto 0);
	Dout1 : out std_logic_vector(7 downto 0);
	Dout2 : out std_logic_vector(15 downto 0);
	Dout3 : out std_logic_vector(15 downto 0);
	Dout4 : out std_logic_vector(15 downto 0));
END first_pipeline;

architecture Behavioral of first_pipeline is
begin 
	process(clk)
	begin 	
		if(clk='1' and alea_in='0') then
			Dout1<=Din1;
			Dout2<=Din2;
			Dout3<=Din3;
			Dout4<=Din4;
		else 
			if(clk='1' and alea_in='1') then
				Dout1<=x"FF";
				Dout2<=x"FFFF";
				Dout3<=x"FFFF";
				Dout4<=x"FFFF";
			end if;
		end if;
	end process;
end Behavioral;