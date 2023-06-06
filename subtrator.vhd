library ieee;

use ieee.std_logic_1164.all;

entity subtrator4 is 

    port( 

		na, nb: IN std_logic_vector (3 downto 0) ;

		s: INOUT std_logic_vector (3 downto 0) ;

		subt: OUT std_logic_vector (3 downto 0);

		carry_out,overflow: OUT std_logic

            );

end subtrator4;

architecture dados of subtrator4 is

signal psub, x, y : std_logic_vector(3 downto 0) := "0000";

constant cc : std_logic :='1';-----  carry in = 1 para o complemento de 2

signal cout, ovrf : std_logic;



COMPONENT somador4 is

PORT ( 

a, b: IN std_logic_vector (3 downto 0); 

carry_in: IN std_logic;

soma: OUT std_logic_vector (3 downto 0);

carry_out, overflow: OUT std_logic

);

END COMPONENT somador4;

begin
 
s <= NOT nb; -- recebe b barrado para o complemento de 2

add : somador4 port map (na, s, cc, subt, carry_out, overflow); -- faz a soma em complemento de dois entre a e b barrado
	 

end dados;