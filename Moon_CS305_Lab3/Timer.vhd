library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Timer is 
	port (Clock_50M_Hz, Start: in std_logic;
	      Data_In: in std_logic_vector (9 downto 0);
	      Minutes, Seconds_tenth, Seconds_oneth: out std_logic_vector (6 downto 0);
	      Time_Out: out std_logic);
end entity Timer;

architecture behaviour of Timer is

	signal Mins_Start, Seconds_Tenth_Start, Seconds_Oneth_Start: std_logic_vector (3 downto 0);
	signal Mins_Number, Seconds_Tenth_Number, Seconds_Oneth_Number: std_logic_vector (3 downto 0);
	signal Mins_Enable, Seconds_Tenth_Enable, Seconds_Oneth_Enable: std_logic;
	signal Tenth_Reset: std_logic;
	signal Clock: std_logic;
	signal Clock_counter: std_logic_vector (25 downto 0);

	component BCD_counter is 
		port (Clk, Direction, Init, Enable : in std_logic;
		      Q_Out : out std_logic_vector (3 downto 0));
	end component BCD_counter;

	component BCD_to_SevenSeg is 
		port (BCD_digit : in std_logic_vector(3 downto 0);
		      SevenSeg_out : out std_logic_vector(6 downto 0));
	end component BCD_to_SevenSeg;

begin

	--counter
	Mins_Counter: BCD_counter port map (Clk => Clock, Direction => '0', Init => Start, Enable => Mins_Enable, Q_out => Mins_Number);
	Seconds_Tenth_Counter: BCD_counter port map (Clk => Clock, Direction => '0', Init => Tenth_Reset, Enable => Seconds_Tenth_Enable, Q_out => Seconds_Tenth_Number);
	Seconds_Oneth_Counter: BCD_counter port map (Clk => Clock, Direction => '0', Init => Start, Enable => Seconds_Oneth_Enable, Q_out => Seconds_Oneth_Number);

	--output 7Seg
	Mins_7Seg: BCD_to_SevenSeg port map (BCD_digit => Mins_Number, SevenSeg_out => Minutes);
	Seconds_Tenth_7Seg: BCD_to_SevenSeg port map (BCD_digit => Seconds_Tenth_Number, SevenSeg_out => Seconds_tenth);
	Seconds_Oneth_7Seg: BCD_to_SevenSeg port map (BCD_digit => Seconds_Oneth_Number, SevenSeg_out => Seconds_oneth);

	--Oneth_Enable
	Seconds_Oneth_Enable <= '0' when ((Seconds_Oneth_Number = Seconds_Oneth_Start) and (Seconds_Tenth_Number = Seconds_Tenth_Start) and (Mins_Number = Mins_Start)) else '1';
	--Tenth_Enable
	Seconds_Tenth_Enable <= '1' when (Seconds_Oneth_Number = "1001") else '0';
	--Mins_Enable
	Mins_Enable <= '1' when (Seconds_Tenth_Number = "0110") else '0';

	--Tenth_Reset when it is reach 6
	Tenth_Reset <= '1' when (Seconds_Tenth_Number = "0110" or Start = '1') else '0';

	--finish count and output Time_Out
	Time_Out <= '1' when (Seconds_Oneth_Enable = '0') else '0';
	
	--Set the numbers that stops the counter
	process(Clock_50M_Hz)
		variable v_Seconds_Tenth_Start, v_Seconds_Oneth_Start: std_logic_vector (3 downto 0);
	begin
		if (Clock_50M_Hz'event and Clock_50M_Hz = '1') then
			if (Start = '1') then
				Mins_Start (1 downto 0) <= Data_In (9 downto 8);
				v_Seconds_Tenth_Start := Data_In (7 downto 4);
				v_Seconds_Oneth_Start := Data_In (3 downto 0);
				if (v_Seconds_Tenth_Start > "0101") then
					Seconds_Tenth_Start <= "0101";
				end if;
				if (v_Seconds_Oneth_Start > "1001") then
					Seconds_Tenth_Start <= "1001";
				end if;

				Clock <= '1';
				Clock_counter <= "00000000000000000000000000";

			else
				if (Clock_counter = "01011111010111100001000000") then
					Clock <= '0';
				elsif (Clock_counter = "10111110101111000010000000") then
					Clock <= '1';
					Clock_counter <= "00000000000000000000000000";
				else
					Clock_counter <= Clock_counter + "00000000000000000000000001";
				end if;
			end if;
		end if;
	end process;

end architecture behaviour;