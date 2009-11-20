% Octave script: mm1.m
% Proposito:     Simula una cola M/M/1
%
% Declaracion de constantes y variables:
clear all
hold off;
%Valores sacados de teorico.m
longitudMediaColaReal=3.2; %Lq
longitudMediaDelSistemaReal=4; %L
%Cantidad de simulaciones
pasitos=50;

global Q_LIMIT = 100;
global BUSY    = 1;
global IDLE    = 0;

global next_event_type;
global num_custs_delayed;
global num_delays_required;
global num_events;
global num_in_q;
global server_status;


global area_num_in_sys;
global costo_cliente_acumulado;
global costo_sistema_acumulado;
global costo_sistema;
global costo_cliente;




global area_num_in_q;
global area_server_status;
global mean_interarrival;
global mean_service;
global time;
global time_arrival;
global time_last_event;
global time_next_event;
global total_of_delays;


vec= [800,1300,1800,2300,2800,3300,3800,4300,4800,5300,5800,6300,6800,7300,7800,8300,8800,9300,9800,10300,10800,11300,11800,12300,12800]

calculo=zeros(1,length(vec));
calculo2=zeros(1,length(vec));
calculo3=zeros(1,length(vec));
calculo4=zeros(1,length(vec));
calculo5=zeros(1,length(vec));
calculo6=zeros(1,length(vec));
calculo7=zeros(1,length(vec));
i=1;

for n = vec
	
	
	% Abre los archivos I/O
	inpfile = fopen('mm1.inp','r');
	outfile = fopen('mm1.out','w');
	timfile = fopen('mm1.tim','w');
	
	% Especifica el numero de eventos
	num_events = 2;
	
	% Lee el archivo de entrada
	%Los parametros son Arrivos: Lambda, Tiempo que tarda el sistema en atender un cliente (1/mu) y finalmente cantidad de personas n
	xdata = fscanf(inpfile,'%f %f %f',[1 3]);
	mean_interarrival   = xdata(1);
	mean_service        = xdata(2);
	%num_delays_required = xdata(3);
	num_delays_required = n;
	
	% Escribe los encabezados de los reportes y parametros de entrada
	fprintf(outfile,'Sistema de cola de servidor simple\n\n');
	fprintf(outfile,'Tiempo medio entre arribos %11.3f minutos\n\n',mean_interarrival);
	fprintf(outfile,'Tiempo medio de servicio   %11.3f minutos\n\n',mean_service);
	fprintf(outfile,'Numero de clientes         %14d\n\n', num_delays_required);

	fprintf(timfile,'Series de tiempo producidas por mm1.m \n');
	fprintf(timfile,'3\n');
	fprintf(timfile,'time\n');
	fprintf(timfile,'longitud de la cola\n');
	fprintf(timfile,'ocupacion del servidor (OCUPADO=1,LIBRE=0)\n');

	% Inicializa la simulacion
	initialize();	

	% Corre la simulacion
	while ( num_custs_delayed < num_delays_required )
		fprintf(timfile, "%16.3f %d %d\n",time, num_in_q, server_status);
		% Determina el proximo evento
		timing();
		
		% Actualiza los acumuladores estadisticos de tiempos medios
		update_time_avg_stats();
		
		% Invoca al evento apropiado
		switch (next_event_type)
			case 1
				arrive();
				%break;
			case 2
				depart();
				%break;
		endswitch
	endwhile

	% Invoca al generador de reportes y fin de la simulacion
	resp=report2(outfile);
	calculo(i) =  resp(1);%Guardo el primero parametro (Longitud media de cola)
	calculo2(i) = resp(2);%Guardo el segundo parametro (Longitud media del sistema)
  calculo3(i) = resp(3);%costo cliente
	calculo4(i) = resp(4);%costo sistema
	calculo5(i) = resp(5);%costo sistema acumulado
	calculo6(i) = resp(6);%tiempo medio del sistema
	calculo7(i) = resp(7);%Utilizacion del servidor
	calculo8(i) = resp(8);%Tiempo medio en cola
	i=i+1;
	
	fclose(inpfile);
	fclose(outfile);
	fclose(timfile);
end
hold on;

calculo
calculo2
plot(vec,calculo,'b*-');
plot(vec,calculo2,'b+-');
legend('Longitud media de la cola','Longitud media en el sistema');
xlabel('Cantidad total de personas enviadas a razon lambda(clientes/hora).');
ylabel('Cantidad de personas en la cola');
print -deps lMedia.eps

