library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity combined4counter is
  port (Clk, Reset, Enable : in bit;
        Mode : in std_logic_vector (1 downto 0);
        Q : out std_logic_vector (3 downto 0));
end entity combined4counter;

architecture behaviour1 of combined4counter is
	signal Q1: std_logic_vector (3 downto 0);
begin
  process (Clk, Reset)
  begin

-- Reset from the begining
    if (Reset'event and Reset='1') then
	   if Mode = "00" then
		    Q1 <= "1011";
	   elsif Mode = "01" then
		    Q1 <= "1010";
	   elsif Mode = "10" then
		    Q1 <= "0001";
	   elsif Mode = "10" then
		    Q1 <= "1111";
	   end if;

    elsif (Clk'event and Clk='1') then

-- Start counter
-- Mode "00"
      if Mode = "00" then
        if Enable = '1' then
        	if Q1 > "0001" and Q1 <= "1011" then
          		Q1 <= Q1 - "0010";
        	else
          		Q1 <= "1011";
        	end if;
	      elsif Enable = '0' then
		        Q1 <= Q1;
	      end if;

-- Mode "01"
      elsif Mode = "01" then
        if Enable = '1' then
		     if Q1 = "1010" then
          		Q1 <= "0101";
        	elsif Q1 = "0101" then
          		Q1 <= "1000";
        	elsif Q1 = "1000" then
          		Q1 <= "0011";
        	elsif Q1 = "0011" then
          		Q1 <= "0111";
        	elsif Q1 = "0111" then
          		Q1 <= "0110";
        	elsif Q1 = "0110" then
          		Q1 <= "1100";
        	else
          		Q1 <= "1010";
        	end if;
	      elsif Enable = '0' then
		        Q1 <= Q1;
	      end if;

-- Mode "10"
      elsif Mode = "10" then
        if Enable = '1' then
        	if Q1 < "1101" and Q1 >= "0001" then
          		Q1 <= Q1 + "0001";
        	else
          		Q1 <= "0001";
        	end if;
	      elsif Enable = '0' then
		        Q1 <= Q1;
	      end if;
        
-- Mode "11"
      elsif Mode = "11" then
        
        Q1 <= "1111";
        
      end if;
      
     end if;
    
   end process;

   Q <= Q1;
end architecture behaviour1;