clc, clear
%% Generating Laplacian of the graph
n = 20;
C = RandomLaplacian(20);
%% Generating 1000 random Cuts
X=[]
for j=1:1000
x=[]
for i=1:20
    if randn(1,1)>0
        x(i) =1;
    else
        x(i)=-1;
    end
end
X(:,j) = x;
end
X(:,1)
%% plotting objective value for the 1000 cuts
V = []
for i=1:1000
    V(i) = X(:,i)'*C*X(:,i);
end
figure(1)
plot(V)
%% plotting the same value for the 1000 cuts
figure(2)
hist(V, unique(V))
max(V)
%% optimazing the cuts using Goemans-Williamson relaxation
cvx_begin 
variable X(n, n) symmetric; 
maximize(trace(C*X)) 
subject to 
X == +semidefinite(n); 
diag(X)==ones(n,1)
cvx_end
U = chol(X);
Sol = sign(U'*randn(n,1));
E = Sol'*C*Sol
%% Trying different random e for Goemans-Williamson relaxation
Ex =[]
for i=1:1000
S = sign(U'*randn(n,1));
E = Sol'*C*Sol;
Ex(i) = E;
end
figure(3)
hist(Ex, unique(Ex))
