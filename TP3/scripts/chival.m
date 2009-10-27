function resp = chival(oes,E)
resp = 0;
n = length(oes);

for i=1:n
	resp = resp + ((oes(i) - E)^2)/E;
end

endfunction
