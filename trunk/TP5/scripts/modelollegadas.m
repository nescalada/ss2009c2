%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: modelo_llegadas.m
% Genera un histograma, plot q-q y aplica el test chi cuadrado a los
% datos correspondientes al "intervalo entre llegadas al sistema".

% Parametros
clases = 8;     % Cant de clases para el histograma
ancho = 0.03;       % Ancho de cada clase
significacion = 0.05;   % Nivel de significacion para el test chi cuadrado

% Cargamos las horas de llegadas.
load ../datos/llegadasregistro;
n = length(llegadasregistro) - 1;

% Calculamos los intervalos ENTRE llegadas.
for i=1:n
    intervalos(i) = llegadasregistro(i+1) - llegadasregistro(i);
end

% Armamos un histograma
marcas = (0:clases) * ancho + ancho/2;
[f marcas] = hist(intervalos, marcas);
f
marcas

% Como asumimos que los datos provienen de una distribucion 
% exponencial, estimamos lambda como la inversa de la media.
lambda_est = 1 / ((f*marcas') / n)

% Calculamos los valores teoricos de la distribucion, para cada
% una de las marcas de clase.
sup = 1 - exp( -lambda_est * (marcas+ancho/2));
inf = 1 - exp( -lambda_est * (marcas-ancho/2));
teorico = n * (sup - inf);

% Generamos un set de datos con mas valores para poder graficar una curva
% mas suave en el histograma. 
dt = ancho/5;
t = 0:dt:max(marcas);
sup = 1 - exp( -lambda_est * (t+dt/2));
inf = 1 - exp( -lambda_est * (t-dt/2));
z = n * 5 * (sup - inf);

% Mostramos el grafico y lo guardamos en formato eps
__gnuplot_set__ terminal unknown;
hold on;
bar(marcas, f);
xlabel("Tiempos entre arribos al sistema (horas)");
ylabel("Cantidad de arribos al sistema (unidades)");
title("Histograma de tiempos entre arribos al sistema");
plot(t, z , ";Modelo;");
hold off;
__gnuplot_set__ encoding iso_8859_1;
__gnuplot_set__ terminal postscript eps;
__gnuplot_set__ output "histograma_llegadas.eps";
replot;


%pause(10);

closeplot;

% Calculamos el estadistico chi cuadrado
chi_est = 0;
for i=1:clases
    chi_est = chi_est + ((teorico(i) - f(i))^2 / teorico(i));
end
chi_est

% Calculamos el valor critico 
chi_tabla = chisquare_inv(1 - significacion, clases - 2)

% Imprimimos resultado del test
if chi_est >= chi_tabla
    printf("Los datos no provienen de una distribucion exponencial.\n");
else
    printf("No puedo decir que no sean de una distribucion exponencial.\n");
end

% Calculamos quantiles de la muestra y teoricos
quantil_muestra = sort(intervalos);
quantil_teorico = (-1 / lambda_est) * log( 1 - (((1:n) - 0.5) / n));

% Los graficamos
__gnuplot_set__ terminal unknown;
plot(quantil_muestra, quantil_teorico, '@');
xlabel("Cuantiles de la muestra");
ylabel("Cuantiles del modelo teorico");
title("Plot Q-Q de los tiempos entre arribos al sistema");
__gnuplot_set__ encoding iso_8859_1;
__gnuplot_set__ terminal postscript eps;
__gnuplot_set__ output "plot_qq_llegadas.eps";
replot;
closeplot;

% Aplicamos el test KS.

% Normalizo los datos en el intervalo (0, 1)
llegadasregistro = (llegadasregistro - llegadasregistro(1)) / (llegadasregistro(length(llegadasregistro)) - llegadasregistro(1));
n = length(llegadasregistro);

% Genero un histograma
gset terminal x11
hist(llegadasregistro, 10);
[f marcas] = hist(llegadasregistro, clases);

% Computo los estadisticos
f = f / n;
F(1) = 0;
for k =1:clases
    F(k+1) = sum(f(1:k));
end

Dmas = max(F(2:(clases+1)) - marcas);
Dmenos = max(marcas - F(1:clases));
D = max(Dmas, Dmenos)

