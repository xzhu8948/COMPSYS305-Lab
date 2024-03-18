entity counter is
	port (Clk, Reset : in bit;
		Q: out integer);
end entity counter;

architecture behaviour of counter is
begin
	process (Clk)
		variable v_Q: integer;
	begin
		if Clk'event and Clk = '1' then
			if Reset = '1' then
				v_Q := 10;
			elsif v_Q < 24 then
				v_Q := v_Q + 2;
			else
				v_Q := 10;
			end if;
		end if;
		Q <= v_Q;
	end process;
end architecture behaviour;