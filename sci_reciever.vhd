-------------------------------------------------------------------------
-- Company: 		Engs 31/CoSc 56 21S
-- Engineer:		Majd Hamdan
--
-- Create Date: 	05/30/2021
-- Design Name:
-- Module Name: 	SCI Reciever
-- Project Name:	Digital Calculator- SCI Reciever
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



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;			-- needed for arithmetic
use ieee.math_real.all;				-- needed for automatic register sizing

entity sci_reciever is
port(
	rx: in std_logic;
    clk: in std_logic;


    seg 				: out  STD_LOGIC_VECTOR(0 to 6);		-- segments (a...g)
    dp 				: out std_logic;						-- decimal points
    an 				: out  STD_LOGIC_VECTOR (3 downto 0)
);
end sci_reciever;

architecture behavior of sci_reciever is

component mux7seg is
    Port ( clk 				: in  STD_LOGIC;						-- runs on a fast (100 MHz or so) clock
           y0, y1, y2, y3 	: in  STD_LOGIC_VECTOR (3 downto 0);	-- digits
           dp_set 			: in std_logic_vector(3 downto 0);      -- decimal points
           seg 				: out  STD_LOGIC_VECTOR(0 to 6);		-- segments (a...g)
           dp 				: out std_logic;						-- decimal points
           an 				: out  STD_LOGIC_VECTOR (3 downto 0));	-- anodes

end component;

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--7 seg display signals
--+++++++++++++

--============================================
-- FSM signals
--============================================
type state_type is (s_idle, s_wait1, s_shift1, s_wait2, s_shift2, s_ready);
signal current_state, next_state : state_type := s_idle;
signal state_now: std_logic_vector(2 downto 0) := "000";
signal shift_en: std_logic := '0';-- enables shifting for the shift register and clears bit counter.
-- baud counter input signals
signal baud_en: std_logic := '0';-- enables
signal clear_baud: std_logic := '0';--clear baud counter
-- bit counter input signals
signal clear_bit: std_logic := '0';-- clears bit counter


--============================================
--Data Path signals
--============================================

constant clk_freq: integer := 100000000;-- 1 MHz
constant baud_rate: integer := 256000;
constant baud_tc: integer := clk_freq/baud_rate;--391 for the case of 100mhz clk and 25600 baud rate

constant baud_count_length: integer := integer(ceil( log2( real(baud_tc))));
signal baud_count: unsigned(baud_count_length-1 downto 0) := (others => '0');

constant bit_tc: integer := 10;-- first bit is start bit and last bit is stop bit, the 8 bits in the middle are data
constant bit_count_length: integer := integer(ceil( log2( real(bit_tc))));
signal bit_count: unsigned(bit_count_length-1 downto 0) := (others => '0');

--baud counter output signals
signal tc_baud_full: std_logic := '0';
signal tc_baud_half: std_logic := '0';
--bit counter output signals
signal tc_bit: std_logic := '0';

signal y0, y1, y2, y3: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal int_rx_done: std_logic := '0';
signal ph: std_logic_vector(7 downto 0) := (others => '0');


--============================================
--Internal signals
--============================================
signal parallel_iout: std_logic_vector(9 downto 0) := (others => '0');

begin

display: mux7seg
	port map(
		clk 	=> clk,			-- has its own clock divider built-in
		y0 		=> y0,
		y1 		=> y1,
		y2 		=> y2,
		y3 		=> y3,
		dp_set 	=> "1111",
		seg 	=> seg,
		dp 		=> dp,
		an 		=> an);

--============================================
--State Machine
--============================================

state_update: process(clk)
begin
	if rising_edge(clk) then
    	current_State <= next_State;
    end if;
end process state_update;

next_state_logic: process(current_state, tc_bit, tc_baud_half, tc_baud_full, rx)
begin
	--defaults
    shift_en <= '0';
    clear_baud <= '0';
    clear_bit <= '0';
    baud_en <= '1';
    int_rx_done <= '0';


	case current_state is
    when s_idle =>
        state_now <= "000";
        baud_en <= '0';
    	if rx = '0' then
        	next_State <= s_wait1;
        end if;
    when s_wait1 =>
    	state_now <= "001";
    	if tc_baud_half = '1' then
        	next_state <= s_shift1;
        end if;
    when s_shift1 =>
    	state_now <= "010";
        shift_en <= '1';
        clear_baud <= '1';
        next_state <= s_wait2;
    when s_wait2 =>
    	state_now <= "011";
        if tc_baud_full = '1' then
        	next_state <= s_shift2;
        end if;
        if tc_bit = '1' then
        	next_state <= s_ready;
        end if;
    when s_shift2 =>
    	state_now <= "100";
    	shift_en <= '1';
        clear_baud <= '1';
        if tc_bit = '1' then
        	next_state <= s_ready;
        else
        	next_state <= s_wait2;
        end if;
    when s_ready =>
    	state_now <= "101";
    	clear_bit <= '1';
    	baud_en <= '0';
        int_rx_done <= '1';
        next_state <= s_idle;
    when others =>
    	next_state <= current_State;

    end case;
end process next_State_logic;


--============================================
--Data Path
--============================================

datapath: process(clk)
begin

   --shift register
    if rising_edge(clk) then
        if shift_en = '1'  then
             parallel_iout <= rx & parallel_iout(9 downto 1);
        end if;
    end if;




end process datapath;

bit_counter_process: process(clk)
begin
     tc_bit <= '0';
    --bit counter
    if rising_edge(clk) then
        if shift_en = '1'  then
            bit_count <= bit_count + 1;
        end if;
        if bit_count = bit_tc then
            tc_bit <= '1';
            bit_count <= (others => '0');
        end if;
    end if;


end process bit_counter_process;
baud_counter_process: process(clk)
begin
    tc_baud_half <= '0';
    tc_baud_full <= '0';
    --baud counter
    if rising_edge(clk) then
        if baud_en = '1'  then
            baud_count <= baud_count + 1;
        end if;
        if baud_count = (baud_tc)/2 then
            tc_baud_half <= '1';
        elsif baud_count = baud_tc-1 then
            tc_baud_full <= '1';
        end if;
    end if;
   	if clear_baud = '1' then
        baud_count <= (others => '0');
    end if;

end process baud_counter_process;

seven_useg_process: process(int_rx_done)
begin
        y0 <= y0;
        y1 <= y1;
        y2 <= y2;
        y3 <= y3;
        if int_rx_done = '1' then
            if parallel_iout(8 downto 1) /= "00001010" then
                y0 <= parallel_iout(4 downto 1);
                y1 <= parallel_iout(4 downto 1);
                y2 <= parallel_iout(4 downto 1);
                y3 <= parallel_iout(4 downto 1);
            end if;
        end if;




end process seven_useg_process;





end behavior;
