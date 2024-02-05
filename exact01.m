clear all; close all; clc; myfont = 22;

N = 1000;
delta = 1;
T = 2*pi/ delta;
g = 0.1;

Eb = 0.5;

H = zeros(2*N+2);
for s = -N: N
    H(s+N+1, s+N+1 ) = s*delta;
    H(s+N+1, 2*N+2) = g;
    H(2*N+2, s+N+1) = g;
end
H(2*N+2, 2*N+2) = Eb;

v0 = zeros(2*N+2, 1);
v0(2*N+2) = 1;

[VV,DD] = eig(H);
dd = diag(DD);
v00 = VV'*v0;

tlist = T*(0:0.01:4);
plist = zeros(1, length(tlist));

for s = 1: length(tlist)
    time = tlist(s);
    v = VV*(exp(-i*dd*time).*v00);
    plist(s) = abs(v(2*N+2))^2;
end

plot(tlist./T, plist)