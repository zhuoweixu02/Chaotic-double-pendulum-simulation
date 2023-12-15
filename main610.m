clear;
opt=figure('name','shaper','color','White');
axis equal;
grid on;
hold on;
axis([-50,50,0,100]);
set(gca,'xtick',-50:10:50);
set(gca,'ytick',0:10:100);

l1=15;
l2=10;
% lam=3/11;
% miu=0.48902;
lam=0.1272;
miu=0.49;
theta1=0;
theta20=pi/2;
theta2=0+theta20;

unit_1=[cos(theta1) sin(theta1)]';
unit_2=[cos(theta2) sin(theta2)]';
%%
bar0=plot([0 0],[50,0],'o-','Color','#FFA07A','linewidth',2,'Markersize',3);
link1=[[0;50;]-unit_1*lam*l1 [0;50;]+unit_1*(1-lam)*l1];
bar1=plot(link1(1,:),link1(2,:),'o-','Color','#FFA07A','linewidth',2,'Markersize',3);

link2=[[0;50;]-unit_1*lam*l1-unit_2*miu*l2 [0;50;]-unit_1*lam*l1+unit_2*(1-miu)*l2];
bar2=plot(link2(1,:),link2(2,:),'o-','Color','#4C7AD0','linewidth',2,'Markersize',3);

%%
tmax=50;
[t_stop,t, X, Earray,E_pit] = endtime6101(lam,miu,tmax);
myObj = VideoWriter('R&R');
writerObj.FrameRate = 200;
open(myObj);


E0=Earray(1);
[t_stop E_pit E0]
length=800;
tarray=linspace(0,tmax,length);
for i=1:length
    theta1=interp1(t,X(:,1),tarray(i),"spline");
    theta2=interp1(t,X(:,2),tarray(i),"spline")+theta20;
%     theta1=X(i,1);
%     theta2=X(i,2)+theta20;
    unit_1=[cos(theta1) sin(theta1)]';
    unit_2=[cos(theta2) sin(theta2)]';

    link1=[[0;50;]-unit_1*lam*l1 [0;50;]+unit_1*(1-lam)*l1];
    link2=[[0;50;]-unit_1*lam*l1-unit_2*miu*l2 [0;50;]-unit_1*lam*l1+unit_2*(1-miu)*l2];

    set(bar1,'xdata',link1(1,:),'ydata',link1(2,:));   
    set(bar2,'xdata',link2(1,:),'ydata',link2(2,:));

    set(gcf,'doublebuffer','on');
    pause(0.01);
    drawnow;
    
    Frame0 = getframe;    
    writeVideo(myObj,Frame0);
end
close(myObj);


