--Ejercicio 2.a (entity y architecture)
----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--comienzo de la entity del ejercicio 2.a
entity entity2 is
	generic (constant N : integer);
	port (res                         : out signed(N-1 downto 0);
	      desbordamiento, cero, signo : out std_logic;
	      a, b 			  : in signed(N-1 downto 0);
	      cin 			  : in std_logic);
end entity2;

--comienzo de la architecture del ejercicio 2.a
architecture arch2 of entity2 is
	signal r  : signed(N-1 downto 0); --señal res
	signal d  : std_logic;            --señal desbordamiento
	signal z  : std_logic;            --señal cero
begin
	--el acarreo de entrada se interpreta como un 1 positivo
	--en todos los casos por lo que si cin es 1 existe acarreo y se
	--suma 1 al resultado
	r <= a+b+1 when (cin = '1') else
	     a+b;
	
	--la funcion logica del desbordamiento es (¬sa¬sbsr + sasb¬sr)
	--con sa -> signo del operador a
	--    sb -> signo del operador b
	--    sr -> signo del resultado
	--    ¬  -> operador not
	d <= ((not a(N-1)) and (not b(N-1)) and (r(N-1))) or
	     (a(N-1) and b(N-1) and (not r(N-1)));

	--la señal cero, (z), es 1 cuando no hay desbordamiento y el
	--resultado es 0
	z <= '1' when (d = '0' and (r = 0)) else
	     '0';

	--el signo se corresponde con el del resultado cuando no hay
	--desbordamiento y el contrario cuando si lo hay
	signo <= r(N-1) when (d ='0') else
		 not r(N-1);

	--asignacion de lo resultados de las funciones logicas calculadas
	res <= r;
	desbordamiento <= d;
	cero <= z;
end architecture arch2;
		
