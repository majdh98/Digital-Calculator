-------------------------------------------------------------------------
-- Company: 		Engs 31/CoSc 56 21S
-- Engineer:		Majd Hamdan
--
-- Create Date: 	05/30/2021
-- Design Name:
-- Module Name: 	Shell
-- Project Name:	Digital Calculator- Shell
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


-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;			-- needed for arithmetic


entity digital_calculater_shell is
port(
	clk: in std_logic;
    rx: in std_logic;
    seg : out  STD_LOGIC_VECTOR(0 to 6);-- segments (a...g)
    dp : out std_logic;
    an : out  STD_LOGIC_VECTOR (3 downto 0)

);
end digital_calculater_shell;


--=============================================================
--Architecture + Component Declarations
--=============================================================
architecture behavior of digital_calculater_shell is

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--SCI Reciever
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
component sci_reciever is
	port(
    	rx: in std_logic;
    	clk: in std_logic;
    	parallel_out: out std_logic_vector(7 downto 0);
    	rx_done: out std_logic
    );
end component;

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--7-seg display
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
component mux7seg is
    Port ( clk 				: in  STD_LOGIC;						-- runs on a fast (100 MHz or so) clock
           y0, y1, y2, y3 	: in  STD_LOGIC_VECTOR (3 downto 0);	-- digits
           dp_set 			: in std_logic_vector(3 downto 0);      -- decimal points
           seg 				: out  STD_LOGIC_VECTOR(0 to 6);		-- segments (a...g)
           dp 				: out std_logic;						-- decimal points
           an 				: out  STD_LOGIC_VECTOR (3 downto 0) );	-- anodes
end component;

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--7 seg display signals
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
signal seven_seg_display: integer := 0;
signal y0, y1, y2, y3: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--FSM Signals
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
type state_type is (s_idle, s_first_num, s_second_num, s_switch, s_ready, s_find_result1, s_find_result2, s_next_num);
signal current_state, next_state : state_type := s_idle;
signal perform_operation: std_logic := '0';
signal switch_stored_input: std_logic := '0';-- indictates to db to change stored_num to inpu_num and input_num to 0
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Data path Signals
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
signal is_operation: std_logic := '0';-- indicates if the recieved ascii code is a code for an operation.
signal operation: std_logic_vector(1 downto 0) := "00";-- stores next operation to be performed(00=+, 01=-, 10=*, 11=/)
signal num_end: std_logic := '0';-- indicates if user finished entering a number
signal reset: std_logic := '0';-- indicates when user reset the calculater


signal input_num: integer := 0;-- records the number being inputed
signal stored_num: integer := 0;-- records the number that was already inputed or the result of a previous operation

signal sci_input: std_logic_vector(7 downto 0) := (others => '0');-- records the output of the sci reciever.
signal rx_done: std_logic := '0';-- the rx_done of the sci reciever

signal test: integer := 0;


begin

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--SCI Reciever port map
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
sci_rec: sci_reciever port map(
	clk => clk,
	rx => rx,
    parallel_out => sci_input,
    rx_done => rx_done
);

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--7 seg  port map
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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



--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--state machine
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

state_update: process(clk)
begin
	if rising_edge(clk) then
    	current_State <= next_State;
    end if;
end process state_update;

next_state_logic: process(current_state, reset, rx_done, is_operation, num_end)
begin
	seven_seg_display <= input_num;
    perform_operation <= '0';
    switch_stored_input <= '0';


    if reset = '1' then
    	next_state <= s_idle;
    else
      case current_state is
        when s_idle =>
            if rx_done <= '1' then
                next_state <= s_first_num;
            end if;
        when s_first_num =>
            if is_operation = '1' then
                next_state <= s_switch;
            end if;
        when s_switch =>
            switch_stored_input <= '1';
            next_state <= s_second_num;
        when s_second_num =>
            if num_end = '1' then
                next_state <= s_find_result1;
            end if;
        when s_find_result1 =>
            perform_operation <= '1';
            next_state <= s_ready;
        when s_ready =>
            seven_seg_display <= stored_num;
            if is_operation = '1' then
                next_state <= s_next_num;
            end if;
        when s_next_num =>
            if num_end = '1' then
                next_state <= s_find_result2;
            end if;
        when s_find_result2 =>
            perform_operation <= '1';
            next_state <= s_ready;
        when others =>
            next_State <= current_state;
      end case;
    end if;
end process next_state_logic;


--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--data path
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- lunch when the sci reciever has an output. check if the sci sent a number or an operation. If it is an operation, perform the operation and store its result in stored_num. If it is a number, adjust input_num. If sci is outputing a number composed from more than one digit, it will output the most sig fig first.
-- IMPORTANT: WE ASSUME USER ONLY INPUT +, -, *, /, OR NUMBERS.
-- IMPORTANT: BECAUSE WE ONLY HAVE 5 7SEG DISPLAYS, IT IS ASSUMED THAT THE MAX NUMBER OF DIGITITS OF A NUMBER A USER CAN INPUT IS 2, SO NO OVERFLOW OCCURE AT X1*X2 >9999
datapath: process(rx_done, perform_operation, reset)
begin
   	--default action
	is_operation <= '0';
    reset <= '0';
    num_end <= '0';

	if rx_done = '1' then
    	-- check if it is an operater or a number
        -- if an operater, perform operation and store it in stored_num
        -- if it is a number, adjust input_num
        case sci_input is
          -- addition (+ = 00101011)
          when "00101011" =>
              is_operation <= '1';
              operation <= "00";
          -- substraction (- = 00101101)
          when "00101101" =>
              is_operation <= '1';
              operation <= "01";
          -- multiplication (* = 00101010)
          when "00101010" =>
              is_operation <= '1';
              operation <= "10";
          -- division (/ = 00101111)
          when "00101111" =>
              is_operation <= '1';
              operation <= "11";
          --line feed (means the end of a number input: when ad2 sends 124 for example it sends 1 then 2 then 4 then the line feed. (linefeed = 00001010)
          when "00001010"=>
              if is_operation = '0' then
                  num_end <= '1';
              end if;
          --reset(here we choose ! to be the reset charecter) (!= 00100001)
          when "00100001" =>
              reset <= '1';
          -- OTHERS HERE CAN ONLY BE NUMBERS
          when others =>
              input_num <= input_num*10 +  to_integer(unsigned(sci_input)) - 48;
        end case;
    end if;

    --do the switching only when in second_num state
    if switch_stored_input = '1' then
        stored_num <= input_num;
        input_num <= 0;
    end if;

    --perform the operation
	if perform_operation = '1' then
    	case operation is
          when "00" =>
              stored_num <= stored_num + input_num;
              input_num <= 0;
          when "01" =>
              stored_num <= stored_num - input_num;
              input_num <= 0;
          when "10" =>
              stored_num <= stored_num * input_num;
              input_num <= 0;
          when "11" =>
              stored_num <= stored_num / input_num;
              input_num <= 0;
          when others =>
              stored_num <= stored_num;
              input_num <= input_num;
        end case;
    end if;


    if reset = '1' then
    	input_num <= 0;
        stored_num <= 0;
    end if;

end process datapath;


seg_process: process(rx_done) --even_seg_display)
variable indicater : integer := 0;
variable helper: integer := 0;

begin


    indicater := 0;
    helper := 0;

    while (indicater < 1010) loop

        if (indicater = 0) then
            y3 <= std_logic_vector(to_unsigned(seven_seg_display/1000, 4));
        elsif(indicater = 200) then
            helper := seven_seg_display - to_integer(unsigned(y3))*1000;
        elsif (indicater = 400) then
            y2 <= std_logic_vector(to_unsigned(helper/100, 4));
        elsif (indicater = 600) then
            helper := seven_seg_display - to_integer(unsigned(y3))*1000 - to_integer(unsigned(y2))*100;
        elsif (indicater = 800) then
            y1 <= std_logic_vector(to_unsigned(helper/10, 4));
        elsif (indicater = 1000) then
            y0 <= std_logic_vector(to_unsigned(helper - to_integer(unsigned(y1))*10, 4));
            test <= to_integer(unsigned(y1))*10;
        end if;

       indicater := indicater + 1;

    end loop;

end process seg_process;


end behavior;
