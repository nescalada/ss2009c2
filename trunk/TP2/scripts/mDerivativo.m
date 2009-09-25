%Computadora 1
%x1 es tita
%x2 es tita punto
%Valores de las constantes
b   = 0.02;
I   = 0.004;

%Paso
h   = 0.01;

%Vector de tiempo
t = 0 : h : 350;


%Armado de vectores
kd=0.001;

x1uno     = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1uno(1)     = 0;
x2(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*x2(q);

    k21= h*((kd*(0.01)-(b+kd)*x2(q))/I);
    k12=h*(x2(q)+(1/2)*k21);

    k22=h*((kd*(0.01)-(b+kd)*(x2(q)+(k21/2)))/I);
    k13=h*(x2(q)+1/2*k22);
    k23=h*((kd*(0.01)-(b+kd)*(x2(q)+k22/2))/I);
    k14=h*(x2(q)+k23);
    x1uno(q+1)= x1uno(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((kd*(0.01)-(b+kd)*(x2(q)+k23))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end


%ffffffffffffffffffffffff
%Armado de vectores
kd=0.01;

x1dos  = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1dos(1)     = 0;
x2(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*x2(q);

    k21= h*((kd*(0.01)-(b+kd)*x2(q))/I);
    k12=h*(x2(q)+(1/2)*k21);

    k22=h*((kd*(0.01)-(b+kd)*(x2(q)+(k21/2)))/I);
    k13=h*(x2(q)+1/2*k22);
    k23=h*((kd*(0.01)-(b+kd)*(x2(q)+k22/2))/I);
    k14=h*(x2(q)+k23);
    x1dos(q+1)= x1dos(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((kd*(0.01)-(b+kd)*(x2(q)+k23))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end

%fffffffffffffffff
%Armado de vectores
kd=1;

x1tres = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1tres(1)  = 0;
x2(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*x2(q);

    k21= h*((kd*(0.01)-(b+kd)*x2(q))/I);
    k12=h*(x2(q)+(1/2)*k21);

    k22=h*((kd*(0.01)-(b+kd)*(x2(q)+(k21/2)))/I);
    k13=h*(x2(q)+1/2*k22);
    k23=h*((kd*(0.01)-(b+kd)*(x2(q)+k22/2))/I);
    k14=h*(x2(q)+k23);
    x1tres(q+1)= x1tres(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((kd*(0.01)-(b+kd)*(x2(q)+k23))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end

hold on;

plot(t,x1uno,'b-');


plot(t,x1dos,'b-');

plot(t,x1tres,'b-');

plot(t,0.01*t,'b-');

legend('Kd=0.001','Kd=0.01','Kd=1.00','Blanco');

xlabel('Tiempo');
ylabel('Angulo');
print -deps mDerivativo.eps
