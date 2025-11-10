--Main Code
--CLK, in(-,-)
--RST, in(-,-)
--Q, out(3,0)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    port(
        CLK : in std_logic;
        RST : in std_logic;
        Q   : out std_logic_vector(3 downto 0)
    );
end counter;

architecture counter_arch of counter is
    signal TEMP_Q : std_logic_vector(3 downto 0);
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                TEMP_Q <= (others => '0');
            else
                if TEMP_Q = "1001" then
                    TEMP_Q <= (others => '0');
                else
                    TEMP_Q <= TEMP_Q + 1;
                end if;
            end if;
        end if;
    end process;

    Q <= TEMP_Q;
end counter_arch;

--Test Bench Code
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_tb is
end counter_tb;

architecture behavior of counter_tb is
    component counter
        port(
            CLK : in std_logic;
            RST : in std_logic;
            Q   : out std_logic_vector(3 downto 0)
        );
    end component;

    signal CLK : std_logic := '0';
    signal RST : std_logic := '0';
    signal Q   : std_logic_vector(3 downto 0);

begin
    uut: counter port map(
        CLK => CLK,
        RST => RST,
        Q   => Q
    );

    CLK_process: process
    begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;

    stim_proc: process
    begin
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 200 ns;
        RST <= '1';
        wait for 10 ns;
        RST <= '0';
        wait for 300 ns;
        wait;
    end process;
end;
