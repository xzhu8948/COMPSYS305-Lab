library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- HEX0 = Seconds_oneth
-- HEX1 = Seconds_tenth
-- HEX2 = Minutes
-- KEY (KEY[0]) = Start
-- LEDR (LEDR[0]) = Time_Out
-- SW = Data_In

entity Timer is 
	port (CLOCK_50: in std_logic;
		  KEY: in std_logic_vector (0 downto 0);
	      SW: in std_logic_vector (9 downto 0);
	      HEX2, HEX1, HEX0: out std_logic_vector (6 downto 0);
	      LEDR: out std_logic_vector (0 downto 0));
end entity Timer;

architecture behaviour of Timer is

	signal Mins_Start, Seconds_Tenth_Start, Seconds_Oneth_Start: std_logic_vector (3 downto 0);
	signal Mins_Number, Seconds_Tenth_Number, Seconds_Oneth_Number: std_logic_vector (3 downto 0);
	signal Mins_Enable, Seconds_Tenth_Enable, Seconds_Oneth_Enable: std_logic;
	signal Tenth_Reset: std_logic;
	signal Clock: std_logic;
	signal Clock_counter: std_logic_vector (25 downto 0);
	signal Start: std_logic;

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
	Mins_7Seg: BCD_to_SevenSeg port map (BCD_digit => Mins_Number, SevenSeg_out => HEX2);
	Seconds_Tenth_7Seg: BCD_to_SevenSeg port map (BCD_digit => Seconds_Tenth_Number, SevenSeg_out => HEX1);
	Seconds_Oneth_7Seg: BCD_to_SevenSeg port map (BCD_digit => Seconds_Oneth_Number, SevenSeg_out => HEX0);

	--Oneth_Enable
	Seconds_Oneth_Enable <= '0' when ((Seconds_Oneth_Number = Seconds_Oneth_Start) and (Seconds_Tenth_Number = Seconds_Tenth_Start) and (Mins_Number = Mins_Start)) else '1';
	--Tenth_Enable
	Seconds_Tenth_Enable <= '1' when ((Seconds_Oneth_Number = "1001") and (Seconds_Oneth_Enable = '1')) else '0';
	--Mins_Enable
	Mins_Enable <= '1' when ((Seconds_Tenth_Number = "0101") and (Seconds_Tenth_Enable  = '1')) else '0';

	--Tenth_Reset when it is reach 6
	Tenth_Reset <= '1' when ((Seconds_Tenth_Number = "0101" and Seconds_Tenth_Enable = '1') or Start = '1') else '0';

	--finish count and output Time_Out
	LEDR(0) <= '0' when (Seconds_Oneth_Enable = '0') else '1';

	--initial Start
	Start <= not KEY(0);
	
	--Set the numbers that stops the counter
	process(CLOCK_50)
		variable v_Seconds_Tenth_Start, v_Seconds_Oneth_Start: std_logic_vector (3 downto 0);
	begin
		if (CLOCK_50'event and CLOCK_50 = '1') then
			if (Start = '1') then
				Mins_Start <= "00" & SW (9 downto 8);
				v_Seconds_Tenth_Start := SW (7 downto 4);
				v_Seconds_Oneth_Start := SW (3 downto 0);
				if (v_Seconds_Tenth_Start > "0101") then
					v_Seconds_Tenth_Start := "0101";
				end if;
				Seconds_Tenth_Start <= v_Seconds_Tenth_Start;
				if (v_Seconds_Oneth_Start > "1001") then
					v_Seconds_Oneth_Start := "1001";
				end if;
				Seconds_Oneth_Start <= v_Seconds_Oneth_Start;

				Clock <= not clock;
				Clock_counter <= (others => '0');

			else
				if (Clock_counter = "01011111010111100001000000") then
					Clock <= '0';
				elsif (Clock_counter = "10111110101111000010000000") then
					Clock <= '1';
					Clock_counter <= (others => '0');
				else
					Clock_counter <= Clock_counter + "1";
				end if;
			end if;
		end if;
	end process;

end architecture behaviour;