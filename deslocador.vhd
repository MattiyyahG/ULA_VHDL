library ieee;

use ieee.std_logic_1164.all;

--- desloca 1 bit de a para a direita se B(0)=1 e para esquerda se B(0)=0--

entity reserva is 

	port(a, b : IN std_logic_vector (3 downto 0);

	    saidaR : OUT std_logic_vector (3 downto 0)

	);

end reserva;

architecture dados of reserva is
	
	begin

		saidaR(0)<=((a(1) and b(0)) or(a(3) and not(b(0))));

		saidaR(1)<=((a(2) and b(0)) or(a(0) and not(b(0))));

		saidaR(2)<=((a(3) and b(0)) or(a(1) and not(b(0))));

		saidaR(3)<=((a(0) and b(0)) or(a(2) and not(b(0))));
		
end dados;