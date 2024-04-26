library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_bcd_counter is
end entity;

architecture test of test_bcd_counter is
    signal t_clk, t_mode, t_init, t_enable : std_logic;
    signal t_q_out : std_logic_vector(3 downto 0);

    component bcd_counter is
        port (
            clk, mode, init, enable : in std_logic;
            q_out : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    bcd_counter_design: bcd_counter port map (t_clk, t_mode, t_init, t_enable, t_q_out);

    init : process
    begin
        t_init <= '1', '0' after 15 ns;
        t_mode <= '0', '1' after 70 ns;
        t_enable <= '1', '0' after 40 ns, '1' after 60 ns;
        wait;
    end process;

    clock : process
    begin
        t_clk <= '1';
        wait for 5 ns;
        t_clk <= '0';
        wait for 5 ns;
    end process;
end architecture;