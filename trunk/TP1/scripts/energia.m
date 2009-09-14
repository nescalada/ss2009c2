global K;
global Ku;
global Tdeseada;
global Toutmedia;
global Tacond;

% defino las constantes del modelo
% constantes de enfriamiento
% interior
K=0.25;
% exterior
Ku=0.7;
% temp deseada
Tdeseada=20;
% temp media
Toutmedia=10;
% t del aire acondicionado
Tacond = Tdeseada - (K/Ku)*(Toutmedia - Tdeseada);

% modelado de temperatura exterior en horas
function ret=tout(t)
	global Toutmedia;

	ret = Toutmedia-6*cos((2*pi*t)/24);
endfunction

function ret=u(T)
	global Tdeseada;

	if(T> Tdeseada+1)
		ret=-1;
	else if(T< Tdeseada)
		ret= 4;
	else
		ret= 1.5;
	endif
    endif

endfunction

% temp interna del modelo 1
function ret=ftempm1(t,T)
    global K;
    global Ku;
    global Tdeseada;
    global Toutmedia;

	ret = K*(tout(t) - Toutmedia) + (K+Ku)*(Tdeseada-T);
endfunction

% temp interna del modelo 2
function ret=ftempm2(t,T)
    global K;
    global Ku;
    global Tdeseada;
    global Toutmedia;

	ret = K*(tout(t) - T) +u(T);
endfunction

% aplicacion temp interna modelo 1
function ret = ftemp1(t)
    global Toutmedia;
    if (t==0)
        ret = Toutmedia;
    else 
        [TMD1t,TMD1T]=rungekutta(@ftempm1,0,t,10,60*48);
        ret = TMD1T(length(TMD1T));
    endif
endfunction

% aplicacion temp interna modelo 2
function ret = ftemp2(t)
    global Toutmedia;
    if (t==0)
        ret = Toutmedia;
    else 
        [TMD2t,TMD2T]=rungekutta(@ftempm2,0,t,10,60*48);
        ret = TMD2T(length(TMD2T));
    endif
endfunction

% energia modelo 1
function ret = fenemodel1(t)
    global Ku;
    global Tacond;

    %ftemp1(t)
    ret = Ku * abs(Tacond - ftemp1(t));
endfunction

% energia modelo 2
function ret=fenemodel2(t)
    ret = abs(u(ftemp2(t)));
endfunction

function test2()
	global K;
	hold on;

    K = 0.25;

    [x,y] = mieuler(@fenemodel1,0, 48, 0, 48);

    plot(x,y,'-b');

    [x,y] = mieuler(@fenemodel2,0, 48, 0, 48);

    plot(x,y,'-+g');

    %legend('Energia consumida Modelo 1','Energia consumida Modelo 2');
	title('Energia total consumida');
	xlabel('Tiempo (horas)');
	ylabel('Energia');

	print -deps energiatotal.eps
    pause(30);

endfunction

function test()
	global K;
	hold on;

    K = 0.25;

    %Modelo 1	
    %Integro la energia del modelo1
    k = 2;
    y(1)=0;
	for i = 1:48
        x(k) = i;
        y(k) = fenemodel1(i);
        k=k+1
    endfor

	plot(x,y,'-b');

    %Integro la energia del modelo2
    k = 2;
    y(1)=0;
	for i = 1:48
        x(k) = i;
        y(k) = fenemodel2(i);
        k=k+1
    endfor

	plot(x,y,'-+g');
    %legend('Energia consumida Modelo 1','Energia consumida Modelo 2');
	title('Energia consumida');
	xlabel('Tiempo (horas)');
	ylabel('Energia');
    print -deps energia.eps
	pause(20);
endfunction

test2();
