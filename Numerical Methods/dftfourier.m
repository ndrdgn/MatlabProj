clc
clear

% 110180807 Nadir Doğan
N = 51; T = 0.5;
x = [2.542093 0.468238 -1.77268 -5.39948 3.70136 -5.51955 -3.18012 -0.67726 -0.00354 4.438278 4.115519 4.917382 4.215726 0.839853 -0.37754 -3.67276 -4.79094 -4.18733 -5.38507 -1.77695 0.290933 2.40339 5.048626 3.665169 5.291073 2.397254 -0.32691 -0.73802 -5.01271 -4.71194 -4.45979 -4.45855 0.011117 0.308739 3.629702 4.519921 4.698322 4.513333 1.2386 0.475607 -3.04779 -4.693 -3.97781 -5.71671 -2.01817 -0.12502 1.405532 5.332182 3.726818 5.182152 3.006022];

for i=0 : N-1
    a = 0; b = 0;
    for n = 0 : N-1
       a = a + x(n+1) * cos(2*pi*i*n/51);
       b = b + x(n+1) * sin(2*pi*i*n/51);
    end
    X(i+1) = a - b;
    ampX(i+1) = (a^2 + b^2)^0.5;
    phaseX(i+1) = atand(-b/a);
end

disp ('dominant frequencies (in Hz) are :');

maxamp=max(ampX);
for i=0:N-1
    if ampX(i+1)/maxamp >= 0.5
        disp (i/T)
    end
end
i=0:1/T:N/T - 1;
plot (i,ampX)
xlabel ('frequency (w in Hz)')
ylabel ('Amplitude |X(w)|')
figure
plot (i,phaseX)
xlabel ('frequency (w in Hz)')
ylabel ('Phase (in degrees)')