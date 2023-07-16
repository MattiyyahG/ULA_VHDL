library ieee;

use ieee.std_logic_1164.all;

entity somador4 is 

    port( 

		a, b: IN std_logic_vector (3 downto 0); --- entradas vetores de 4 bits a serem somados

		carry_in: IN std_logic; --- carry

		soma: OUT std_logic_vector (3 downto 0); --- resultado

		carry_out, overflow: OUT std_logic --- flags do resultado 
		
            );

end somador4;

architecture dados of somador4 is

signal cout, s, soma1, soma2 : std_logic_vector(3 downto 0);

signal x1, x2, x3, x4, x5, x6, x7, x8 : std_logic;


COMPONENT somador IS --- somador para cada bit

PORT ( 

a, b, carry_in : IN std_logic;

soma, carry_out: OUT std_logic

);

END COMPONENT somador;

    begin

    
        add0: somador port map(a(0), b(0), carry_in, soma1(0), cout(0));

        add1: somador PORT MAP(a(1), b(1), cout(0), soma1(1), cout(1));

        add2: somador PORT MAP(a(2), b(2), cout(1), soma1(2), cout(2));

        add3: somador PORT MAP(a(3), b(3), cout(2), soma1(3), cout(3));
     

     
    x1 <= a(3) xnor b(3);

    x2 <= a(3) xor b(3);

    x3 <= a(3) and b(3);

    x4 <= (not a(3)) and (not b(3));

    soma(3) <= (x1 and a(3)) or (x2 and soma1(3));

    soma(2) <= soma1(2);

	soma(1) <= soma1(1);

	soma(0) <= soma1(0);

    carry_out <= ( x1 and cout(2));

    overflow <= (cout(2) and x4) or (x3 and (not(cout(2))));
   
end dados;