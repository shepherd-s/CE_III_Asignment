--Ejercicio 1.d (architecture con puertas)
----------------------------

architecture architecture_1d of entity1 is
	component not_gate is
		port (f0 : out std_logic;
		      x0 : in std_logic);
	end component not_gate;
	
	component and_gate2 is
		port (f0     : out std_logic;
		      x0, y0 : in std_logic);
	end component and_gate2;
	
	component or_gate2 is
		port (f0     : out std_logic;
		      x0, y0 : in std_logic);
	end component or_gate2;

	signal s1, s2, s3, s4, s5 : std_logic;
begin
	--los nombres de las unidades (i1...in) y los de las señales (s1...sn)
	--aparecen en las etiquetas del diagrama del apartado 1.c, se puede
	--observar el diagrama para ver con mayor claridad la
	--correspondencia entre las señales que se declara a continuacion
	i1 : not_gate  port map (x0 => x, f0 => s1);
	i2 : not_gate  port map (x0 => y, f0 => s2);
	i3 : and_gate2 port map (x0 => x, y0 => y, f0 => s3);
	i4 : or_gate2  port map (x0 => s2, y0 => z, f0 => s4);
	i5 : and_gate2 port map (x0 => s1, y0 => z, f0 => s5);
	i6 : or_gate2  port map (x0 => s3, y0 => s5, f0 => f);
	i7 : and_gate2 port map (x0 => s1, y0 => s4, f0 => g);
end architecture architecture_1d;
