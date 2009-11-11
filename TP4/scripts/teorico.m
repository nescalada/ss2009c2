lambda = 1;
mu = 1.25;
rho = lambda / mu;

L = rho / (1 - rho);
Lq = rho^2 / (1 - rho);
VarianzaN = rho / (1-rho)^2;
VarianzaNq = rho^2 * (1 + rho - rho^2) / (1 - rho)^2;
WSistema = 1 / (mu - lambda);
VarianzaWSistema = 1 / (mu^2 * (1 - rho^2));
WCola = rho / (mu - lambda);
VarianzaWCola = rho*(2 - rho) / (mu^2 * (1 - rho^2));

printf("lambda / mu\n");
printf("rho =  %f\n", rho);

printf("Valor medio de individuos en el sistema\n");
printf("L =  %f\n", L);

printf("Varianza numero clientes del sistema\n");
printf("VarianzaN = %f\n", VarianzaN);

printf("Valor medio de inviduos en la cola\n");
printf("Lq =  %f\n", Lq);

printf("Varianza numero clientes en la cola\n");
printf("VarianzaNq = %f\n", VarianzaNq);

printf("Tiempo de un individuo en el sistema");
printf("WSistema = %f\n", WSistema);

printf("Tiempo de un individuo en la cola");
printf("WCola = %f\n", WCola);

printf("Varianza tiempo individuo en el sistema\n");
printf("VarianzaWSistema = %f\n", VarianzaWSistema);

printf("Varianza tiempo individuo en la cola\n");
printf("VarianzaWCola = %f\n", VarianzaWCola);


