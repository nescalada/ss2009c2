
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
chicero = chival(clases,valesperado);

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

seedU1(1)=4;
seedU1(2)=19;
seedU2(1)=27;
seedU2(2)=54;
seedU3(1)=73;
seedU3(2)=98;
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
cant = 100;

for i=1:cant
	T(i) = monteintegrate(sec1,sec2,sec3,sec4,sec5,sumsteps);
	sec1 = sec1(sumsteps:length(sec1));
	sec2 = sec2(sumsteps:length(sec2));
	sec3 = sec3(sumsteps:length(sec3));
	sec4 = sec4(sumsteps:length(sec4));
	sec5 = sec5(sumsteps:length(sec5));
	if (i > 1)
		aux = std(T);
		Tdesv2(i) = aux;
		tdev2(i) = (( tstudent * aux ) / sqrt(i));
		error(i) = 3 * aux/sqrt(i);
	endif
end

%printf("llego");
error(1) = 5;
plot(1:cant, error);
xlabel('Simulaciones');
ylabel('Cota del Error');
print('cotaerror.eps', '-deps');

pause(20);

Tprom = mean(T);
for i=1:cant
	taux(i) = Tprom;
end

Tdesv = std(T);

tdeviation = ( tstudent * Tdesv ) / sqrt(cant);

plot(T,"+",taux,"-");
%print('tiemposvuelo.eps', '-deps');
xlabel('Simulaciones');
ylabel('Tiempo de vuelo medio (horas)');
legend('Tiempo de Vuelo medio','Tiempo de vuelo');
print('tiemposvuelo.eps', '-deps');


printf("Con nivel de significacion 5%% , el tiempo promedio de WARP esta comprendido en el rango: %f +/- %f (%f)\n",Tprom,tdeviation, Tdesv);


