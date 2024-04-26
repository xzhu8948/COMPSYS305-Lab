library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity timer is
    port (
        CLOCK2_50 : in std_logic;
        SW : in std_logic_vector(9 downto 0);
        KEY : in std_logic_vector(0 downto 0);
        LEDR : out std_logic_vector(0 downto 0);

        HEX0, HEX1, HEX2, HEX3, HEX4 : out std_logic_vector(6 downto 0)
    );
end entity;

architecture behaviour of timer is
    signal mins_bcd, secs_tens_bcd, secs_ones_bcd, mins_hold, secs_tens_hold, secs_ones_hold : std_logic_vector(3 downto 0);
    signal mins_enable, secs_tens_enable, secs_ones_enable : std_logic;
    signal clock, init, secs_tens_init : std_logic;
    signal clock_counter : std_logic_vector(31 downto 0);

    component bcd_counter is
        port (
            clk, direction, init, enable : in std_logic;
            q_out : out std_logic_vector(3 downto 0)
        );
    end component;

    component bcd_to_sevenseg is
        port (
            bcd_digit : in std_logic_vector(3 downto 0);
            sevenseg_out : out std_logic_vector(6 downto 0)
        );
    end component;

begin
    mins_counter : bcd_counter port map(clk => clock, direction => '0', init => init, enable => mins_enable, q_out => mins_bcd);
    mins_encoder : bcd_to_sevenseg port map(bcd_digit => mins_bcd, sevenseg_out => HEX3);
    
    secs_tens_counter : bcd_counter port map(clk => clock, direction => '0', init => secs_tens_init, enable => secs_tens_enable, q_out => secs_tens_bcd);
    secs_tens_encoder : bcd_to_sevenseg port map(bcd_digit => secs_tens_bcd, sevenseg_out => HEX1);

    secs_ones_counter : bcd_counter port map(clk => clock, direction => '0', init => init, enable => secs_ones_enable,q_out => secs_ones_bcd);
    secs_ones_encoder : bcd_to_sevenseg port map(bcd_digit => secs_ones_bcd, sevenseg_out => HEX0);

    secs_ones_enable <= '0' when (secs_ones_bcd = secs_ones_hold) and (secs_tens_bcd = secs_tens_hold) and (mins_bcd = mins_hold) else '1';
    secs_tens_enable <= '1' when secs_ones_enable = '1' and secs_ones_bcd = "1001" else '0';
    mins_enable <= '1' when secs_tens_enable = '1' and secs_tens_bcd = "0101" else '0';

    LEDR(0) <= not secs_ones_enable;

    HEX2 <= "11" & (not clock and secs_ones_enable) & "11" & (not clock and secs_ones_enable) & "1";
    HEX4 <= "1000000";

    init <= not KEY(0);

    secs_tens_init <= '1' when init = '1' or (secs_tens_enable = '1' and secs_tens_bcd = "0101") else '0';

    process(CLOCK2_50)
        -- These are needed to avoid assigning to the signal when its assignment depends on its value
        variable secs_tens_val, secs_ones_val : std_logic_vector(3 downto 0);
    begin
        if (rising_edge(CLOCK2_50)) then
            if (init = '1') then
                mins_hold <= "00" & SW(9 downto 8);

                secs_tens_val := "0" & SW(6 downto 4);
                if ((secs_tens_val and "0110") = "0110") then
                    secs_tens_val := "0101";
                end if;
                secs_tens_hold <= secs_tens_val;

                secs_ones_val := SW(3 downto 0);
                if (secs_ones_val(3) = '1' and (secs_ones_val or "1001") /= "1001") then
                    secs_ones_val := "1001";
                end if;
                secs_ones_hold <= secs_ones_val;

                clock <= not clock;
                clock_counter <= (others => '0');
            else
                if (clock_counter = "1011111010111100001000000") then
                    clock <= '0';
                end if;
                if clock_counter = "10111110101111000010000000" then
                    clock <= '1';
                    clock_counter <= (others => '0');
                else
                    clock_counter <= clock_counter + "1";
                end if;
            end if;
        end if;
    end process;
end architecture;