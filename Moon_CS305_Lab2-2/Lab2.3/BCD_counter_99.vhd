library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BCD_counter_99 is
	port (Clk, Reset, Enable : in bit;
	      Result_counter : out std_logic_vector (6 downto 0));
end entity BCD_counter_99;

architecture behaviour of BCD_counter_99 is
	component BCD_counter is
		port (Clk, Direction, Init, Enable : in bit;
		      Q_Out : out std_logic_vector (3 downto 0));
	end component BCD_counter;

	signal result_left, result_right : std_logic_vector (3 downto 0);

begin
	process (Clk)
	begin
		BCD: BCD_counter port map (Clk => Clk; Direction => '1', Init => Reset, Enable => Enable, Q_Out => result_right);
	