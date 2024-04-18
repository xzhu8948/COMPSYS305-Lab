-- Testbench for the counter. 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity test_counter is
end entity test_counter;

architecture my_test of test_counter is 
    signal t_clk, t_reset, t_enable : bit;
    signal t_mode : std_logic_vector (1 downto 0);
    signal t_Q : std_logic_vector (3 downto 0);

    component combined4counter is 
        port (Clk, Reset, Enable : in bit;
              Mode : in std_logic_vector (1 downto 0);
              Q : out std_logic_vector (3 downto 0));
    end component combined4counter;
begin
     DUT: combined4counter port map (t_clk, t_reset, t_enable, t_mode, t_Q);
 
     -- Initialization process (code that executes only once).
     init: process (t_mode)
     begin 
       -- reset pulse
       t_reset <= '1', '0' after 1 ns;
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
      wait;
     end process enable_set;
     
     -- mode set
     mode_set: process
     begin
      t_mode <= "00";
      wait for 100 ns;
      t_mode <= "01";
      wait for 100 ns;
      t_mode <= "10";
      wait for 100 ns;
      t_mode <= "11";
      wait for 100 ns;
     end process mode_set;
     
end architecture my_test;
