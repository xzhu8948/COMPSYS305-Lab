library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Timer is 
	port (Clock, Start: in std_logic;
	      Data_In: in std_logic_vector (9 downto 0);
	      Minutes, Seconds_tenth, Seconds_oneth: out std_logic_vector (6 downto 0);
	      Time_Out: out std_logic);
end entity Timer;

architecture behaviour of Timer is

	signal Mins_Number, Seconds_Tenth_Number, Seconds_Oneth_Number: std_logic_vector(3 downto 0);
	signal Mins_Enable, Seconds_Tenth_Enable, Seconds_Oneth_Enable: std_logic;

	component BCD_counter is 
		port (Clk, Direction, Init, Enable : in std_logic;
		      Q_Out : out std_logic_vector (3 downto 0));
	end component BCD_counter;

	component BCD_to_7Seg is 
		port (BCD_digit : in std_logic_vector(3 downto 0);
		      SevenSeg_out : out std_logic_vector(6 downto 0));
	end component BCD_to_7Seg;

begin

	Mins_Number (1 downto 0) <= Data_In (9 downto 8);
	Seconds_Tenth_Number <= Data_In (7 downto 4);
	Seconds_Oneth_Number <= Data_In (3 downto 0);

	--Oneth_Enable
	Seconds_Oneth_Enable <= '1';
	--Tenth_Enable
	Seconds_Tenth_Enable <= '1' when (Seconds_Oneth_Number = "0000") else '0';
	--Mins_Enable
	Mins_Enable <= '1' when (Seconds_Tenth_Number = "0000") else '0';

	--counter
	Mins_Counter: BCD_counter port map (Clk => Clock, Direction => '1', Init => Start, Enable => Mins_Enable, Q_out => Mins_Number);
	Seconds_Tenth_Counter: BCD_counter port map (Clk => Clock, Direction => '1', Init => Start, Enable => Seconds_Tenth_Enable, Q_out => Seconds_Tenth_Number);
	Seconds_Oneth_Counter: BCD_counter port map (Clk => Clock, Direction => '1', Init => Start, Enable => Seconds_Oneth_Enable, Q_out => Seconds_Oneth_Number);


	--output 7Seg
	Mins_7Seg: BCD_to_7Seg port map (BCD_digit => Mins_Number, SevenSeg_out => Minutes);
	Seconds_Tenth_7Seg: BCD_to_7Seg port map (BCD_digit => Seconds_Tenth_Number, SevenSeg_out => Seconds_tenth);
	Seconds_Oneth_7Seg: BCD_to_7Seg port map (BCD_digit => Seconds_Oneth_Number, SevenSeg_out => Seconds_oneth);

	--finish count and output Time_Out
	Time_Out <= '1' when ((Mins_Number = "0000") and (Seconds_Tenth_Number = "0000") and (Seconds_Oneth_Number = "0000")) else '0';

end architecture behaviour;