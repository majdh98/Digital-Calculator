-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;			-- needed for arithmetic

entity digital_calculater_shell_tb is
end digital_calculater_shell_tb;



architecture testbench of digital_calculater_shell_tb is

component digital_calculater_shell is
port(
	clk: in std_logic;
    rx: in std_logic
);
end component;

signal clk, rx: std_logic := '0';


constant clk_period: time := 10ns;-- simulating a 100 MHz clock
constant int_clk_freq: integer := 100000000;-- 100 Mhz
constant baud_rate: integer := 256000;
constant baud_tc: INTEGER := int_clk_freq/baud_rate;-- 391 for the case of 100mhz clk and 25600 baud rate

begin

uut: digital_calculater_shell port map(
	clk => clk,
    rx => rx
);

clk_proc : process
BEGIN
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process clk_proc;


tb: process
begin

	rx <= '1';
    wait for clk_period;

-- input 1 (1 = 00110001)--------------------------------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;


-- input + (+ = 00101011)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

 -- input 1 (1 = 00110001)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

-- input + (+ = 00101011)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

-- input 1 (1 = 00110001)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

  -- input * (* = 00101010)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

-- input 3 (3 = 00110011)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;


 -- input * (* = 00101010)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

-- input 3 (3 = 00110011)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;




    -- input ! (! = 00100001)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;


-- input 1 (1 = 00110001)--------------------------------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;


-- input + (+ = 00101011)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

 -- input 2 (2 = 00110010)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

 -- input / (/ = 00101111)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

 -- input 2 (2 = 00110010)----------------------------------
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    -- line feed ("00001010")
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '1';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    rx <= '0';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait for baud_tc*clk_period;

    wait;



end process tb;

end testbench;  
