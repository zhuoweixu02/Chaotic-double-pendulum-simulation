% lam=0.51;
% miu=1;
% [t E]=endtime(lam, miu);
% t

%%
tmax=150;
ni=100;
nj=100;
% lam=linspace(3/11-0.1,3/11+0.1,ni);
% miu=linspace(0,1,nj);
lam=linspace(0,1,ni);
miu=linspace(0.50,0.52,nj);
t_matrix=zeros(ni,nj);
for i=1:ni
    for j=1:nj
        [tij,t, X, Earray,E_pit]=endtime(lam(i), miu(j),tmax);
        t_matrix(i,j)=tij;
    end
end
%%
figure(1)
mesh(miu,lam,t_matrix);
xlabel('μ')
ylabel('λ')
zlabel('t')
filename='data6122\';
path=[ 'D:\机械动力学\大作业\' filename];
name=['lam' num2str(lam(1)) 'to' num2str(lam(ni)) 'ni' num2str(ni) 'miu' num2str(miu(1)) 'to' num2str(miu(nj)) 'nj' num2str(nj)];
a=[path name];
saveas(1,[a '.fig'])
saveas(1,[a '.png'])
save([a '.mat'],'t_matrix')
%%
%[tij,t, X, Earray,E_pit]=endtime(lam(1), miu(50),tmax);

