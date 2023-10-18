--Ejercicio 1.e (banco de pruebas)
----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--comienzo de la
entity test_bench1 is
	constant delay : time := 20 ns; 
end entity test_bench1;

architecture test_arch of test_bench1 is
	component entity1 is
		port (f, g    : out std_logic;
		      x, y, z : in std_logic);
	end component entity1;

	signal test_out_f : std_logic;
	signal test_out_g : std_logic;
	signal test_in    : std_logic_vector(2 downto 0);
begin
	--las entradas se corresponden con cada uno de los elementos
	--del vector de test, correspondiendo x al bit mas
	--significativo y z al menos.
	uut1 : entity1 port map (x => test_in(2),
			         y => test_in(1),
				 z => test_in(0),
				 f => test_out_f,
				 g => test_out_g);
	vect_test : process
	begin
		--se utiliza la variable del bucle para asignar
		--al vector de test cada uno de los 8 posibles valores
		--convirtiendo i a unsigned y luego a std_logic_vector
		for i in 0 to 7 loop
			test_in <= std_logic_vector(to_unsigned(i,3));
			wait for delay;
		end loop;
		wait;
	end process vect_test;
end architecture test_arch;
