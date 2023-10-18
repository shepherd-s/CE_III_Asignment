--Ejercicio 1.b (architecture definiendo el comportamiento)
----------------------------

architecture architecture1 of entity1 is
begin
	f <= (z and (not x)) or (x and y);
	g <= (not x) and (z or (not y));
end architecture architecture1;
