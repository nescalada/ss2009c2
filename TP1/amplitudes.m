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
%	plot(0,0,'.',[0:48],tout([0:48]),'+-r');
	title('Amplitud de Temperatura');
	xlabel('K')
	
	indice=1;
	lasK=[0.25,0.5,1,2,5,10,15,20];
	for i = [0.25,0.5,1,2,5,10,15,20]
	        K = i;

		%Modelo 1		
		[t,x]=rungekutta(@f21,0,48,10,60*48);
		am1(indice)=max(x)-min(x);

		%Modelo 2
		%[t,x]=rk4('f2',[0,48],10);
		[t2,x2]=rungekutta(@f2,0,48,10,60*48);
		am2(indice)=max(x2)-min(x2);
		indice=indice+1;
	endfor
	axis([0,21,0,18]);

	plot([0.25,0.5,1,2,5,10,15,20],am1,'+');
	plot([0.25,0.5,1,2,5,10,15,20],am2,'o');

	legend('Amplitudes del Modelo 1','Amplitudes del Modelo 2');



	print -deps amplitudes.eps
	pause(20);
endfunction

test();
