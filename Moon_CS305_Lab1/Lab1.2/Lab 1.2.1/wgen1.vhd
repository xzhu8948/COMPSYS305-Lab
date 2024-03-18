entity wgen1 is
  port (X : in bit_vector(2 downto 0);
        A, B, C, Z : out bit);
end entity wgen1;

architecture behaviour1 of wgen1 is
  signal A1, B1, C1: bit;
begin
  process
    begin
      A1 <= '1', '0' after 2 ns, '1' after 3 ns, '0' after 4 ns;
      B1 <= '0', '1' after 1 ns, '0' after 2 ns, '1' after 3 ns, '0' after 4 ns;
      C1 <= '1', '0' after 1 ns, '1' after 2 ns, '0' after 3 ns, '1' after 4 ns;
      
  wait for 5 ns;
  end process;
  
  process
    begin
      
    wait for 0 ns;
      
      if X = "000" then
        Z <= A1 or B1;
      elsif X = "001" then
        Z <= B1 and C1;
      elsif X = "010" then
        Z <= A1 or B1 or C1;
      elsif X = "011" then
        Z <= (A1 and B1) or C1;
      elsif X = "100" then
        Z <= '0';
      elsif X = "101" then
        Z <= A1;
      elsif X = "110" then
        Z <= B1;
      elsif X = "111" then
        Z <= '1';
      end if;
      
    wait for 1 ns;
      
  end process;
  
  A <= A1;
  B <= B1;
  C <= C1;
  
end architecture behaviour1;