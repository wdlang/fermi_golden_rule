clear all; close all; clc; myfont = 22;

N = 300;
delta = 1;
T = 2*pi/ delta;
g = 0.15;
gamma = 2*pi*g*g/delta;

Eblist = [0, 0.15, 0.3, 0.5];
tlist = T*(0:0.01:3);
plist = zeros(length(Eblist), length(tlist));
plist2 = zeros(length(Eblist), length(tlist));

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
        
        ninter = floor(time/T);
        if ninter == 0
            plist2(sw,s) = exp(-gamma*time);
        end
        if ninter == 1
            plist2(sw,s) = abs( exp(-gamma*time/2) -gamma*(time - T)*exp(-gamma*(time - T)/2)*exp(i*Eb*T) )^2;
        end
        if ninter == 2
            plist2(sw,s) = abs( exp(-gamma*time/2) -gamma*(time - T)*exp(-gamma*(time - T)/2)*exp(i*Eb*T) ...
                + (0.5*gamma^2*(time - 2*T)^2 - gamma*(time - 2*T))*exp(-gamma*(time - 2*T)/2)* exp(i*2*Eb*T) )^2;
        end        
    end
end

h1= figure;
plot(tlist./T, plist(1,:),tlist./T, plist(2,:),'--',tlist./T, plist(3,:),':',tlist./T, plist(4,:),'-.','linewidth',2)
% hold on 
% plot(tlist./T, plist2(1,:),tlist./T, plist2(2,:),'--','linewidth',2)
set(gca,'fontsize',myfont)
ylim([0 1])

xlabel('$t/ t_{H}$','fontsize',myfont,'Interpreter','Latex')
ylabel('$P_i$','fontsize',myfont,'Interpreter','Latex')
str1 = strcat('$\alpha=',num2str(Eblist(1)),'$');
str2 = strcat('$\alpha=',num2str(Eblist(2)),'$');
str3 = strcat('$\alpha=',num2str(Eblist(3)),'$');
str4 = strcat('$\alpha=',num2str(Eblist(4)),'$');
hleg = legend(str1,str2,str3,str4);
set(hleg,'location','Southwest','box','off','Interpreter','Latex')
% XL=xlim; YL=ylim;
% text(0.02*(XL(2)-XL(1))+XL(1),0.06*(YL(2)-YL(1))+YL(1),'(a)','fontsize',22 , 'Interpreter','latex')

print(h1,'-depsc','exact.eps')