library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity test_Timer is
end entity test_Timer;

architecture test of Test_timer is
	signal t_clk, t_start: std_logic;
	signal t_data: std_logic_vector (9 downto 0);
	signal t_minutes, t_second_tenth, t_second_oneth: std_logic_vector (6 downto 0);
	signal t_time: std_logic;

	component Timer is
		port (Clock_50M_Hz, Start: in std_logic;
		      Data_In: in std_logic_vector (9 downto 0);
	              Minutes, Seconds_tenth, Seconds_oneth: out std_logic_vector (6 downto 0);
	              Time_Out: out std_logic);
	end component Timer;

begin
	DESIGN: Timer port map (t_clk, t_start, t_data, t_minutes, t_second_tenth, t_second_oneth, t_time);

	Initial_Clk: process
	begin
		t_clk <= '0';
		wait for 20 ns;
		t_clk <= '1';
		wait for 20 ns;
	end process Initial_Clk;

	Initial_Data: process
	begin
		t_data <= "1101011001";
		wait;
	end process Initial_Data;

	Initial_Start: process
	begin
		t_start <= '1', '0' after 10 ns;
		wait;
	end process Initial_Start;

end architecture test;