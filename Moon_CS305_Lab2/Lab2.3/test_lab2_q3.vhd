library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- Testbech for Question 3
 entity test_lab2_q3 is
 end entity test_lab2_q3;
 architecture test of test_lab2_q3 is
    signal t_clk, t_enable, t_reset : std_logic;
    signal t_Q : unsigned(7 downto 0);
 component lab2_q3 is
port (Clk, Enable, Reset: in std_logic;
	Q:  out unsigned(7 downto 0));
 end component;
 begin my_design: lab2_q3 port map (t_clk, t_enable, t_reset, t_Q);
 -- Initialization process (code that executes only once).
 init: process
 begin
 -- enable signal
	t_enable <= '1', '0' after 1400 ns;
	t_reset<= '1', '0' after 10 ns, '1' after 60 ns, '0' after 70 ns;
 wait for 1500 ns;
 end process init;

clk_gen: process
     begin
         t_clk <= '0'; 
         wait for 5 ns;
         t_clk <= '1';
         wait for 5 ns;
     end process clk_gen;  

end architecture test;