function resultado = TiraRepetidos (vector,diff)
n=length(vector);
k=1;
resultado(1)=vector(1);
for u=1:n-1
    if abs(vector(u+1)-vector(u))>diff
       %-passagem entre extremos e maior que diff
       resultado(k+1)= vector(u+1);
       k=k+1;
    end
end
end