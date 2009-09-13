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


function ret=f2(t,T)
global K;
global Ku;
global Tdeseada;
global Toutmedia;
	ret = K*(tout(t) - Toutmedia) + (K+Ku)*(Tdeseada-T);
endfunction

function test()
	global K;
	hold on;
		plot(0,0,'.',[0:48],tout([0:48]),'+-r')
		legend('Temperatura Exterior')
		title('Temperatura Interior')
		xlabel('Tiempo (horas)')
		ylabel('Temperatura (grados celsius)')

	for i = [0.25,0.5,1,2,5,10,15,20]
	        K = i;
		
		%[t,x]=rk4('f2',[0,48],10);
		[t,x]=rungekutta(@f2,0,48,10,60*48);
		axis([0,48,0,35]);
		
		plot(t,x,'-');
		if (i<1)
			legend(sprintf("%.2f",i))
		else
			legend(sprintf("%d",i))
		endif
	endfor
	print -deps ej1b.eps
	pause(20);
endfunction

test();
