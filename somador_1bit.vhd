library ieee;

use ieee.std_logic_1164.all;

--- somador simples de 1 bit

entity somador is 

	port(a, b, carry_in : IN std_logic;

			carry_out, soma : OUT std_logic

	);

end somador;

architecture dados of somador is

	signal x1, x2, x3, x4, y1 : std_logic;
	
	begin

		x1 <= a and b; 

		x2 <= a and carry_in;  

		x3 <= b and carry_in; 

		x4 <= x1 or x2; 

		carry_out <= x3 or x4;  

		y1 <= a xor b;

		soma <= y1 xor carry_in;

end dados;