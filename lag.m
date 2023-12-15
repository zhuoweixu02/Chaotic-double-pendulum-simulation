syms J1 J2 w1 w2 lam miu theta1 theta2 m1 m2 l1 l2
T1=0.5*J1^w1^2;
T2=0.5*J2^w2^2+0.5*m2*((w1*lam*l1*cos(theta1)+w2*(0.5-miu)*l2*sin(theta2))^2+(w1*lam*l1*sin(theta1)-w2*(0.5-miu)*l2*cos(theta2))^2);
simplify(T1+T2)