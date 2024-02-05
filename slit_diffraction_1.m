n = 9;

x = -n:0.01:n;

x = x + 0.005;

x = pi*x;

y = sin(x)./x;

y = y.^2;

sum(y)*0.01*pi/pi