library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity lab2_q2 is
	port(Clk, Direction, Enable, Init: in std_logic;
	     Q:  out unsigned(3 downto 0));
end entity lab2_q2; 

architecture operation of lab2_q2 is
begin
	process(Clk)
	variable counter: integer ;
	variable t_mode: std_logic :='0';
	begin
-- process the enable

	if (Clk'event and Clk = '1') then
		if(Direction /= t_mode or Init = '1') then
			if( Direction ='0') then
				counter :=0;
				t_mode := '0';
			else
				counter:= 9;
				t_mode := '1';
			end if;
		elsif(Enable = '1') then			
			if (Direction ='0') then
				if (counter < 9) then
 					counter:= counter + 1;
 				else
					counter:= 0;
 				end if;	

-- when direction is 1, it is a down counter
			else
				if (counter > 0) then
 					counter:= counter - 1;
 				else
					counter:= 9;
 				end if;	
			end if;
		else
			null;
		end if;

	Q<=to_unsigned(counter,Q'length);

	end if;

	end process;
end architecture operation;
