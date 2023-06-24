-- Hannah Soria
-- Fall 2022
-- CS 232 Project 3
-- Test bench for the timer and hex display for 2 player implementation
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- a test bench has no inputs or outputs
entity timertesthex2player is
end timertesthex2player;

-- architecture
architecture test of timertesthex2player is

  -- internal signals for everything we want to send to or receive from the
  -- test circuit
  signal reset, start, react, react2: std_logic;
  signal rled: std_logic;
  signal gled: std_logic;
  signal cycles: std_logic_vector(7 downto 0);
  -- signals for each hex display
  signal disp0 : unsigned(6 downto 0);
  signal disp1 : unsigned(6 downto 0);
  -- signals for making the clock
  constant num_cycles : integer := 20;
  signal clk : std_logic := '1';
  
		
  
  -- the component statement lets us instantiate a timer circuit
  component timer2player
    port(
      clk		 : in	std_logic;
      reset	 : in	std_logic;
      start	: in std_logic;
      react	 : in	std_logic;
		react2 : in std_logic;
		cycles	: out std_logic_vector(7 downto 0);
      rled	 : out	std_logic;
      gled : out std_logic
	);
   end component;
		

	-- hexdisplay
	component hexdisplay
	port(
	A: in UNSIGNED(3 downto 0);
	result: out UNSIGNED(6 downto 0)
   );
   end component;


  begin 
  
  -- we can use a process and a for loop to generate a clock signal
  process begin
    for i in 1 to num_cycles loop
      clk <= not clk;
      wait for 5 ns;
      clk <= not clk;
      wait for 5 ns;
    end loop;
    wait;
  end process;
  
  reset <= '0', '1' after 7 ns, '0' after 100 ns, '1' after 110 ns;
  start <= '1', '0' after 20 ns, '1' after 30 ns, '0' after 130 ns, '1' after 140 ns;
  react <= '1', '0' after 85 ns, '1' after 90 ns;
  react2 <= '1', '0' after 90 ns, '1' after 95 ns, '0' after 180 ns, '1' after 190 ns;
  

  -- this instantiates a timer circuit and sets up the inputs and outputs
  T0: hexdisplay port map(unsigned(cycles(3 downto 0)),disp0);
  T1: hexdisplay port map(unsigned(cycles(7 downto 4)),disp1);
  B0: timer2player port map (clk, reset, start, react, react2, cycles, rled, gled);
end test;
