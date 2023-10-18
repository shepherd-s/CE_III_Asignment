--Ejercicio 1.c (puertas logicas)
----------------------------

library ieee;
use ieee.std_logic_1164.all;

--puerta not------------------------------
entity not_gate is
	port (f0 : out std_logic;
	      x0 : in std_logic);
end entity not_gate;

architecture not_gate_arch of not_gate is
begin
	f0 <= not x0;
end architecture not_gate_arch;
------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--puerta and de 2 entradas----------------
entity and_gate2 is
	port (f0     : out std_logic;
	      x0, y0 : in std_logic);
end entity and_gate2;

architecture and_gate_arch of and_gate2 is
begin
	f0 <= x0 and y0;
end architecture and_gate_arch;
------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--puerta or de 2 entradas-----------------
entity or_gate2 is
	port (f0     : out std_logic;
	      x0, y0 : in std_logic);
end entity or_gate2;

architecture or_gate_arch of or_gate2 is
begin
	f0 <= x0 or y0;
end architecture or_gate_arch;
------------------------------------------
