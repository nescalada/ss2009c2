function [u,x,clases] = lecuyeg(seed1,seed2)
n = 10000;
m = 2147483562;

a1 = 40014;
m1 = 2147483563;
x1(1) = seed1;

a2 = 40692;
m2 = 2147483399;
x2(1) = seed2;

nintervalos = 100;

clases = zeros(100)(1,:);

for i=2:n
	x1 = [x1 mod(a1 * x1(i-1), m1)];
	x2 = [x2 mod(a2 * x2(i-1), m2)];
end

for i=1:n
	x(i) = mod(x1(i) - x2(i), m);
end

for i=1:n
	if x(i) > 0
		u(i) = x(i)/m1;
	else
		u(i) = m/m1;
	end
	clases(ceil(u(i)*100))=clases(ceil(u(i)*100))+1;
end


endfunction

