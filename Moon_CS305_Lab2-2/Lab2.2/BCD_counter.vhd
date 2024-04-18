library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BCD_counter is
	port (Clk, Direction, Init, Enable : in bit;
	      Q_Out : out std_logic_vector (3 downto 0));
end entity BCD_counter;

architecture behaviour of BCD_counter is
	signal Q1: std_logic_vector (3 downto 0);
begin
	process (Clk)
	begin
		if (Clk'event and Clk = '1') then
			if (Enable = '1') then
				if (Direction = '0') then
					if (Init = '0') then
						if (Q1 = "1001") then
							Q1 <= "0000";
						else
							Q1 <= Q1 + "0001";
						end if;
					else
						Q1 <= "0000";
					end if;

				elsif (Direction = '1') then
					if (Init = '0') then
						if (Q1 = "0000") then
							Q1 <= "1001";
						else
							Q1 <= Q1 - "0001";
						end if;
					else
						Q1 <= "1001";
					end if;
				end if;
			end if;
		end if;
	end process;
	Q_Out <= Q1;
end architecture behaviour;