library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_timer is
end entity;

architecture test of test_timer is
    signal t_clock : std_logic;
    signal t_start, t_time_out : std_logic_vector(0 downto 0);
    signal t_data_in : std_logic_vector(9 downto 0);
    signal t_mins_out, t_secs_tens_out, t_secs_ones_out : std_logic_vector(6 downto 0);

    component timer is
        port (
            CLOCK2_50 : in std_logic;
            SW : in std_logic_vector(9 downto 0);
            KEY : in std_logic_vector(0 downto 0);
            LEDR : out std_logic_vector(0 downto 0);
    
            HEX0, HEX1, HEX2, HEX3 : out std_logic_vector(6 downto 0)
    );
    end component;

begin
    timer_design : timer port map(CLOCK2_50 => t_clock, KEY => t_start, SW => t_data_in, LEDR => t_time_out,
        HEX0 => t_mins_out, HEX1 => t_secs_tens_out, HEX2 => t_secs_ones_out
    );

    init : process
    begin
        t_data_in <= "1101011010";
        t_start(0) <= '1', '0' after 5 ns, '1' after 30 ns;
        wait;
    end process;

    gen_clock : process
    begin
        t_clock <= '1';
        wait for 10 ns;
        t_clock <= '0';
        wait for 10 ns;
    end process;
end architecture;