library ieee;

use ieee.std_logic_1164.all;

--- compara A com B e retorna "1100" caso A>B, "0011" caso B<0 e "1111" caso A==B --

entity comparar is 

	port( a,b : IN std_logic_vector (3 downto 0); --- recebe a, b

			saidaR : OUT std_logic_vector (3 downto 0)-- devolve o resultado

		);

end comparar;

architecture dados of comparar is

	signal b0, b1, b2, gp, et : std_logic; -- variaveis intermediarias
	
	begin

	b2<=(not(b(3)) and not(b(2)));

	b1<= (b2 and not(b(1)));

	b0<= (b1 and not(b(0)));

	gp<=((a(3)and  not(b(3))) or (a(2)and b2) or (a(1)and b1) or (a(0) and b0));--A greater than B--(vê se há algum bit B(n) de relevância maior ou igual a A(n) )
	
	et<= ((a(3)xnor b(3)) and (a(2)xnor b(2)) and (a(1)xnor b(1)) and (a(0)xnor b(0))); --A equal to B
	
	--sendo B>A caso não gp nem et
	
	saidaR(0)<=(not(gp));
	
	saidaR(1)<=(not(gp));
	
	saidaR(2)<=(gp or et);
	
	saidaR(3)<=(gp or et);
		
		
	end dados;