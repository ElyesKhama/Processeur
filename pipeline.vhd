library IEEE;
use IEEE.std_logic_1164.all;
Use IEEE.std_logic_UNSIGNED.all;
use IEEE.numeric_std.all;

entity pipeline is 
PORT(
	clk : in STD_logic;
	Din1 : in std_logic_vector(7 downto 0);
	Din2 : in std_logic_vector(15 downto 0);
	Din3 : in std_logic_vector(15 downto 0);
	Din4 : in std_logic_vector(15 downto 0);
	Dout1 : out std_logic_vector(7 downto 0);
	Dout2 : out std_logic_vector(15 downto 0);
	Dout3 : out std_logic_vector(15 downto 0);
	Dout4 : out std_logic_vector(15 downto 0));
END pipeline;

architecture Behavioral of pipeline is
begin 
	process(clk)
	begin 	
		if(CLK='1') then
			Dout1<=Din1;
			Dout2<=Din2;
			Dout3<=Din3;
			Dout4<=Din4;
		end if;
	end process;
end Behavioral;