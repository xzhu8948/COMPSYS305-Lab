entity combined4counter is
  port (Clk, Reset, Enable : in bit;
        Mode : in bit_vector (1 downto 0);
        Q : out bit_vector (3 downto 0));
end entity combined4counter;

architecture behaviour1 of combined4counter is
begin
  process (Clk)
    variable v_Q: integer;
  begin
    
    if Clk'event and Clk = '1' then
      
      if Mode = "00" then
        
        if Enable = '0' then
          v_Q := v_Q;
        elsif Reset = '1' then
          v_Q := '11';
        elsif v_Q > '1' and v_Q <= '11' then
          v_Q := v_Q - '1';
        else
          v_Q := '11';
        end if;
        
      elsif Mode = "01" then
        
        if Enable = '0' then
          v_Q := v_Q;
        elsif Reset = '1' then
          v_Q := '10';
        elsif v_Q = '10' then
          v_Q := '5';
        elsif v_Q = '5' then
          v_Q := '8';
        elsif v_Q = '8' then
          v_Q := '3';
        elsif v_Q = '3' then
          v_Q := '7';
        elsif v_Q = '7' then
          v_Q := '6';
        elsif v_Q = '6' then
          v_Q := '12';
        else
          v_Q := '10';
        end if;
      
      elsif Mode = "10" then
        
        if Enable = '0' then
          v_Q := v_Q;
        elsif Reset = '1' then
          v_Q := '1';
        elsif v_Q < '13' and v_Q >= '1' then
          v_Q := v_Q + '1';
        else
          v_Q := '1';
        end if;
        
      elsif Mode = "11" then
        
        v_Q := "1111";
        
      end if;
      
    end if;
    
    Q <= v_Q;
    
  end process;
end architecture behaviour1;