----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:13:00 05/30/2018 
-- Design Name: 
-- Module Name:    chemin_donnees - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
Use IEEE.std_logic_UNSIGNED.all;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processeur is
	port(clk: in std_logic;
			sortie_proc1,sortie_proc2: out std_logic_vector(15 downto 0));
end;

architecture Structure of processeur is
component decodeur  
	port (I: in  std_logic_vector(31 downto 0);
	OP : out std_logic_vector(7 downto 0);
	A  : out std_logic_vector(15 downto 0);
	B  : out std_logic_vector(15 downto 0);
	C  : out std_logic_vector(15 downto 0));

end component; 

component ALU 
	port(OP: in  std_logic_vector(7 downto 0);
	A : in  std_logic_vector(15 downto 0);
	B : in  std_logic_vector(15 downto 0);
	C : in  std_logic_vector(15 downto 0);
	F : out std_logic_vector(3 downto 0);
	S : out std_logic_vector(15 downto 0));
end component; 

component banc_registre 
	port(clk: in std_logic;
	rst: in std_logic;
	w: in std_logic;
	AA: in std_logic_vector(3 downto 0);  --indice du tableau
	AB: in std_logic_vector(3 downto 0);  --indice du tableau
	AW: in std_logic_vector(3 downto 0);
	DATA: in std_logic_vector(15 downto 0);
	QA: out std_logic_vector(15 downto 0);
	QB: out std_logic_vector(15 downto 0)
	);
end component;  

component pipeline
port(
	clk : in STD_logic;
	Din1 : in std_logic_vector(7 downto 0);
	Din2 : in std_logic_vector(15 downto 0);
	Din3 : in std_logic_vector(15 downto 0);
	Din4 : in std_logic_vector(15 downto 0);
	Dout1 : out std_logic_vector(7 downto 0);
	Dout2 : out std_logic_vector(15 downto 0);
	Dout3 : out std_logic_vector(15 downto 0);
	Dout4 : out std_logic_vector(15 downto 0));
end component;

component first_pipeline
port(
	clk : in std_logic;
	alea_in : in std_logic;
	Din1 : in std_logic_vector(7 downto 0);
	Din2 : in std_logic_vector(15 downto 0);
	Din3 : in std_logic_vector(15 downto 0);
	Din4 : in std_logic_vector(15 downto 0);
	Dout1 : out std_logic_vector(7 downto 0);
	Dout2 : out std_logic_vector(15 downto 0);
	Dout3 : out std_logic_vector(15 downto 0);
	Dout4 : out std_logic_vector(15 downto 0));
end component;

component bram16
  port (
  -- System
  sys_clk : in std_logic;
  sys_rst : in std_logic;
  -- Master
  di : out std_logic_vector(15 downto 0);
  we : in std_logic;
  a : in std_logic_vector(15 downto 0);
  do : in std_logic_vector(15 downto 0));
end component;

component bram32
  port (
  -- System
  sys_clk : in std_logic;
  sys_rst : in std_logic;
  -- Master
  di : out std_logic_vector(31 downto 0);
  we : in std_logic;
  a : in std_logic_vector(15 downto 0);
  do : in std_logic_vector(31 downto 0));
end component;

component compteur
port(
	clk: in std_logic;
	alea : in std_logic;
	q : out std_logic_vector(15 downto 0));
end component;

component aleas is 
	port(
		li_di_op : in std_logic_vector (7 downto 0);
		li_di_b : in std_logic_vector (15 downto 0);
		li_di_c : in std_logic_vector (15 downto 0);
		di_ex_op : in std_logic_vector (7 downto 0);
		di_ex_a : in std_logic_vector (15 downto 0);
		ex_mem_op : in std_logic_vector (7 downto 0);
		ex_mem_a : in std_logic_vector (15 downto 0);
		s : out std_logic  --1 si aléa, 0 sinon
		);
end component;

--signal IP
signal ins_a : std_logic_vector(15 downto 0);

--decodeur input
signal ins_di : std_logic_vector(31 downto 0);

--decodeur output
signal LI_DI_OP : std_logic_vector(7 downto 0);
signal LI_DI_A : std_logic_vector(15 downto 0);
signal LI_DI_B : std_logic_vector(15 downto 0);
signal LI_DI_C : std_logic_vector(15 downto 0);

--pipeline LI/DI output
signal LI_DI_OP_OUT : std_logic_vector(7 downto 0);
signal LI_DI_A_OUT : std_logic_vector(15 downto 0);
signal LI_DI_B_OUT : std_logic_vector(15 downto 0);
signal LI_DI_C_OUT : std_logic_vector(15 downto 0);

--pipeline DI/EX : output
signal DI_EX_OP_OUT : std_logic_vector(7 downto 0);
signal DI_EX_A_OUT : std_logic_vector(15 downto 0);
signal DI_EX_B_OUT : std_logic_vector(15 downto 0);
signal DI_EX_C_OUT : std_logic_vector(15 downto 0);

--signal MUX Banc_registre
signal QA_MUX_DI_EX : std_logic_vector(15 downto 0);

--signal MUX Alu
signal S_MUX_EX_MEM: std_logic_vector(15 downto 0);

--signal ALU
signal OP_ALU: std_logic_vector(7 downto 0);
signal flags : std_logic_vector(3 downto 0);
signal S_ALU : std_logic_vector(15 downto 0);

--pipeline EX/MEM : output
signal EX_MEM_OP_OUT : std_logic_vector(7 downto 0);
signal EX_MEM_A_OUT : std_logic_vector(15 downto 0);
signal EX_MEM_B_OUT : std_logic_vector(15 downto 0);

--pipeline MEM/RE 
signal MEM_RE_B_IN : std_logic_vector(15 downto 0);
signal MEM_RE_OP_OUT : std_logic_vector(7 downto 0);
signal MEM_RE_A_OUT : std_logic_vector(15 downto 0);
signal MEM_RE_B_OUT : std_logic_vector(15 downto 0);

--signal de LC W pour Banc_registre
signal LC_W : std_logic;

--signal de banc_registre
signal QA : std_logic_vector(15 downto 0);
signal QB : std_logic_vector(15 downto 0);
signal DATA: std_logic_vector(15 downto 0);

--signal de RAM (pour LOAD/STORE) 16
signal data_di : std_logic_vector(15 downto 0);
signal data_we : std_logic;
signal data_a : std_logic_vector(15 downto  0);
signal data_do : std_logic_vector(15 downto 0);

--signal de RAM 32
signal data32_di : std_logic_vector(31 downto 0);
signal data32_do : std_logic_vector(31 downto 0); --inutile

--signal aleas
signal alea : std_logic;

begin 

--MUX BANC_REGISTRE
QA_MUX_DI_EX <=  QA when (LI_DI_OP_OUT=x"05" or LI_DI_OP_OUT=x"08") 
					else LI_DI_B_OUT;

--LC ALU
with DI_EX_OP_OUT select 	  
	OP_ALU <= DI_EX_OP_OUT(7 downto 0)	when x"01" | x"02" | x"03" | x"04", 
						x"00"	when others;

--MUX ALU	
with DI_EX_OP_OUT select 	  
	S_MUX_EX_MEM <= 	S_ALU	when x"01" | x"02" | x"03" | x"04", 
						DI_EX_B_OUT	when others;

--LC W
LC_W <= '1' when MEM_RE_OP_OUT=x"00"
					or MEM_RE_OP_OUT=x"01"
					or MEM_RE_OP_OUT=x"02"
					or MEM_RE_OP_OUT=x"03"
					or MEM_RE_OP_OUT=x"04"
					or MEM_RE_OP_OUT=x"05"
					or MEM_RE_OP_OUT=x"06"
					or MEM_RE_OP_OUT=x"07"
					or MEM_RE_OP_OUT=x"09"
					or MEM_RE_OP_OUT=x"0a"
					or MEM_RE_OP_OUT=x"0b"
					or MEM_RE_OP_OUT=x"0c"
					or MEM_RE_OP_OUT=x"0d"
					else '0' ;
				

--LC LOAD correspondra a data_we
data_we <= '1' when (EX_MEM_OP_OUT=x"08") else '0'; 

--MUX LOAD
DATA <= data_di when (MEM_RE_OP_OUT=x"07") else MEM_RE_B_OUT;

--MUX STORE
MEM_RE_B_IN <= x"0000" when (EX_MEM_OP_OUT=x"08") else EX_MEM_B_OUT;
data_a <= EX_MEM_A_OUT when (EX_MEM_OP_OUT=x"08" or EX_MEM_OP_OUT=x"07") else x"FFFF";
data_do <= EX_MEM_B_OUT when (EX_MEM_OP_OUT=x"08") else x"FFFF";

--instanciations
Compt : compteur port map(
				clk,
				alea,
				ins_a);

Dec : decodeur port map(
				data32_di,
				LI_DI_OP,
				LI_DI_A,
				LI_DI_B,
				LI_DI_C);
				
Pipe_LI_DI : first_pipeline port map(
				clk,
				alea,
				LI_DI_OP,
				LI_DI_A,
				LI_DI_B,
				LI_DI_C,
				LI_DI_OP_OUT,
				LI_DI_A_OUT,
				LI_DI_B_OUT,
				LI_DI_C_OUT);
				
Pipe_DI_EX : pipeline port map(
				clk, 
				LI_DI_OP_OUT,
				LI_DI_A_OUT,
				QA_MUX_DI_EX,
				QB,
				DI_EX_OP_OUT,
				DI_EX_A_OUT,
				DI_EX_B_OUT,
				DI_EX_C_OUT);
				
Pipe_EX_MEM : pipeline port map(
				clk,
				DI_EX_OP_OUT,
				DI_EX_A_OUT,
				S_MUX_EX_MEM,
				x"0000",
				EX_MEM_OP_OUT,
				EX_MEM_A_OUT,
				EX_MEM_B_OUT,
				open);
				
Pipe_MEM_RE : pipeline port map(
				clk,
				EX_MEM_OP_OUT,
				EX_MEM_A_OUT,
				EX_MEM_B_OUT,
				x"0000",
				MEM_RE_OP_OUT,
				MEM_RE_A_OUT,
				MEM_RE_B_OUT,
				open);

Banc : banc_registre port map(
				clk,
				'1',
				LC_W,
				LI_DI_B_OUT(3 downto 0),
				LI_DI_C_OUT(3 downto 0),
				MEM_RE_A_OUT(3 downto 0),
				DATA,
				QA,
				QB);

Alunity : ALU port map(
				OP_ALU,
				DI_EX_B_OUT,
				DI_EX_C_OUT,
				x"0000",
				flags,
				S_ALU);

memoire : bram16 port map(
				clk,
				'1',
				data_di,
				data_we,
				data_a,
				data_do);

memoire32: bram32 port map(
				clk,
				'1',
				data32_di,
				'0',
				ins_a,
				data32_do);
				
gest_aleas: aleas port map(
				LI_DI_OP,
				LI_DI_B,
				LI_DI_C,
				LI_DI_OP_OUT,
				LI_DI_A_OUT,
				DI_EX_OP_OUT,
				DI_EX_A_OUT,
				alea);
				
end Structure;
				