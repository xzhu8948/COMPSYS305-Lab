library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity test_BCD_counter is
end entity test_BCD_counter;

architecture test of test_BCD_counter is
	signal t_clk, t_direction, t_init, t_enable : bit;
	signal t_Q : std_logic_vector (3 downto 0);

	component BCD_counter is
	port (Clk, Direction, Init, Enable : in bit;
	      Q_Out : out std_logic_vector (3 downto 0));
	end component BCD_counter;

begin
	DUT: BCD_counter port map (t_clk, t_direction, t_init, t_enable, t_Q);

	Clk_set: process
	begin
		t_clk <= '0';
		wait for 5 ns;
		t_clk <= '1';
		wait for 5 ns;
	end process Clk_set;

	Direction_set: process
	begin
		t_direction <= '0', '1' after 300 ns;
		wait for 600 ns;
	end process Direction_set;

	Init_set: process
	begin
		t_init <= '1', '0' after 10 ns, '1' after 60 ns, '0' after 70 ns,'1' after 350 ns, '0' after 360 ns;
		wait for 600 ns;
	end process Init_set;

	Enable_set: process
	begin
		t_enable <= '1', '0' after 500 ns;
		wait for 600 ns;
	end process Enable_set;

end architecture test;
