clc
clear

% Coefficients Matrix
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

% Now use a vector y to solve 'Ly=b'
y=zeros(m,1); % initiation for y 
y(1)=B(1)/L(1,1);
for i=2:m
   %y(i)=B(i)-L(i,1)*y(1)-L(i,2)*y(2)-L(i,3)*y(3);
    y(i)=-L(i,1)*y(1);
      for k=2:i-1
          y(i)=y(i)-L(i,k)*y(k);
      end
      y(i)=(B(i)+y(i))/L(i,i);
end
y
% Now we use this y to solve Ux = y
x=zeros(m,1);
x(m)=y(m)/U(m,m);
i=m-1;
q=0;
while  (i~= 0)
  x(i)=-U(i,m)*x(m);
   q=i+1;
      while (q~=m)
          x(i)=x(i)-U(i,q)*x(q);
          q=q+1;
      end
    x(i)=(y(i)+x(i))/U(i,i);
    i=i-1;
end
x
