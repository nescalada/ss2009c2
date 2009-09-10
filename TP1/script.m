function ret=f(t,x); ret=x^2; endfunction;
[t,x]=rk4('f',[0,1],0.01);
plot(t,x);
pause(60);

