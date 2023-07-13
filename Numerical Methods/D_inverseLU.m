clc
clear

% Coefficient Matrix
A =    [41214.3,    0,          -6869.05,   11897.5,    -27476.2,   0,          0;
    
        0,          41214.3,    11897.5,    -20607.1,   0,          0,          0;
        
        -6869.05,   11897.5,    68690.5,    0,          -6869.05,   -11897.5,   -27476.2;
        
        11897.5,    -20607.1,   0,          41214.3,    -11897.5,   -20607.1,   0;
        
        -27476.2,   0,          -6869.05,   -11897.5,   41214.3,    0,          -6869.05
        
        0,          0,          -11897.5,   -20607.1,   0,          41214.3,    11897.5;
        
        0,          0,          -27476.2,   0,          -6869.05,   11897.5,    34345.2];

% Right-hand side Matrix
B =    [0,          0,          0,          -250000,    0,          0,          0];
[m,n] =  size(A);

% Upper Matrix
s=0;
for j = 1:n
    for i = s+1:m-1
    t = A(i+1,j) / A(j,j);
    A(i+1,:) = A(i+1,:) - t * A(j,:);
    B(i+1) = B(i+1) - t * B(j);
    f(i+1,j) = t;
    end
    s=s+1;
end
U = A; % Upper Matrix 
L = f; L(:,n) = zeros(n,1);
for i=1:n
    L(i,i)=1;
end
U % Upper Matrix;
L % Lower Matrix;

% So far part A of question 1.
% To inverse calculation Forward elimination, solve LB = I
b = eye(n);
for i = 1:m
    B(1,i) = b(1,i)/L(1,1);
    for k = 2:m
        sum = 0;
            for j = k-1:-1:1
              sum = sum + L(k,j)*B(j,i);
            end
        B(k,i) = (b(k,i)- sum)/L(k,k);
    end
end
% Backward substitution, solve U*Ainv = B
for i = 1:m
      Ainv(m,i) = B(m,i)/U(m,m);
      for k = m-1:-1:1
        sum = 0;
        for j = k+1:m
           sum = sum + U(k,j)*Ainv(j,i);
        end
        Ainv(k,i) = (B(k,i)- sum)/U(k,k);
      end
end
% Inverse of A
fprintf('\n  Inverse OF A :\n');
Ainv