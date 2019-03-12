function f = eval_deriv_f(x,l,m)
 w = (m/(x^2))-l;
 g = 2*asin(sqrt(w));
 W = (2*g - sin(2*g)) / (sin(g))^3;
f = -1 - ((2*m*w)/(x^3));