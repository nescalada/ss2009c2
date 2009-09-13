function [t,y] = mieuler(f, a, b, y0, n)
	h = (b - a)/n;
	t = (a:h:b)';
	y(1) = y0;
	for k = 1:n
		y(k+1) = y(k) + h * f(t(k), y(k));
	end
