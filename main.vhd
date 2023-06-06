library ieee;

use ieee.std_logic_1164.all;

entity main is -- Só juntando o modulo da ula ao contador e ao display LCD

	port(eop : IN std_logic_vector (2 downto 0);

			CLOCK: std_logic;

			e4 : in std_logic; --enable

			SaidaS: out std_logic_vector (3 downto 0);

			fneg, fcout, fnulo, fovrf: OUT std_logic

		);

end main;

architecture dados of main is

	signal EA, EB : std_logic_vector(3 downto 0); 

	signal AB : std_logic_vector(7 downto 0);

	signal F, G, H, I: std_logic;
	
COMPONENT ULA is 

    port( 

		a, b: IN std_logic_vector (3 downto 0); --numeros a serem operados

		op : IN std_logic_vector (2 downto 0);-- operação que vai ser feita

		enable : IN std_logic; --enable

		res: OUT std_logic_vector (3 downto 0);-- vetor de saida

        cout, nulo, neg, ovrf: OUT std_logic --- flags

		); 

END COMPONENT ULA;
	
COMPONENT counter_seconds is  

    port(CLOCK_50, en: in std_logic;

    counter_out: out std_logic_vector(7 downto 0)

    );

END COMPONENT counter_seconds;
	
begin

	pula: ULA port map (EA, EB, eop, e4, SaidaS, fcout, fnulo, fneg, fovrf);

	pcounter: counter_seconds port map (CLOCK, e4, AB);
	
	EA <= AB(3 downto 0);

	EB <= AB(7 downto 4);
	
end dados;