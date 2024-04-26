library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_counter is
    port (
        clk, direction, init, enable : in std_logic;
        q_out : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behaviour of bcd_counter is
    signal current : std_logic_vector(3 downto 0);
begin
    process (clk)
    begin
        if (clk = '1') then
            if (init = '1') then
                case direction is
                    when '0' => current <= "0000";
                    when '1' => current <= "1001";
                    when others => current <= "0000";
                end case;
            elsif (enable = '1') then
                if (direction = '1') then
                    if (current = "0000") then
                        current <= "1001";
                    else
                        current <= current - "0001";
                    end if;
                else
                    if (current = "1001") then
                        current <= "0000";
                    else
                        current <= current + "0001";
                    end if;
                end if;
            end if;
        end if;
    end process;

    q_out <= current;
end architecture;