%Computadora 1
%x1 es tita
%x2 es tita punto
%Valores de las constantes
b   = 0.02;
K   = 5;
I   = 0.004;
%Paso
h   = 0.01;

%Vector de tiempo
t = 0 : h : 20;


%Armado de vectores
K= 0.030;

x1uno     = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1uno(1)     = 0;
x2(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*x2(q);

    k21= h*((-b*x2(q)+K*(0.01*(t(q))-x1uno(q)))/I);
    k12=h*(x2(q)+(1/2)*k21);

    k22=h*((-b*(x2(q)+k21/2)+K*(0.01*(t(q)+h/2)-(x1uno(q)+k11/2)))/I);
    k13=h*(x2(q)+1/2*k22);
    k23=h*((-b*(x2(q)+k22/2)+K*(0.01*(t(q)+h/2)-(x1uno(q)+k12/2)))/I);
    k14=h*(x2(q)+k23);
    x1uno(q+1)= x1uno(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((-b*(x2(q)+k23/2)+K*(0.01*(t(q)+h)-(x1uno(q)+k13/2)))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end
tonga=2
real=t*0.01;
Error1=(real-x1uno)./real;


%ffffffffffffffffffffffff
K=0.1;

x1dos     = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1dos(1)     = 0;
x2(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*x2(q);

    k21= h*((-b*x2(q)+K*(0.01*(t(q))-x1dos(q)))/I);
    k12=h*(x2(q)+(1/2)*k21);

    k22=h*((-b*(x2(q)+k21/2)+K*(0.01*(t(q)+h/2)-(x1dos(q)+k11/2)))/I);
    k13=h*(x2(q)+1/2*k22);
    k23=h*((-b*(x2(q)+k22/2)+K*(0.01*(t(q)+h/2)-(x1dos(q)+k12/2)))/I);
    k14=h*(x2(q)+k23);
    x1dos(q+1)= x1dos(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((-b*(x2(q)+k23/2)+K*(0.01*(t(q)+h)-(x1dos(q)+k13/2)))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end
Error2=(real-x1dos)./real;

%fffffffffffffffff
K=0.45;

x1tres     = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1tres(1)     = 0;
x2(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*x2(q);

    k21= h*((-b*x2(q)+K*(0.01*(t(q))-x1tres(q)))/I);
    k12=h*(x2(q)+(1/2)*k21);

    k22=h*((-b*(x2(q)+k21/2)+K*(0.01*(t(q)+h/2)-(x1tres(q)+k11/2)))/I);
    k13=h*(x2(q)+1/2*k22);
    k23=h*((-b*(x2(q)+k22/2)+K*(0.01*(t(q)+h/2)-(x1tres(q)+k12/2)))/I);
    k14=h*(x2(q)+k23);
    x1tres(q+1)= x1tres(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((-b*(x2(q)+k23/2)+K*(0.01*(t(q)+h)-(x1tres(q)+k13/2)))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end
Error3=(real-x1tres)./real;

%fffffffffffffffff
K=9.95;

x1tres     = zeros(size(t));
x2     = zeros(size(t));

%Condiciones inicales
x1tres(1)     = 0;
x2(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*x2(q);

    k21= h*((-b*x2(q)+K*(0.01*(t(q))-x1tres(q)))/I);
    k12=h*(x2(q)+(1/2)*k21);

    k22=h*((-b*(x2(q)+k21/2)+K*(0.01*(t(q)+h/2)-(x1tres(q)+k11/2)))/I);
    k13=h*(x2(q)+1/2*k22);
    k23=h*((-b*(x2(q)+k22/2)+K*(0.01*(t(q)+h/2)-(x1tres(q)+k12/2)))/I);
    k14=h*(x2(q)+k23);
    x1tres(q+1)= x1tres(q)+(1/6)*(k11+2*k12+2*k13+k14);


    k24=h*((-b*(x2(q)+k23/2)+K*(0.01*(t(q)+h)-(x1tres(q)+k13/2)))/I);
    %Calculo de x2(q+1)
    x2(q+1)=x2(q)+(1/6)*(k21+2*k22+2*k23+k24);
end
Error4=(real-x1tres)./real;
hold on;

axis([0,15,0,0.11]);

plot(t,Error1,'b-');


plot(t,Error2,'b-');


plot(t,Error3,'b-');

plot(t,Error4,'b-');

legend('K=0.03','K=0.1','K=0.5','K=9.95');

xlabel('Tiempo(segundos)');
ylabel('Error relativo porcentual');
print -deps errorPorcentualMProporcional.eps
