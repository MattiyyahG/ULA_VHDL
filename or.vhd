library ieee;
use ieee.std_logic_1164.all;

entity or is
    port (
        a     : in  std_logic_vector(3 downto 0);
        b     : in  std_logic_vector(3 downto 0);
        F     : out std_logic_vector(3 downto 0);
        Cout  : out std_logic
    );
end or;

architecture Behavioral of or is
begin
    process(a, b)
    begin
        F(0) <= a(0) or b(0);
        F(1) <= a(1) or b(1);
        F(2) <= a(2) or b(2);
        F(3) <= a(3) or b(3);
        
        if F(0) = '0' and F(1) = '0' and F(2) = '0' and F(3) = '0' then
            Cout <= '0';
        else
            Cout <= '1';
        end if;
    end process;
end Behavioral;
