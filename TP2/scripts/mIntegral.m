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
ki=0.0001;
%Condiciones inicales
x1(1)     = 0;
x2uno(1)     = 0;
x3(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*(x2uno(q));
    k21=h*(x3(q));
    k31=h*((-b*x3(q)+ki*0.01*((t(q))^2/2)-ki*x1(q))/I);

    k12=h*(x2uno(q)+k21/2);
    k22=h*(x3(q)+k31/2);
    k32=h*((-b*(x3(q)+k31/2)+ki*0.01*((t(q)+h/2)^2/2)-ki*(x1(q)+k11/2))/I);
    
    k13=h*(x2uno(q)+k22/2);
    k23=h*(x3(q)+k32/2);
    k33=h*((-b*(x3(q)+k32/2)+ki*0.01*((t(q)+h/2)^2/2)-ki*(x1(q)+k12/2))/I);
    
    k14=h*(x2uno(q)+k23);
    k24=h*(x3(q)+k33);
    k34=h*((-b*(x3(q)+k33)+ki*0.01*((t(q)+h)^2/2)-ki*(x1(q)+k13))/I);

    x1(q+1)= x1(q)+(1/6)*(k11+2*k12+2*k13+k14);
    x2uno(q+1)=x2uno(q)+(1/6)*(k21+2*k22+2*k23+k24);
    x3(q+1)=x3(q)+(1/6)*(k31+2*k32+2*k33+k34);
end



%lalalalalal
%Armado de vectores
ki=0.001;

%Condiciones inicales
x1(1)     = 0;
x2dos(1)     = 0;
x3(1)     = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*(x2dos(q));
    k21=h*(x3(q));
    k31=h*((-b*x3(q)+ki*0.01*((t(q))^2/2)-ki*x1(q))/I);

    k12=h*(x2dos(q)+k21/2);
    k22=h*(x3(q)+k31/2);
    k32=h*((-b*(x3(q)+k31/2)+ki*0.01*((t(q)+h/2)^2/2)-ki*(x1(q)+k11/2))/I);
    
    k13=h*(x2dos(q)+k22/2);
    k23=h*(x3(q)+k32/2);
    k33=h*((-b*(x3(q)+k32/2)+ki*0.01*((t(q)+h/2)^2/2)-ki*(x1(q)+k12/2))/I);
    
    k14=h*(x2dos(q)+k23);
    k24=h*(x3(q)+k33);
    k34=h*((-b*(x3(q)+k33)+ki*0.01*((t(q)+h)^2/2)-ki*(x1(q)+k13))/I);

    x1(q+1)= x1(q)+(1/6)*(k11+2*k12+2*k13+k14);
    x2dos(q+1)=x2dos(q)+(1/6)*(k21+2*k22+2*k23+k24);
    x3(q+1)=x3(q)+(1/6)*(k31+2*k32+2*k33+k34);
end
%lalalalalala
%Armado de vectores
ki=0.01;

%Condiciones inicales
x1(1)         = 0;
x2tres(1)     = 0;
x3(1)         = 0;

n=length(t);
for q = 1 : n-1
    %Calculo de x1(q+1)
    k11=h*(x2tres(q));
    k21=h*(x3(q));
    k31=h*((-b*x3(q)+ki*0.01*((t(q))^2/2)-ki*x1(q))/I);

    k12=h*(x2tres(q)+k21/2);
    k22=h*(x3(q)+k31/2);
    k32=h*((-b*(x3(q)+k31/2)+ki*0.01*((t(q)+h/2)^2/2)-ki*(x1(q)+k11/2))/I);
    
    k13=h*(x2tres(q)+k22/2);
    k23=h*(x3(q)+k32/2);
    k33=h*((-b*(x3(q)+k32/2)+ki*0.01*((t(q)+h/2)^2/2)-ki*(x1(q)+k12/2))/I);
    
    k14=h*(x2tres(q)+k23);
    k24=h*(x3(q)+k33);
    k34=h*((-b*(x3(q)+k33)+ki*0.01*((t(q)+h)^2/2)-ki*(x1(q)+k13))/I);

    x1(q+1)= x1(q)+(1/6)*(k11+2*k12+2*k13+k14);
    x2tres(q+1)=x2tres(q)+(1/6)*(k21+2*k22+2*k23+k24);
    x3(q+1)=x3(q)+(1/6)*(k31+2*k32+2*k33+k34);
end

hold on;

plot(t,x2uno,'b-');


%plot(t,x2dos,'b-');

%plot(t,x2tres,'b-');

plot(t,0.01*t,'b-');

legend('Kd=0.0001','Kd=0.001','Kd=0.01','Blanco');

xlabel('Tiempo');
ylabel('Angulo');
print -deps mIntegral.eps
