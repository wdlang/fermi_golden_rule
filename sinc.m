% to prepare the sinc^2 x picture

x= -3:0.001:3;

x = x+ 0.005;

f = sin(x*pi)./(x*pi) ;

g = abs(f).^2;

h1 = figure;

% axes('position', [0.15  0.15  0.7  0.39])

plot(x, g,'linewidth',2)
hold on

for s = 350:350:5600
    s
    a = x(s)* ones(1,1000);
    b = g(s)*(0.001:0.001:1);
    
    plot(a,b, 'r','linewidth',2)
end


xlim([- 3 3 ])
xlabel('$ x/ \pi$ ', 'fontsize',26,'Interpreter','latex')
ylabel('sinc$^2 x $ ', 'fontsize',26,'Interpreter','latex')
set(gca, 'fontsize',22)
print(h1,'-depsc','sinc2.eps')
