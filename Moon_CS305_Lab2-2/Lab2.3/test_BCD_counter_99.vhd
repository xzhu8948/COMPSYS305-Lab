library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity test_BCD_counter_99 is
end entity test_BCD_counter_99;

architecture test of test_BCD_counter_99 is
	signal t_clk, t_reset, t_enable : std_logic;
	signal t_result : unsigned (7 downto 0);

	component BCD_counter_99 is
	port (Clk, Reset, Enable : in std_logic;
	      Result_counter : out unsigned (7 downto 0));
	end component;

begin
	DUT: BCD_counter_99 port map (t_clk, t_reset, t_enable, t_result);

	Clk_set: process
	begin
		t_clk <= '0';
		wait for 5 ns;
		t_clk <= '1';
		wait for 5 ns;
	end process Clk_set;

	Reset_set: process
	begin
		t_reset <= '1', '0' after 10 ns, '1' after 60 ns, '0' after 70 ns;
		wait for 1500 ns;
	end process Reset_set;

	Enable_set: process
	begin
		t_enable <= '1', '0' after 1400 ns;
		wait for 1500 ns;
	end process Enable_set;

end architecture test;
