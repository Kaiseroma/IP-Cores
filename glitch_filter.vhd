-----------------------------------------------------------------------------------
-- Module: comp
-- Created on: 2021-03-28 17:11:56
-- Target language: VHDL
-- Author: keizerr
-----------------------------------------------------------------------------------
-- Description: This is a simple median filter, designed for filtering the evident (or not so evident) glitches in 1-bit wide signals. The length of the filter is
-- FILTER_LENGTH samples. An additional signal named sever is added, if we have to filter a bunch of connected signals with different filter length.
-- Note: it is not recommended to use FILTER_LENGTH with values from 15 and more, as in most cases you will filter out ALL your signal
-----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity comp is
	generic (FILTER_LENGTH : integer := 9);
	port(
	data : out std_logic;
	input : in std_logic;
	reset : in std_logic;
	sever : in integer;
	CLK : in std_logic
	);
end comp;

architecture rtl of comp is
	signal d : std_logic; -- glitch event
	signal shift : std_logic_vector(2 downto 0);
	signal count : unsigned(4 downto 0); -- time counter

begin
	
process(reset, CLK,input)

begin
	if reset = '1' then
		shift <= (others => '0');
	elsif rising_edge(clk) then
		shift <= shift(1 downto 0) & input; -- input port
	end if;
end process;

process(reset,clk,shift,count)

begin
	if reset = '1' then
		d <= '0';
		count <= (others => '0');
	elsif rising_edge(clk) then
		if(count > FILTER_LENGTH + sever) then
			if (d = '0') then
				d <= '1';
			else
				d <= '0';
			end if;
			count <= (others => '0');
		elsif(shift(2) /= d) then
			count <= count + 1;
			d <= d;
		else
			count <= (others => '0');
			d <= d;
		end if;
	end if;
end process;

data <= d;

end rtl;
