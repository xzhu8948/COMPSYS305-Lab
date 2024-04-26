library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity BCD_counter is
	port (Clk, Direction, Init, Enable : in std_logic;
	      Q_Out : out unsigned (3 downto 0));
end entity BCD_counter;

architecture behaviour of BCD_counter is
	signal Q1: unsigned (3 downto 0);
begin
	process (Clk)
	variable Current_Mode: std_logic := '0';
	begin
		--count
		if (Clk'event and Clk = '1') then

			--initial (initial must be seperated with others to initial everything from beginning)
			if (Init = '1' or Direction /= Current_Mode) then
				if (Direction = '0') then
					Q1 <= "0000";
					Current_Mode := '0';
				elsif (Direction = '1') then
					Q1 <= "1001";
					Current_Mode := '1';
				end if;

			--count
			elsif (Enable = '1') then
				if (Direction = '0') then
					if (Q1 < "1001") then
						Q1 <= Q1 + "0001";
					else
						Q1 <= "0000";
					end if;

				elsif (Direction = '1') then
					if (Q1 > "0000") then
						Q1 <= Q1 - "0001";
					else
						Q1 <= "1001";
					end if;
				end if;
			end if;
		end if;
	end process;
	Q_Out <= Q1;
end architecture behaviour;