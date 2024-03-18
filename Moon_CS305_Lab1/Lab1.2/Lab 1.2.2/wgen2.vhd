entity wgen2 is
  port (Enable : in bit;
        X : in bit_vector(2 downto 0);
        A, B, C, Z : out bit);
end entity wgen2;

architecture behaviour2 of wgen2 is
  signal A1, B1, C1: bit;
  signal Z1: bit;
begin
  process
    begin
      
      wait for 0 ns;
      
      if Enable = '0' then
        A1 <= '0';
        B1 <= '0';
        C1 <= '0';
      elsif Enable = '1' then
        A1 <= '1', '0' after 2 ns, '1' after 3 ns, '0' after 4 ns;
        B1 <= '0', '1' after 1 ns, '0' after 2 ns, '1' after 3 ns, '0' after 4 ns;
        C1 <= '1', '0' after 1 ns, '1' after 2 ns, '0' after 3 ns, '1' after 4 ns;
      end if;
      
  wait for 5 ns;
  end process;
  
  process
    begin
      
    wait for 0 ns;
    
    wait for 0 ns;
    
      if Enable = '0' then
        Z1 <= '0';
        
      elsif Enable = '1' then
        
        if X = "000" then
          Z1 <= A1 or B1;
        elsif X = "001" then
          Z1 <= B1 and C1;
        elsif X = "010" then
          Z1 <= A1 or B1 or C1;
        elsif X = "011" then
          Z1 <= (A1 and B1) or C1;
        elsif X = "100" then
          Z1 <= '0';
        elsif X = "101" then
          Z1 <= A1;
        elsif X = "110" then
          Z1 <= B1;
        elsif X = "111" then
          Z1 <= '1';
        end if;
        
      end if;
      
    wait for 1 ns;
      
  end process;
  
  A <= A1;
  B <= B1;
  C <= C1;
  Z <= Z1;
  
end architecture behaviour2;