close all
clear all

%Se lee el audio muestra
[x, FS]=audioread('archivoPrueba_CI.wav');

%Grafica de tiempo y frecuencia del audio original
figure(1)
subplot(211)
plot(x)
grid

%Tranformada de fourier del audio original
X=fftshift(fft(x));
F=-FS/2:FS/length(x):FS/2-FS/length(x);

figure(1)
subplot(212)
plot(F, abs(X));
grid

%Se deben eliminar las frecuencias de 400 y 4000

%-----------Filtro para 4000
%Coeficientes
a = [1,-8.14001316632278,31.1490234153266,-73.4060838475080,117.669130221526,-133.877970512434,109.442603889011,-63.5009844720040,25.0622265542273,-6.09162763748804,0.696077810430452];
b = [0.834312777338878,-7.04634430787417,27.9747193777107,-68.3876781176394,113.700498790211,-134.148634784729,113.700498790211,-68.3876781176394,27.9747193777107,-7.04634430787417,0.834312777338878];

%Se realiza el filtrado de la señal
y1 = filter(b,a,x);

%Graficas de la señal con el primer filtrado en 4000Hz
figure(2)
subplot(211)
plot(y1)
grid

Y1=fftshift(fft(y1));
F1=-FS/2:FS/length(y1):FS/2-FS/length(y1);

figure(2)
subplot(212)
plot(F, abs(Y1));
grid

%------------Filtro para 400

a2 = [1,-10.1660858363152,46.9695140291821,-130.165495349692,240.366755326145,-310.492107236970,286.213635960371,-188.219047088019,86.5044002672514,-26.4503036598853,4.83996610909115,-0.401232520926174];
b2 = [0.650287374699145,-7.15316112169059,35.7658056084530,-107.297416825359,214.594833650718,-300.432767111005,300.432767111005,-214.594833650718,107.297416825359,-35.7658056084530,7.15316112169059,-0.650287374699145];

%Segundo filtrado para frecuencia de 400Hz
y2 = filter(b2,a2,y1);


%Espectro final del audio post filtrado
figure(3)
subplot(211)
plot(y2)
grid

Y2=fftshift(fft(y2));
F2=-FS/2:FS/length(y2):FS/2-FS/length(y2);

figure(3)
subplot(212)
plot(F, abs(Y2));
grid

%Se manda a escribir el audio filtrado
audiowrite('MartinMorenoCesarSadrak_FiltradaIIR.wav',y2,FS);
