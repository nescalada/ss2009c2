function [t, y] = rungekutta(f, a, b, y0, n)
	h = (b - a)/n;
	[t, y] = mieuler(f, a, b, y0, n);

	for k = 1:n
	  k1 = f(t(k), y(k));
	  k2 = f(t(k) + h/2, y(k) + h/2 * k1);
	  k3 = f(t(k) + h/2, y(k) + h/2 * k2);
	  k4 = f(t(k+1) , y(k) + h*k3);
	  y(k+1) = y(k) + h/6 * (k1 + 2*k2 + 2*k3 + k4);
	end
