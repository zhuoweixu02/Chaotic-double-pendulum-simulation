%%
figure(4)
plot(t,X(:,1),t,X(:,2))
title('关节角\theta随时间t变化曲线')
xlabel('t(s)')
ylabel('\theta(rad)')
legend('\theta_1', '\theta_2')
%%
figure(5)
plot(t,X(:,3),t,X(:,4))
title('关节角速度\omega随时间t变化曲线')
xlabel('t(s)')
ylabel('\omega(rad/s)')
legend('\omega_1', '\omega_2')
%%
m1=0.6;
m2=0.5;
g=9.8;
l1=0.15;
l2=0.1;
c=0.05;
J1=1/3*m1*l1^2*(lam^3+(1-lam)^3);
J2=1/12*m2*l2^2;
beta1=zeros(length,1);
beta2=zeros(length,1);
for i=1:length
    theta1=interp1(t,X(:,1),tarray(i),"spline");
    theta2=interp1(t,X(:,2),tarray(i),"spline");
    omega1=interp1(t,X(:,3),tarray(i),"spline");
    omega2=interp1(t,X(:,4),tarray(i),"spline");
    c1=(c*omega2-2*c*omega1);
    c2=-c*(omega2-omega1);
    Q1=-m1*g*(0.5-lam)*l1*cos(theta1)+m2*g*lam*l1*cos(theta1)+c1;
    Q2=+m2*g*(0.5-miu)*l2*sin(theta2)+c2;
    M=[J1+m2*(lam*l1)^2, m2*lam*l1*(0.5-miu)*l2*sin(theta2-theta1);
    m2*lam*l1*(0.5-miu)*l2*sin(theta2-theta1), J2+m2*(0.5-miu)^2*l2^2;];
dXdt34=M\[Q1-m2*lam*l1*(0.5-miu)*l2*cos(theta2-theta1)*omega2^2;Q2+m2*lam*l1*(0.5-miu)*l2*cos(theta2-theta1)*omega1^2;];
    beta1(i)=dXdt34(1);
    beta2(i)=dXdt34(2);
end
figure(3)
plot(tarray, beta1,tarray,beta2)
title('关节角加速度\alpha随时间t变化曲线')
xlabel('t(s)')
ylabel('\alpha(rad/s^2)')
legend('\alpha_1', '\alpha_2')

