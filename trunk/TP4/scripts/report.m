function report(outfile)
% Funcion:   report
% Proposito:
%
%
global Q_LIMIT;
global BUSY;
global IDLE;

global next_event_type;
global num_custs_delayed;
global num_delays_required;
global num_events;
global num_in_q;
global server_status;


global costo_cliente_acumulado;
global costo_sistema_acumulado;
global costo_sistema;
global costo_cliente;
global area_num_in_sys;


global area_num_in_q;
global area_server_status;
global mean_interarrival;
global mean_service;
global time;
global time_arrival;
global time_last_event;
global time_next_event;
global total_of_delays;

fprintf(outfile, "\n\nTiempo medio en cola:   %16.3f minutos\n\n", ...
        total_of_delays / num_custs_delayed);

%UBER HAXOR
%W en el sistema es Wq / rho
fprintf(outfile, "\n\nTiempo medio en el sistema:   %16.3f minutos\n\n", ...
        (total_of_delays / num_custs_delayed)/(mean_interarrival/(1/mean_service)));
		
		
fprintf(outfile, "Longitud media de la cola:  %16.3f\n\n", ...
		area_num_in_q / time);
fprintf(outfile, "Longitud media en el sistema:  %16.3f\n\n", ...
		area_num_in_sys / time);
fprintf(outfile, "Utilizacion del servidor:   %16.3f\n\n", ...
		area_server_status / time);
fprintf(outfile, "Simulacion finalizada a:    %16.3f minutos\n\n", time);


fprintf(outfile, "Costo cliente por hora:    %16.3f $\n\n", costo_cliente);
fprintf(outfile, "Costo cliente acumulado:    %16.3f $\n\n", costo_cliente_acumulado);
fprintf(outfile, "Costo sistema por hora:    %16.3f $\n\n", costo_sistema);
fprintf(outfile, "Costo sistema acumulado:    %16.3f $\n\n", costo_sistema_acumulado);

fprintf(outfile, "Costo total (sistema + clientes):    %16.3f $\n\n", costo_cliente_acumulado+costo_sistema_acumulado);
fprintf(outfile, "Costo total medio (sistema+clientes)/tiempo_total:    %16.3f $\n\n", (costo_cliente_acumulado+costo_sistema_acumulado)/time);



return;