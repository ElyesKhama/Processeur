library IEEE;
use IEEE.std_logic_1164.all;
Use IEEE.std_logic_UNSIGNED.all;
use IEEE.numeric_std.all;

entity banc_registre is 

PORT(
	clk: in std_logic;
	rst: in std_logic;
	w: in std_logic;
	AA: in std_logic_vector(3 downto 0);  --indice du tableau
	AB: in std_logic_vector(3 downto 0);  --indice du tableau
	AW: in std_logic_vector(3 downto 0);
	DATA: in std_logic_vector(15 downto 0);
	QA: out std_logic_vector(15 downto 0);
	QB: out std_logic_vector(15 downto 0)
	);

end banc_registre;


architecture behavior of banc_registre is

	type myTab_type is array(0 to 15) of std_logic_vector(15 downto 0);
	signal registres : myTab_type;
   
begin
QA <= DATA when (w='1' and AA=AW) else registres(to_integer(unsigned(AA)));
QB <= DATA when (w='1' and AB=AW) else registres(to_integer(unsigned(AB)));

	process(clk)
	begin
		if(clk='1') then
			if(rst='0') then
				for i in 0 to 15 loop
					registres(i) <= x"0000";
				end loop;
			elsif(w='1') then  --ecriture					
					registres (to_integer(unsigned(AW))) <= DATA;
					
			end if;
		end if;
	end process;
end behavior;
