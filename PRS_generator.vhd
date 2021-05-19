-----------------------------------------------------------------------------------
-- Module: PRS
-- Created on: 2021-04-05 18:45:01
-- Target language: VHDL
-- Author: keizerr
-----------------------------------------------------------------------------------
-- Description: This is a pseudo-random sequence generator with an 8-bit width output, with a starting marker sequence, and flags standing for 
-- the start of the byte/frame transmitted
-----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PRS is
	port(
	clk : in STD_LOGIC; --sampling frequency
	enclk : in STD_LOGIC; --transmittion frequency
	OS : in STD_LOGIC_VECTOR(2 downto 0); --enable signal
	reset : in STD_LOGIC; --async reset
	data : out STD_LOGIC_VECTOR(7 downto 0); --data output
	StrFrame : out STD_LOGIC; --flag for the start of the frame
	StrDI : out STD_LOGIC --flag for the start of the byte
 	);
end PRS;

architecture bhv of PRS is
	
	signal marker : std_logic_vector (63 downto 0) := X"034776C7272895B0";
	signal counter_frame : std_logic_vector (127 downto 0) := (others => '0');
	signal PRS : std_logic_vector (16319 downto 0) := X"FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268E27A1D60B206E012FF1AAF6652231E10A0F9FA8A98677DD2B4E6C5DBCB6B9268";
	
	signal counter : std_logic_vector (16 downto 0) := (others => '0'); 
	
	signal count_cf : std_logic_vector (16 downto 0) := (others => '0');
	signal count_PRS : std_logic_vector (16 downto 0) := (others => '0'); 
	
    	signal setflag,setdata,resetflag,setframe,resetframe,strcDI,strcFrame : std_logic := '0';  
	
	signal os0,os1,os2,enn,encf,enprs : std_logic := '0';
	
	
begin 
	data <= marker((7-conv_integer(counter))*8+7 downto (7-conv_integer(counter))*8) 	 when conv_integer(counter) < 8 and setdata = '1' else	  
	PRS((2039-conv_integer(count_PRS))*8+7 downto (2039-conv_integer(count_PRS))*8)  	 when conv_integer(counter) > 15 and setdata = '1' else	
	counter_frame((15-conv_integer(count_cf))*8+7 downto (15-conv_integer(count_cf))*8) when setdata = '1'; -- our output data
	os0 <= OS(0);
	os1 <= OS(1);
	os2 <= OS(2);
	
	process (clk, reset) --handling the main state machine (service flags) of the IP 
	variable cnt,xx:integer:=0;
	begin
		if reset = '1' then setflag <= '0';setdata <= '0';resetflag <= '0';setframe <= '0';resetframe <= '0';
		else 
			if rising_edge(clk) then
				cnt:=cnt+1;
				xx:=xx+1;
				if cnt = 1 then 
					setflag <= '0';setdata <= '1';resetflag <= '0';
				elsif cnt = 2 then 
					setflag <= '1';setdata <= '0';resetflag <= '0';
				elsif cnt = 3 then 
					setflag <= '0';setdata <= '0';resetflag <= '1';cnt:=0;
				end if;
				if xx = 1 then
					setframe <= '1';resetframe <= '0';
				elsif xx = 2 then
					setframe <= '0';resetframe <= '1';xx:=0; 
				end if;
				
			end if;
		end if;
	end process;
	
	process(setframe,resetframe,setflag,resetflag,clk,reset) --handling the start-of-the-frame flag
	begin
	if reset = '1' then strcFrame <= '1'; StrFrame <='0';
	else 
		if rising_edge(clk) then 
			if setframe = '1' and setflag = '1' and counter = B"11111110111" then 
				strcFrame <= '1';
			else 
				strcFrame <= '0';
			end if;
			StrFrame <= strcFrame;
		end if;
	end if;
	end process;
	
	process(setflag,resetflag,clk,reset) --handling the start-of-the-byte flag
	begin
	if reset = '1' then strcDI <= '1'; StrDI <='0';
	else 
		if rising_edge(clk) then 
			if setflag = '1' then 
				strcDI <= '1';
			else 
				strcDI <= '0';
			end if;
			StrDI <= strcDI;
		end if;
	end if;
	end process;
	
	A1:process(os0,os1,os2) --handling enable
	begin
		if (not os0 = '1') and (not os1 = '1') and (not os2 = '1') then 
			enn <= '0';
		else 
			enn <= '1';
		end if;	
	end process A1;
	
	A2:process (enn,reset,enclk) --handling the main counter and the signals for enabling the sub-counters
	begin
		if reset = '1' then
			counter <= "00000000000000000";
			encf <= '0';
			enprs <= '0';
		else
			if rising_edge(enclk) then
					if enn = '1' then
						counter <= counter + 1;
						if 	counter = B"11111110111"  then			
							counter <= "00000000000000000";
							counter_frame <= counter_frame + 1;
						elsif counter > 15 then
							enprs <= '1';
							encf <= '0';
						elsif counter < 16 and counter > 7 then
							enprs <= '0';
							encf <= '1';
						elsif counter < 8 then 
							encf <= '0';
							enprs <= '0';
						end if;
					else counter <= counter;
					end if;	
			end if;
		end if;
	end process A2;
	
	A3:process(encf,enn,enclk) --handling the counter for division of marker and PRS
	begin
		if rising_edge(enclk) then
			if encf = '1' and enn = '1' then
				count_cf <= count_cf + 1;
			else count_cf <= "00000000000000000";
			end if;
		end if;
	end process A3;
	
	A4:process(enprs,enn,enclk) --handling the PRS counter
	begin
		if rising_edge(enclk) then
			if enprs = '1' and enn = '1' then
				count_PRS <= count_PRS + 1;
			else count_PRS <= "00000000000000000";
			end if;
		end if;
	end process A4;
	
end bhv; 
