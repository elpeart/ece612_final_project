load handel.mat
plot(y)
title('Handel Signal')
saveas(gcf, 'Handel.jpg')
figure;
Y = fft(y);
plot(abs(Y))
title('Handel FFT')
saveas(gcf, 'Handel_fft.jpg')
audiowrite('Handel.wav', y, Fs)
%sound(y, Fs)

% n = 1:length(y);
% n = n';
figure;

noise  = 1/10 * wgn(length(y), 1, 1);
n_fft = abs(fft(noise));
plot(n_fft)
title('FFT of Noise');
saveas(gcf, 'noise_fft.jpg')

noisy = y + noise;
ny_fft = abs(fft(noisy));
figure;
plot(noisy)
title('Noisy Signal');
saveas(gcf, 'noisy.jpg')
figure;
plot(ny_fft)
title('FFT of noisy signal')
saveas(gcf, 'noisy_fft.jpg')
%sound(noisy, Fs)
audiowrite('Handel_noisy.wav', noisy, Fs)
noise_err = mean(abs(noise))/mean(abs(y));
fprintf('Error from original signal to noisy signal: %4.4f\n', noise_err)

wp = .5;
ws = .6;
rp = 1;
rs = 100;
[n, Wn] = buttord(wp, ws, rp, rs);
[b, a] = butter(n, Wn);
figure;
freqz(b, a)
title('Butter')
saveas(gcf, 'Butter_response.jpg')
yb = filtfilt(b, a, noisy);
butt_err = mean(abs(yb - y))/mean(abs(y));
fprintf('Error after Butterworth Filtering: %4.4f\n', butt_err)
figure;
plot(yb)
title('Butterworth Filtered Signal')
saveas(gcf, 'handel_butter.jpg')
yb_fft = abs(fft(yb));
figure;
plot(yb_fft)
title('FFT of Butterworth Filtered Signal')
saveas(gcf, 'handel_butter_fft.jpg')
audiowrite('Handel_butter.wav', yb, Fs)
%sound(yb, Fs)

[nc, Wnc] = cheb1ord(wp, ws, rp, rs);
[bc, ac] = cheby1(nc, rp, Wnc);

yc1 = filtfilt(bc, ac, noisy);
c1_err = mean(abs(yc1 - y))/mean(abs(y));
fprintf('Error after Chebyshev Type I Filtering: %4.4f\n', c1_err)
figure;
plot(yc1)
title('Chebyshev Type I Filtered Signal')
saveas(gcf, 'handel_cheby1.jpg')
yc1_fft = abs(fft(yc1));
figure;
plot(yc1_fft)
title('FFT of Chebyshev Type I Filtered Signal')
saveas(gcf, 'handel_cheby1_fft.jpg')
%sound(yc1, Fs)
audiowrite('Handel_cheby1.wav', yc1, Fs)

[nc2, Wnc2] = cheb2ord(wp, ws, rp, rs);
[bc2, ac2] = cheby2(nc2, rs, Wnc2);

yc2 = filtfilt(bc2, ac2, noisy);
c2_err = mean(abs(yc2 - y))/mean(abs(y));
fprintf('Error after Chebyshev Type II Filtering: %4.4f\n', c2_err)
figure;
plot(yc2)
title('Chebyshev Type II Filtered Signal')
saveas(gcf, 'handel_cheby2.jpg')
yc2_fft = abs(fft(yc2));
figure;
plot(yc2_fft)
title('FFT of Chebyshev Type II Filtered Signal')
saveas(gcf, 'handel_cheby2_fft.jpg')
%sound(yc2, Fs)
audiowrite('Handel_cheby2.wav', yc2, Fs)

[ne, Wne] = ellipord(wp, ws, rp, rs);
[be, ae] = ellip(ne, rp, rs, Wne);

ye = filtfilt(be, ae, noisy);
e_err = mean(abs(ye - y))/mean(abs(y));
fprintf('Error after Elliptic Filtering: %4.4f\n', e_err)
figure;
plot(ye)
title('Ellipse Filtered Signal')
saveas(gcf, 'handel_ellipse.jpg')
ye_fft = abs(fft(ye));
figure;
plot(ye_fft)
title('Ellipse Filtered Signal')
saveas(gcf, 'handel_Ellipse_fft.jpg')
sound(ye, Fs)
audiowrite('Handel_ellipse.wav', ye, Fs)





