--Ejercicio 2.b (banco de pruebas para el sumador)
----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--comienzo de la entity del banco de pruebas del ejercicio 2.b
entity test_bench2 is
	generic (N     : integer := 4;
	         delay : time := 5 ns);
end entity test_bench2;

--comienzo de la arquitectura del banco de pruebas del ejercicio 2.b
architecture test_arch2 of test_bench2 is
	component entity2 is
		generic ( constant N : integer := N);
		port (res                         : out signed(N - 1 downto 0);
	      	      desbordamiento, cero, signo : out std_logic;
	      	      a, b                        : in signed(N - 1 downto 0);
	      	      cin 			  : in std_logic);
	end component entity2;
	
	signal test_out_d  : std_logic;
	signal test_out_z  : std_logic;
	signal test_out_s  : std_logic;
	signal test_out_r  : signed(N - 1 downto 0);
	signal test_in     : signed(2*N downto 0);
	
	--las siguientes señales no nos necesarias pero se añaden por claridad
	signal test_op_a   : signed(N - 1 downto 0);
	signal test_op_b   : signed(N - 1 downto 0);
	signal test_op_c   : std_logic;
begin
	--el vector de test tiene longitud 2*N +1, el bit mas
	--significativo se hace corresponder con la entrada
	--cin, y los 2*N siguientes se hacen corresponder con 
	--los operadores a y b, de esta manera la mitad del tiempo
	--de simulacion cin esta en 0 y la otra en 1,asi el
	--cronograma es mas claro
	uut2 : entity2 port map (a => test_in(2*N-1 downto N),
				 b => test_in(N-1 downto 0),
				 cin => test_in(2*N),
				 desbordamiento => test_out_d,
			         cero => test_out_z,
				 signo => test_out_s,
				 res => test_out_r);
	vect_test2 : process
	variable vector_test             : signed(2*N downto 0);
	variable res_esperado            : signed(N-1 downto 0);
	variable op_a			 : integer;
	variable op_b			 : integer;
	variable op_r			 : integer;
	variable num_errs		 : integer := 0;
	variable desbordamiento_esperado : std_logic;
	variable cero_esperado           : std_logic;
	variable signo_esperado          : std_logic;
	begin	
		--bucle desde el valor maximo del vecor de test, segun el valor de N,
		--hasta el minimo interpretado como entero.
		for i in ((2**(2*N+1))/2)-1 downto -((2**(2*N+1))/2) loop
			--asignacion de los valores de test
			-----------------------------------------
			vector_test := to_signed(i, 2*N+1);
			test_in <= vector_test;

			--se añaden a continuacion los operadores a, b y cin por
			--separado para visualizarlos facilmente en el cronograma
			--pero no son necesarios
			test_op_a <= vector_test(2*N-1 downto N);
			test_op_b <= vector_test(N-1 downto 0);
			test_op_c <= vector_test(2*N);
			wait for delay;
			------------------------------------------

			--inicializacion de resultados esperados
			-------------------------------------------------------------------------
			op_a := to_integer(test_op_a);
			op_b := to_integer(test_op_b);
			if (test_op_c = '0') then
				res_esperado := test_op_a + test_op_b;
				op_r := op_a + op_b;
			else
				res_esperado := test_op_a + test_op_b + 1;
				op_r := op_a + op_b + 1;
			end if;

			--el metodo distinto para comprobar el desbordamiento consiste
			--en aprovechar el tipo entero para comprobar que el rango del
			--resultado esta dentro del dominio segun el tamaño de N. Valido
			--para valores de N que no superen el rango de un entero
			if (op_r < -(((2**N))/2) or op_r > (((2**N)/2)-1)) then
				desbordamiento_esperado := '1';
			else
				desbordamiento_esperado := '0';
			end if;

			if (res_esperado = 0 and desbordamiento_esperado = '0') then
				cero_esperado := '1';
			else
				cero_esperado := '0';
			end if;

			if (test_out_d = '0') then
				signo_esperado := test_out_r(N-1);
			else
				signo_esperado := not test_out_r(N-1);
			end if;
			-------------------------------------------------------------------------
			
			--comprobacion de resultados esperados con señales de salida
			------------------------------------------------
			if (res_esperado /= to_integer(test_out_r)) then
				report "error en el resultado: "
				& " a = " & integer'image(to_integer(test_op_a))
				& " b = " & integer'image(to_integer(test_op_b))
				& " desbordamiento = " & std_logic'image(test_out_d)
				& " resultado = " & integer'image(to_integer(test_out_r))
				& " resultado_esperado = " & integer'image(to_integer(res_esperado));
				num_errs := num_errs +1;
			end if;
			if (signo_esperado /= test_out_s) then
				report "error en el signo: "
					& " a = " & integer'image(to_integer(test_op_a))
					& " b = " & integer'image(to_integer(test_op_b))
					& " desbordamiento = " & std_logic'image(test_out_d)
					& " signo = " & std_logic'image(test_out_s)
					& " signo_esperado = " & std_logic'image(signo_esperado);
				num_errs := num_errs + 1;
			end if;
			if (cero_esperado /= test_out_z) then
				report "error en señal cero: "
					& " a = " & integer'image(to_integer(test_op_a))
					& " b = " & integer'image(to_integer(test_op_b))
					& " desbordamiento = " & std_logic'image(test_out_d)
					& " cero = " & std_logic'image(test_out_z)
					& " cero_esperado = " & std_logic'image(cero_esperado);
			end if;
			if (desbordamiento_esperado /= test_out_d) then
				report "error en desbordamiento: "
					& " a = " & integer'image(to_integer(test_op_a))
					& " b = " & integer'image(to_integer(test_op_b))
					& " desbordamiento = " & std_logic'image(test_out_d)
					& " desbordamiento_esperado = " & std_logic'image(desbordamiento_esperado)
					& " resultado_esperado = " & integer'image(to_integer(res_esperado));
			end if;
			------------------------------------------------
		end loop;
		report "total errores: " & integer'image(num_errs);
		wait;
	end process vect_test2;
end architecture test_arch2;
