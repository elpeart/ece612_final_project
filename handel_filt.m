load handel.mat
plot(y)
title('Handel Signal')
saveas(gcf, 'Handel.jpg')
figure;
Y = fft(y);
plot(abs(Y))
title('Handel FFT')
saveas(gcf, 'Handel_fft.jpg')
%sound(y, Fs)

n = 1:length(y);
n = n';
figure;
% noise = 1/16 * cos(4000 * 2 * pi * n / Fs);
% noise = noise + 1/16 * cos(3000 * 2 * pi * n / Fs);
% noise  = noise + 1/16 * cos(2000 * 2 * pi * n / Fs);
% noise = noise + 1/16 * cos(2500 * 2 * pi * n / Fs);
% noise = noise + 1/16 * cos(3500 * 2 * pi * n / Fs);
noise  = 1/16 * wgn(length(y), 1, 10);
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
yb = filter(b, a, noisy);
figure;
plot(yb)
title('Butterworth Filtered Signal')
saveas(gcf, 'handel_butter.jpg')
yb_fft = abs(fft(yb));
figure;
plot(yb_fft)
title('FFT of Butterworth Filtered Signal')
saveas(gcf, 'handel_butter_fft.jpg')
sound(yb, Fs)