library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity BCD_counter_99 is
	port (Clk, Reset, Enable : in std_logic;
	      Result_counter : out unsigned (7 downto 0));
end entity BCD_counter_99;

architecture behaviour of BCD_counter_99 is
	component BCD_counter is
		port (Clk, Direction, Init, Enable : in std_logic;
		      Q_Out : out unsigned (3 downto 0));
	end component;

signal result_left, result_right : unsigned (3 downto 0);
signal Enable_tenth : std_logic;

begin

	oneth: BCD_counter port map (Clk => Clk, Direction => '1', Init => Reset, Enable => Enable, Q_Out => result_right);

	Enable_tenth <= '1' when result_right = 0 else '0';

	tenth: BCD_counter port map (Clk => Clk, Direction => '1', Init => Reset, Enable => Enable_tenth, Q_Out => result_left);

	Result_counter <= result_left*10 + result_right;

end architecture behaviour;