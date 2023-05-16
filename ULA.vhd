library ieee;
use ieee.std_logic_1164.all;

entity ULA is --nossa ULA
    port( 
		a, b: IN std_logic_vector (3 downto 0); --numeros a serem operados
		op : IN std_logic_vector (2 downto 0);-- operação que vai ser feita
		enable : IN std_logic; --enable
		res: OUT std_logic_vector (3 downto 0);-- vetor de saida
        cout,nulo,neg,ovrf: OUT std_logic --- flags
		  ); 
end ULA;

architecture dados of ULA is
signal s,res_soma,res_soma3,res_subt,res_subt1, res_prio, res_quant, res_des, res_reser, res_comp: std_logic_vector(3 downto 0);
constant zero,zero3 : std_logic := '0';
signal carryout1, carryout2,carryout3,carryout4, overflow1, overflow2, overflow3, overflow4 : std_logic;
signal x1, x2, x3, x4,x5,x6,x7,x8, aux: std_logic; -- variaveis intermediarias


COMPONENT subtrator4 is 
    port( 
		na, nb: IN std_logic_vector (3 downto 0) ; ---vetor de entrada
		subt: OUT std_logic_vector (3 downto 0); ----vetor de saida
		carry_out,overflow: OUT std_logic ----bit de carry out e overflow
            );
END COMPONENT subtrator4;

COMPONENT somador4 IS
PORT ( 
a, b: IN std_logic_vector (3 downto 0); 
carry_in: IN std_logic;
soma: OUT std_logic_vector (3 downto 0);
carry_out,overflow: OUT std_logic
);
END COMPONENT somador4;

COMPONENT prioridade IS
PORT( 
		a, b: IN std_logic_vector (3 downto 0);
			prio, quantidade: OUT std_logic_vector (3 downto 0)
				);
END COMPONENT prioridade;

COMPONENT deslocador IS
	port( 
		a, b: IN std_logic_vector (3 downto 0);
		deslocado: OUT std_logic_vector (3 downto 0)
	);	

END COMPONENT deslocador;


COMPONENT reserva is 
    port( a,b : IN std_logic_vector (3 downto 0); --- recebe a, b 
			saidaR : OUT std_logic_vector (3 downto 0)-- devolve o resultado
			);

END COMPONENT reserva;

COMPONENT comparar is 
	port( a,b : IN std_logic_vector (3 downto 0); --- recebe a, b 
			saidaR : OUT std_logic_vector (3 downto 0)-- devolve o resultado
			);
END COMPONENT comparar;




	begin
	add: somador4 port map (a, b, zero, res_soma, carryout2, overflow2); --- soma de a e b
	subt0: subtrator4 PORT MAP (a, b, res_subt, carryout1, overflow1); ---- subtração 
	add1: somador4 port map (a, "0001", zero3, res_soma3, carryout3, overflow3); --- para o incremento de 1
	subt1: subtrator4 PORT MAP ("0000", a, res_subt1, carryout4, overflow4); --- complemento de 2
	prio: prioridade port map (a, b, res_prio);--prioridade
	desl: deslocador port map (a, b, res_des); -- deslocador
	reser:reserva port map(a, b, res_reser); -- deslocador reserva
	compar: comparar port map(a, b, res_comp);-- comparador
    
    
    ---- logica de enable, para ativar o que a gente quer que seja feito--
	x1<= (enable) and ((not (op(2))) and (not (op (1))) and (not (op (0)))); -- para subtração(a-b)  000
	x2<= (enable) and ((not (op(2))) and (not (op (1))) and ( (op (0)))); --- para soma   001
	x3<=(enable) and ((not (op(2))) and ( (op (1))) and (not (op (0)))); -- para incremento de um de a 010
	x4<= (enable) and ((not (op(2))) and ( (op (1))) and ( (op (0)))); --- para complemento de 2 de a 011
	x5<= (enable) and (( (op(2))) and (not (op (1))) and (not (op (0)))); ---para or  bit a bit  a e b 100
	x6<= (enable) and (( (op(2))) and ( not (op (1))) and ( (op (0)))); --- prioridade 101
	x7<= (enable) and (((op(2))) and ( (op (1))) and ( not (op (0)))); -- comparador 110
	x8<=  (enable) and (( (op(2))) and ( (op (1))) and ((op (0)))); -- para AND bit a bit  a e b 111
	
	--- agora fazemos a lógica para o resultado
	s (3)<=(x1 and res_subt(3)) or (x2 and res_soma(3)) or (x3 and res_soma3(3)) or (x4 and res_subt1(3)) or (x5 and (a(3) or b(3))) or (x6 and res_prio(3)) or (x7 and res_comp(3)) or   (x8 and (a(3) and b(3)))  ;
	s (2)<=(x1 and res_subt(2)) or (x2 and res_soma(2)) or (x3 and res_soma3(2)) or (x4 and res_subt1(2)) or (x5 and (a(2) or b(2))) or (x6 and res_prio(2)) or (x7 and res_comp(2)) or   (x8 and (a(2) and b(2)))  ;
	s (1)<=(x1 and res_subt(1)) or (x2 and res_soma(1)) or (x3 and res_soma3(1)) or (x4 and res_subt1(1)) or (x5 and (a(1) or b(1))) or (x6 and res_prio(1)) or (x7 and res_comp(1)) or   (x8 and (a(1) and b(1)))  ;
	s (0)<=(x1 and res_subt(0)) or (x2 and res_soma(0)) or (x3 and res_soma3(0)) or (x4 and res_subt1(0)) or (x5 and (a(0) or b(0))) or (x6 and res_prio(0)) or (x7 and res_comp(0)) or   (x8 and (a(0) and b(0)))  ;
	res<=s;
	
	
	
	
   neg<=((s(3) and x1) or (x4 and s(3)));
	cout <= (x1 and carryout1) or (x2 and carryout2) or (x3 and carryout3) or (x4 and carryout4);
	aux <=  (x1 and overflow1) or (x2 and overflow2) or (x3 and overflow3) or (x4 and overflow4);
	nulo <= ((not aux) and enable and (not s(3)) and (not  s(2)) and ( not s(1)) and (not s (0)));
	ovrf <= aux;
	


end dados;