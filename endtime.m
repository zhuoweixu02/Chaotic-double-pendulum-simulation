function [t_stop,t, X, Earray,E_pit]=endtime(lam, miu,tmax,cone,ctwo)
%tmax=2000;
[t,X] = ode45(@func525,[0 tmax],[0 pi/2 0 0]');
m1=0.6;
m2=0.5;
g=9.8;
l1=0.15;
l2=0.1;
% c=0.05;
J1=1/3*m1*l1^2*(lam^3+(1-lam)^3);
J2=1/12*m2*l2^2;

theta1=pi/2;
theta2=0;
Ep1=m1*g*(0.5-lam)*l1*sin(theta1)+m2*g*((0.5-miu)*l2*cos(theta2)-lam*l1*sin(theta1))+(m1+m2)*g*0.5;
theta1=pi/2;
theta2=pi;
Ep2=m1*g*(0.5-lam)*l1*sin(theta1)+m2*g*((0.5-miu)*l2*cos(theta2)-lam*l1*sin(theta1))+(m1+m2)*g*0.5;
theta1=pi/2+pi;
theta2=0;
Ep3=m1*g*(0.5-lam)*l1*sin(theta1)+m2*g*((0.5-miu)*l2*cos(theta2)-lam*l1*sin(theta1))+(m1+m2)*g*0.5;
theta1=pi/2+pi;
theta2=pi;
Ep4=m1*g*(0.5-lam)*l1*sin(theta1)+m2*g*((0.5-miu)*l2*cos(theta2)-lam*l1*sin(theta1))+(m1+m2)*g*0.5;
E_min=min([Ep4 Ep3 Ep2 Ep1]);
E_pit=1.001*E_min;
n=length(t);
for i=1:n
    i;
    theta1=X(i,1);
    theta2=X(i,2);
    omega1=X(i,3);
    omega2=X(i,4);
    T=0.5*(J1+m2*(lam*l1)^2)*omega1^2+0.5*(J2+m2*(0.5-miu)^2*l2^2)*omega2^2+m2*omega1*omega2*lam*l1*(0.5-miu)*l2*sin(theta2-theta1);
    Ep=m1*g*(0.5-lam)*l1*sin(theta1)+m2*g*((0.5-miu)*l2*cos(theta2)-lam*l1*sin(theta1))+(m1+m2)*g*0.5;
    E=T+Ep;
    Earray(i)=E;
    if E<E_pit
        if i~=1
            t_stop=(t(i)+t(i-1))/2;
        else
            t_stop=0;
        end
        break
    end
     t_stop=t(i);
end
% if i==n
%     
%X=[θ1;θ2;ω1;ω2]
function dXdt = func525(t,X)
m1=0.6;
m2=0.5;
g=9.8;
l1=0.15;
l2=0.1;
% c=0.05;
J1=1/3*m1*l1^2*(lam^3+(1-lam)^3);
J2=1/12*m2*l2^2;
cone=evalin('base','cone');
ctwo=evalin('base','ctwo');
c1=-cone*X(3)+ctwo*(X(4)-X(3));
c2=-ctwo*(X(4)-X(3));
Q1=-m1*g*(0.5-lam)*l1*cos(X(1))+m2*g*lam*l1*cos(X(1))+c1;
Q2=+m2*g*(0.5-miu)*l2*sin(X(2))+c2;
M=[J1+m2*(lam*l1)^2, m2*lam*l1*(0.5-miu)*l2*sin(X(2)-X(1));
    m2*lam*l1*(0.5-miu)*l2*sin(X(2)-X(1)), J2+m2*(0.5-miu)^2*l2^2;];
dXdt34=M\[Q1-m2*lam*l1*(0.5-miu)*l2*cos(X(2)-X(1))*X(4)^2;Q2+m2*lam*l1*(0.5-miu)*l2*cos(X(2)-X(1))*X(3)^2;];
dXdt=[X(3);
      X(4);
      dXdt34;];
end
end

