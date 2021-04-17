load handel.mat
plot(y)

Y = fft(y);
plot(abs(Y))
title('Handel FFT')
saveas(gcf, 'Handel_fft.jpg')