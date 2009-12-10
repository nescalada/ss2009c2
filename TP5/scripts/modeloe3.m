%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Archivo: modelo_e3.m
% Modela la variable aleatoria "tiempo de servicio del servidor E3" con
% los datos existentes.

% Parametros
clases = 8		% Cantidad de intervalos de clase
significacion = 0.05	% Nivel de significacion

% Cargamos las horas de llegadas.
load e3registro;
n = length(e3registro);

% Armamos un histograma.  En x quedan las marcas de clase, y en f
% las frecuencias absolutas.
[f marcas] = hist(e3registro, clases);

% Como asumimos que los datos provienen de una distribucion 
% normal, estimamos la media y la varianza.
media_est = marcas * f'/n
varianza_est = sum(((marcas - media_est).^2) * f') / (n-1)

% Con estos valores tipificamos los datos del histograma
marcas = (marcas - media_est) / sqrt(varianza_est);
ancho = marcas(2) - marcas(1);

% Calculamos los valores teoricos de la distribucion, para cada
% una de las marcas de clase. (frecuencias absolutas)
teorico = (normal_cdf(marcas + ancho/2) - normal_cdf(marcas - ancho/2)) * n;

% Generamos un set de datos teorico con mas valores para que
% la curva sea mas suave.
dt = ancho/5;
t = min(marcas):dt:max(marcas);
z = n * 5 * (normal_cdf(t+dt/2) - normal_cdf(t-dt/2));

% Graficamos el histograma y la distribucion teorica
__gnuplot_set__ terminal unknown;
hold on;
bar(marcas, f);
plot(t, z, ";Modelo;");
xlabel("Tiempos de servicio [min]");
ylabel("Frecuancia absoluta");
hold off;
__gnuplot_set__ encoding iso_8859_1;
__gnuplot_set__ terminal postscript eps;
__gnuplot_set__ output "histograma_e3.eps";
replot;
closeplot;

% Calculamos el estadistico chi cuadrado
chi_est = 0;
for i=1:length(f)
    chi_est = chi_est + ((teorico(i) - f(i))^2 / teorico(i));
end
chi_est

% Calculamos el valor de chi por tablas
chi_tabla = chisquare_inv(1 - significacion, length(f) - 3)

% Imprimimos resultado del test
if chi_est >= chi_tabla
	printf("Los datos no provienen de una distribucion normal.\n");
else
	printf("No puedo decir que no sean de una distribucion normal.\n");
end

% Calculamos los quantiles para el plot Q-Q
quantil_muestra = sort(e3registro);
quantil_teorico = normal_inv( (((1:n) - 0.5) / n), 0, 1);

% Graficamos el plot q-q
__gnuplot_set__ terminal unknown;
plot(quantil_muestra, quantil_teorico, "@");
xlabel("Cuantiles de la muestra");
ylabel("Cuantiles del modelo teorico");
__gnuplot_set__ encoding iso_8859_1;
__gnuplot_set__ terminal postscript eps;
__gnuplot_set__ output "plot_qq_e3.eps";
replot;
closeplot;

