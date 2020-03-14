function x = RandomLaplacian(l)
n=l
A = round(rand(n))
A = max(A,A')
for i=1:n
    A(i,i)=0
end
D=diag(round(0.5*randn(n,1)))
for j=1:n
    for k =1:n
        if A(j,k)==1
            D(j,j)=D(j,j)+1
        end
    end
end
L=D-A
x =L
end
