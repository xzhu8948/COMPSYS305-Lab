library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- Testbech for Question 2
 entity test_lab2_q2 is
 end entity test_lab2_q2;
 architecture test of test_lab2_q2 is
    signal t_clk, t_direction, t_enable, t_init : std_logic;
    signal t_Q : unsigned(3 downto 0);
 component lab2_q2 is
port (Clk, Direction, Enable, Init: in std_logic;
	Q:  out unsigned(3 downto 0));
 end component;
 begin my_design: lab2_q2 port map (t_clk, t_direction, t_enable, t_init, t_Q);
 -- Initialization process (code that executes only once).
 init: process
 begin
 -- enable signal
	t_enable <= '1', '0' after 500 ns;
	t_direction <= '0', '1' after 300 ns;
	t_init <= '1', '0' after 10 ns, '1' after 60 ns, '0' after 70 ns,'1' after 350 ns, '0' after 360 ns;
 wait for 600 ns;
 end process init;

clk_gen: process
     begin
         t_clk <= '0'; 
         wait for 5 ns;
         t_clk <= '1';
         wait for 5 ns;
     end process clk_gen;  

end architecture test;