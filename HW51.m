clc,clear
%% piece-wise continous

syms y(x)
m=0.1
y(x) = m*x
XC = randn(1000,1)
for i=2:1000
    XC(i) = XC(i-1)-y(i)
    if rem(i,100)==0
        m=randn(1,1)/i
        y(x) = 2*(m*x)
    end
end
figure(1)
plot(XC)
%% piece-wise discontinous

syms y(x)
m=0.1
y(x) = m*x
XD = []
sig=1
for i=2:1000
    XD(i) = y(i)+y(i-1)
    if rem(i,100)==0
        m=(randlap(1,0.5)/i)*sig
        y(x) = 5*(m*x)
        sig=-1*sig
    end
end
XD=XD'
figure(2)
plot(XD)
%% quadratic spline

XS = randn(1000,1)*50
for i=1:1000
    N(i) = i
end
H = polyfit(N',XS,7)
y = polyval(H,N')
XS = y
figure(3)
plot(XS)
%% Corrupting Signals
XC_Corrupted = XC + randn(1000,1)*30
XD_Corrupted = XD + randn(1000,1)*5
XS_Corrupted = XS + randn(1000,1)*0.6
figure(4)
plot(XC)
hold on
plot(XC_Corrupted)
figure(5)
plot(XD)
hold on
plot(XD_Corrupted)
figure(6)
plot(XS)
hold on
plot(XS_Corrupted)
%% Restoring the signals
%% PiceWise Continous D1,norm1
n = 1000;
e = ones(n,1);
D1 = spdiags([0*e 1*e -1*e],-1:1,n,n);
D1 = full(D1)
D2 = spdiags([1*e -2*e 1*e],-1:1,n,n);
D2 = full(D2)
l = 1
n = 1000;
C = XC_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D1*l*X,1)) 
cvx_end
figure(7)
plot(X,'r')
hold on
%% PiceWise Continous D1,norm2
l = 1
n = 1000;
C = XC_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D1*l*X,2)) 
cvx_end
plot(X,'b')
hold on
%% PiceWise Continous D2,norm1
l = 1
n = 1000;
C = XC_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D2*l*X,1)) 
cvx_end
plot(X,'g')
hold on
plot(XC,'c')
legend('D1,norm1','D1,norm2','D2,norm1','Original Function')
%% PiceWise Discontinous D1,norm1
l = 1
n = 1000;
C = XD_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D1*l*X,1)) 
cvx_end
figure(8)
plot(X,'r')
hold on
%% PiceWise Discontinous D1,norm2
l = 1
n = 1000;
C = XD_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D1*l*X,2)) 
cvx_end
plot(X,'b')
hold on
%% PiceWise Discontinous D2,norm1
l = 1
n = 1000;
C = XD_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D2*l*X,1)) 
cvx_end
plot(X,'g')
hold on
plot(XD,'c')
legend('D1,norm1','D1,norm2','D2,norm1','Original Function')
%% Quadratic Supline D1,norm1
l = 1
n = 1000;
C = XS_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D1*l*X,1)) 
cvx_end
figure(9)
plot(X,'r')
hold on
%% Quadratic Supline D1,norm2
l = 1
n = 1000;
C = XS_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D1*l*X,2)) 
cvx_end
plot(X,'b')
hold on
%% Quadratic Supline D2,norm1
l = 1
n = 1000;
C = XS_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D2*l*X,1)) 
cvx_end
plot(X,'g')
hold on
plot(XS,'c')
legend('D1,norm1','D1,norm2','D2,norm1','Original Function')
%% Testing different regulization weights on D2 Norm1
%% PiceWise Continous D2,norm1
figure(10)
l = [1,2,3]
normC = []
penC = []
for i=1:3
n = 1000;
C = XC_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D2*l(i)*X,1))
cvx_end
normC(i) = norm(XC-X,2)
penC(i) = norm(D2*l(i)*X,2)
plot(X)
hold on
end
plot(XC)
legend('Regulization weight=1','Regulization weight=2','Regulization weight=3','Original Function')
%% PiceWise Discontinous D2,norm1
figure(11)
l = [1,2,3]
normD = []
penD = []
for i=1:3
n = 1000;
C = XD_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D2*l(i)*X,1))
cvx_end
normD(i) = norm(XD-X,2)
penD(i) = norm(D2*l(i)*X,2)
plot(X)
hold on
end
plot(XD)
legend('Regulization weight=1','Regulization weight=2','Regulization weight=3','Original Function')
%% Quadratic Supline D2,norm1
figure(12)
l = [1,2,3]
normS = []
penS = []
for i=1:3
n = 1000;
C = XS_Corrupted; 
cvx_begin 
variable X(n) 
minimize(0.5*norm(C-X)+norm(D2*l(i)*X,1))
cvx_end
normS(i) = norm(XS-X,2)
penS(i) = norm(D2*l(i)*X,2)
plot(X)
hold on
end
plot(XS)
legend('Regulization weight=1','Regulization weight=2','Regulization weight=3','Original Function')
%% Plotting penality Vs Norms
figure(13)
plot(penC,normC)
figure(14)
plot(penD,normD)
figure(15)
plot(penS,normS)