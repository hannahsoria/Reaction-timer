-- Hannah Soria
-- Fall 2022
-- CS 232 Project 3
-- timer 
-- Quartus II VHDL Template
-- Four-State Moore State Machine

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is

	port(
		clk		 : in	std_logic;
		reset	 : in	std_logic;
		start	 : in	std_logic;
		react	 : in	std_logic;
		cycles	 : out	std_logic_vector(7 downto 0);
		rled	: out std_logic;
		gled	: out std_logic
	);

end entity;

architecture rtl of timer is

	-- Build an enumerated type for the state machine
	type state_type is (sIdle, sWait, sCount);

	-- Register to hold the current state
	signal state   : state_type;
	signal count : unsigned (7 downto 0);
	

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '0' then
			count <= (others=> '0');
			state <= sIdle;
		elsif (rising_edge(clk)) then
			case state is
				when sIdle=>
					if start = '0' then
						state <= sWait;
					end if;
				when sWait=>
					if count <= "00000011" then
						count <= "00000000";
						state <= sCount;
					elsif react = '0' then
						count <= "11111111";
						state <= sIdle;
					else 
						count <= count + 1;
					end if;
				when sCount=>
					if react = '0' then
						state <= sIdle;
					else 
						count <= count + 1;
					end if;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	
	gled <= '1' when state = sCount else '0';
	rled <= '1' when state = sWait else '0';
	cycles <= "00000000" when state = sWait else std_logic_vector(count);
	

end rtl;
