%Computadora 1
%x1 es tita
%x2 es tita punto
%Valores de las constantes
b   = 0.02;
I   = 0.004;

%Paso
h   = 0.01;

%Vector de tiempo
t = 0 : h : 30;


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
real=t*0.01;
Error1b=(real-x1uno)./real;

%ffffffffffffffffffffffff

%Armado de vectores
kd=0.0001;

x1dosp  = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1dosp(1)     = 0;
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
    x1dosp(q+1)= x1dosp(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((kd*(0.01)-(b+kd)*(x2(q)+k23))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end
real=t*0.01;
Error1=(real-x1dosp)./real;

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
Error2=(real-x1dos)./real;

%fffffffffffffffff
%Armado de vectores
kd=0.1;

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
Error3=(real-x1tres)./real;

hold on;



plot(t,Error1b,'b-');

plot(t,Error1,'b-');


plot(t,Error2,'b-');

plot(t,Error3,'b-');

legend('kd=0.0001','kd=0.001','kd=0.01','kd=0.1');

xlabel('Tiempo(segundos)');
ylabel('Error relativo porcentual');
print -deps errorMDerivativo.eps
