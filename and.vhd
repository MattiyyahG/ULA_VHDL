library ieee;
use ieee.std_logic_1164.all;

entity and is
    port (
        a     : in  std_logic_vector(3 downto 0);
        b     : in  std_logic_vector(3 downto 0);
        F     : out std_logic_vector(3 downto 0);
        Cout  : out std_logic
    );
end and;

architecture Behavioral of and is
begin
    process(a, b)
    begin
        F(0) <= a(0) and b(0);
        F(1) <= a(1) and b(1);
        F(2) <= a(2) and b(2);
        F(3) <= a(3) and b(3);
        
        if F(0) = '1' and F(1) = '1' and F(2) = '1' and F(3) = '1' then
            Cout <= '1';
        else
            Cout <= '0';
        end if;
    end process;
end Behavioral;