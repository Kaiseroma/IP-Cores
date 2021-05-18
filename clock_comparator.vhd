library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkcmp is
	port
	(
	clk		: in std_logic;
	opora   : in std_logic;
	reset	: in std_logic;
	q		: out std_logic
	);
end entity;

architecture rtl of clkcmp is 

begin
	process (clk,opora)
	variable   cnt1	: integer:=0;
	variable   cnt2	: integer:=0;
	begin
		if (rising_edge(clk)) then
			if reset = '1' then
				-- сбрасываем счетчик в 0
				cnt1 := 0;
			else
				-- инкрементируем счетчик
				cnt1 := cnt1 + 1;
			end if;
		end if;
		if (rising_edge(opora)) then
			if reset = '1' then
				-- сбрасываем счетчик в 0
				cnt2 := 0;
			else
				-- инкрементируем счетчик
				cnt2 := cnt2 + 1;
			end if;
		end if;
		-- устанавливаем текущее значение на вывод
		if cnt1 > cnt2 then
			q <='0';
		else q <='1';
		end if;
	end process;

end rtl;
