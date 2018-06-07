library IEEE;
use IEEE.std_logic_1164.all;
Use IEEE.std_logic_UNSIGNED.all;
use IEEE.numeric_std.all;

entity ALU is 

PORT(
	OP: in  std_logic_vector(7 downto 0);
	A : in  std_logic_vector(15 downto 0);
	B : in  std_logic_vector(15 downto 0);
	C : in  std_logic_vector(15 downto 0);
	F : out std_logic_vector(3 downto 0);
	S : out std_logic_vector(15 downto 0));
 
end ALU;


 architecture behavior of ALU is


signal R: std_logic_vector(15 downto 0);
signal Rmul: std_logic_vector(31 downto 0);
signal Radd: std_logic_vector(16 downto 0);
--pas de div
	begin	
	Rmul <= A*B when OP=x"02";   --gerer les nombres signés avec complément à 2 et bit de poids fort
	Radd <= ('0'&A)+('0'&B);
	R	 <=	Radd(15 downto 0) when OP=x"01" 
		else
			A-B when OP=x"03"
		else 
			Rmul(15 downto 0) when OP=x"02";
	F(0) <= Radd(16); --flag carry 
	F(1) <= '1' when R=x"0000" else '0';  --flag zero
	S	 <= R;
	
	end behavior;

 

 