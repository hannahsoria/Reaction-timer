-- Hannah Soria
-- Fall 2022
-- CS 232 Project 3
-- Test bench for the timer state machine
--

library ieee;
use ieee.std_logic_1164.all;

-- a test bench has no inputs or outputs
entity timertest is
end timertest;

-- architecture
architecture test of timertest is

  -- internal signals for everything we want to send to or receive from the
  -- test circuit
  signal reset, start, react: std_logic;
  signal rled: std_logic;
  signal gled: std_logic;
  signal cycles: std_logic_vector(7 downto 0);

  -- the component statement lets us instantiate a timer circuit
  component timer
    port(
      clk		 : in	std_logic;
      reset	 : in	std_logic;
      start	: in std_logic;
      react	 : in	std_logic;
		cycles	: out std_logic_vector(7 downto 0);
      rled	 : out	std_logic;
      gled : out std_logic
      );
  end component;

  -- signals for making the clock
  constant num_cycles : integer := 20;
  signal clk : std_logic := '1';
  
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
  
    -- these are timed signal assignments to create specific patterns
  reset <= '0', '1' after 7 ns, '0' after 100 ns, '1' after 110 ns;
  start <= '1', '0' after 20 ns, '1' after 30 ns, '0' after 130 ns, '1' after 140 ns;
  react <= '1', '0' after 85 ns, '1' after 90 ns, '0' after 140 ns;
  

  -- this instantiates a bright circuit and sets up the inputs and outputs
  B0: timer port map (clk, reset, start, react, cycles, rled, gled);
end test;
