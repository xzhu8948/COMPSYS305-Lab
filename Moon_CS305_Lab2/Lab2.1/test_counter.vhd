-- Testbench for the counter. 
entity test_counter is
end entity test_counter;

architecture my_test of test_counter is 
    signal t_clk, t_reset, t_enable : bit;
    signal t_mode : bit_vector (1 downto 0);
    signal t_Q : bit_vector (3 downto 0);

    component combined4counter is 
        port (Clk, Reset, Enable : in bit;
              Mode : in bit_vector (1 downto 0);
              Q : out bit_vector (3 downto 0));
    end component combined4counter;
begin
     DUT: combined4counter port map (t_clk, t_reset, t_enable, t_mode, t_Q);
 
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
      t_clk <= '1'; 
      wait for 5 ns;
      t_clk <= '0';
      wait for 5 ns;
     end process clk_gen;  
     
     -- enable set
     enable_set: process
     begin
      t_enable <= '1';
     end process enable_set;
     
     -- mode set
     mode_set: process
     begin
      t_mode <= "00";
      wait for 10 ns;
      t_mode <= "01";
      wait for 10 ns;
      t_mode <= "10";
      wait for 10 ns;
      t_mode <= "11";
      wait for 10 ns;
     end process mode_set;
     
end architecture my_test;
