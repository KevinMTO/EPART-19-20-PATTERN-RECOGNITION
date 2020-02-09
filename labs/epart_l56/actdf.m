function res = actdf(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!!!)
#da cambiare in realazione alla funzione di attivazione che scelgo
#sto attento xk questo è output del singolo neurone

##	res = 0.5 .* [1 - (actf(sfvalue)).^2];
	res = 0.5 .* (1 - sfvalue.^2);
