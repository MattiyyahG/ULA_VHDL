library ieee;

use ieee.std_logic_1164.all;

entity prioridade is

		port( 

		a, b: IN std_logic_vector (3 downto 0);

		prio, quantidade: OUT std_logic_vector (3 downto 0)

		);

end prioridade;

architecture dados of prioridade is

signal x1, x2, x3, x4, y0, y1, y2, y3, y4, y5, y6, w0, z0, z1, z2, z3, w1, v0, v1, v2, v3, w2: std_logic;

begin

x1 <= (a(1) and (not(a(0))));

x2 <= a(3) and (not(a(2))) and (not(a(0)));

x3 <= a(2) and (not(a(1))) and (not(a(0)));

x4 <= a(3) and (not(a(1))) and (not(a(0)));

prio(0) <= x1 or x2;-- Retorna o bit de menor prioridade, ou seja, o bit igual a 1, mais a direita  

prio(1) <= x4 or x3;-- Sendo 0000 o primeiro bit, 0001 o segundo, 0010 o terceiro e 0011 o quarto  

prio(2) <= '0';

prio(3) <= '0';

end dados;