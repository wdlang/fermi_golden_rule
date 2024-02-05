clear all; close all; clc; myfont = 22;

N = 1;
delta = 1;
T = 2*pi/ delta;
g = 0.1;

Eblist = [0.15, 0.5];
tlist = T*(0:0.01:4);
plist = zeros(length(Eblist), length(tlist));

for sw = 1:length(Eblist)
    Eb = Eblist(sw);
    
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
    
    for s = 1: length(tlist)
        time = tlist(s);
        v = VV*(exp(-i*dd*time).*v00);
        plist(sw, s) = abs(v(2*N+2))^2;
    end
end

h1= figure;
plot(tlist./T, plist(1,:),tlist./T, plist(2,:),'--','linewidth',2)
set(gca,'fontsize',myfont)
ylim([0 1])

xlabel('$t/ t_{H}$','fontsize',myfont,'Interpreter','Latex')
ylabel('$P_i$','fontsize',myfont,'Interpreter','Latex')
str1 = strcat('$E_b  =',num2str(Eblist(1)),'$');
str2 = strcat('$E_b=',num2str(Eblist(2)),'$');
hleg = legend(str1,str2);
set(hleg,'location','Southeast','box','off','Interpreter','Latex')
XL=xlim; YL=ylim;
text(0.02*(XL(2)-XL(1))+XL(1),0.06*(YL(2)-YL(1))+YL(1),'(b)','fontsize',22 , 'Interpreter','latex')

print(h1,'-depsc','exactfinite.eps')