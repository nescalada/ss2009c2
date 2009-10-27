function ret = monteintegrate(sec1,sec2,sec3,sec4,sec5,steps)

ret = 0;

tpropulsor = 10 * 24;

for i=1:steps
	%ret = ret + min(12*sec1(i)+72,max(-tpropulsor*log(1-sec2(i)),-tpropulsor*log(1-sec3(i))));
	ret = ret + min(max(30*sec4(i)+20, 5*sec5(i) + 7), min(12*sec3(i)+72,max(-tpropulsor*log(1-sec2(i)),-tpropulsor*log(1-sec1(i)))));
end

ret = ret / steps;

endfunction

