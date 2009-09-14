global K;
global Ku;
global Tdeseada;
global Toutmedia;

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

function ret=f(t,x) 
	ret=x^2; 
endfunction

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

function ret=f2(t,T)
global K;
global Ku;
global Tdeseada;
global Toutmedia;
	ret = K*(tout(t) - T) +u(T);
endfunction

function ret=f21(t,T)
global K;
global Ku;
global Tdeseada;
global Toutmedia;
	ret = K*(tout(t) - Toutmedia) + (K+Ku)*(Tdeseada-T);
endfunction

function test()
	global K;
    hold on;
    plot(0,0,'.',[0:48],tout([0:48]),'+-r');
    legend('Temperatura exterior');
		title('Temperatura Interior')
		xlabel('Tiempo (horas)')
		ylabel('Temperatura (grados celsius)')
	%for i = [0.25,0.5,1,2,5,10,15,20]
	        K = 0.25;

		%Modelo 2
		%[t,x]=rk4('f2',[0,48],10);
		[t,x]=rungekutta(@f2,0,48,10,60*48);
		axis([0,48,0,35]);
		plot(t,x,'-r');
        legend('0.25');
	%endfor
	print -deps ej1c.eps
endfunction

test();
