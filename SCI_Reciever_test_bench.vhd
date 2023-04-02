-------------------------------------------------------------------------
-- Company: 		Engs 31/CoSc 56 21S
-- Engineer:		Majd Hamdan
--
-- Create Date: 	05/30/2021
-- Design Name:
-- Module Name: 	SCI Reciever Test Bench
-- Project Name:	Digital Calculator- SCI Reciever Test Bench
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- v1
-- Additional Comments:
-------------------------------------------------------------------------



-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;


entity sci_reciever_tb is
end sci_reciever_tb;

architecture testbench of sci_reciever_tb is

component sci_reciever is
port(
	rx: in std_logic;
    clk: in std_logic;
    parallel_out: out std_logic_vector(7 downto 0);
    rx_done: out std_logic
);
end component;

signal clk, rx_done: std_logic := '0';
signal rx: std_logic := '1';
signal parallel_out: std_logic_vector(7 downto 0);

constant clk_period: time := 10ns;-- simulating a 100 MHz clock
constant int_clk_freq: integer := 100000000;-- 100 Mhz
constant baud_rate: integer := 256000;
constant baud_tc: INTEGER := int_clk_freq/baud_rate;-- 391 for the case of 100mhz clk and 25600 baud rate

begin

uut: sci_reciever port map (
	clk => clk,
	rx => rx,
    parallel_out => parallel_out,
    rx_done => rx_done
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
    -- We transfer 01010101, we expexcr 01010101 at the output

	rx <= '1';
    wait for clk_period;
    --data: 7 first bit high, 1 last bit 0
    --starter bit
    rx <= '0';
    wait for baud_tc*clk_period;
    --data
    --LSB
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
    rx <= '1';
    wait for baud_tc*clk_period;
    --MSB
    rx <= '0';
    wait for baud_tc*clk_period;
    --end bit
    rx <= '1';
    wait;



end process tb;



end testbench;
