-- Testbench for the counter. 
entity test_counter is
end entity test_counter;

architecture my_test of test_counter is 
    signal t_clk, t_reset : bit;
    signal t_Q : integer;

    component counter is 
        port (Clk, Reset : in bit;
              Q : out integer);
    end component counter;
begin
     DUT: counter port map (t_clk, t_reset, t_Q);
 
     -- Initialization process (code that executes only once).
     init: process
     begin 
       -- reset pulse
       t_reset <= '0', '1' after 2 ns, '0' after 7 ns;
         wait;
     end process init;

     -- clock generation
     clk_gen: process
     begin
         wait for 5 ns;
         t_clk <= '1'; 
         wait for 5 ns;
         t_clk <= '0';
     end process clk_gen;  
end architecture my_test;
