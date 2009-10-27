
seed1 = 1;
seed2 = 1;
nbins = 10;

significacion = 0.05;

% Obtenido de tabla chi(0.05,99)
chicritico = 124.34;
valesperado = 100;
% Obtenido de tabla tstu(0.05,19)
tstudent = 2.0930;

[u,x,clases] = lecuyeg(seed1,seed2);

[nn xx] = hist(x, nbins);

nu = length(u);

g1x = u(1:(nu-1));
g1y = u(2:nu);

g2x = u(1:(nu-2));
g2y = u(2:(nu-1));
g2z = u(3:nu);

clearplot;
hold off;

plot(g1x, g1y);
print('duplas.eps', '-deps');


stairs(clases);
print('clases.eps', '-deps');

chicero = chival(clases,valesperado);

if chicero > chicritico
	printf("Se rechaza la hipotesis H0 de que la secuencia proviene de una distribucion uniforme: %f > %f\n",chicero,chicritico);
else
	printf("No se rechaza la hipotesis H0 de que la secuencia proviene de una distribucion uniforme: %f <= %f\n",chicero,chicritico);
end

% aca hay que hacer el plot 3d con g2x, g2y, g2z

%
%				/---->Propulsor-----\
%				|					|
%				|					|
%----->Motor----|					|----->Velocidad WARP
%				|					|
%				|					|
%				\---->Propulsor-----/
%
%
%	Motor(nucleo WARP) : 72 horas, varia linealmente hasta en 12 horas
%	Propulsor : exponencial, tiempo medio 10 horas
%

seedU1(1)=13;
seedU1(2)=20;
seedU2(1)=52;
seedU2(2)=87;
seedU3(1)=101;
seedU3(2)=115;
seedU4(1)=101;
seedU4(2)=135;
seedU5(1)=141;
seedU5(2)=175;

[sec1,exis1,clases1] = lecuyeg(seedU1(1),seedU1(2));
[sec2,exis2,clases2] = lecuyeg(seedU2(1),seedU2(2));
[sec3,exis3,clases3] = lecuyeg(seedU3(1),seedU3(2));
[sec4,exis4,clases4] = lecuyeg(seedU4(1),seedU4(2));
[sec5,exis5,clases5] = lecuyeg(seedU5(1),seedU5(2));

sumsteps = 100;
cant = 20;

for i=1:cant
	T(i) = monteintegrate(sec1,sec2,sec3,sec4,sec5,sumsteps);
	sec1 = sec1(sumsteps:length(sec1));
	sec2 = sec2(sumsteps:length(sec2));
	sec3 = sec3(sumsteps:length(sec3));
	sec4 = sec4(sumsteps:length(sec4));
	sec5 = sec5(sumsteps:length(sec5));
end

Tprom = mean(T);
for i=1:cant
	taux(i) = Tprom;
end

Tdesv = std(T);

tdeviation = ( tstudent * Tdesv ) / sqrt(cant);

plot(T,"+",taux,"-");
print('tiemposvuelo.eps', '-deps');

printf("Con nivel de significacion 5%% , el tiempo promedio de WARP esta comprendido en el rango: %f +/- %f (%f)\n",Tprom,tdeviation, Tdesv);


