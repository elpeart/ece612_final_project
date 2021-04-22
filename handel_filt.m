% ECE 612 Final Project
load handel.mat % load signal
t = 0:1/Fs:(length(y) - 1)/Fs; % for plotting
plot(t, y)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Handel Signal')
saveas(gcf, 'Handel.jpg')

figure;
Y = fft(y);
omega = linspace(0, 2, length(y));
plot(omega, abs(Y))
title('Handel FFT')
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
saveas(gcf, 'Handel_fft.jpg')
audiowrite('Handel.wav', y, Fs)
%sound(y, Fs)

figure;
% add noise
noise  = 1/10 * wgn(length(y), 1, 1);
n_fft = abs(fft(noise));
plot(omega, n_fft)
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
title('FFT of Noise');
saveas(gcf, 'noise_fft.jpg')

noisy = y + noise;
ny_fft = abs(fft(noisy));
figure;
plot(t, noisy)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Noisy Signal');
saveas(gcf, 'noisy.jpg')
figure;
plot(omega, ny_fft)
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
title('FFT of noisy signal')
saveas(gcf, 'noisy_fft.jpg')
%sound(noisy, Fs)
audiowrite('Handel_noisy.wav', noisy, Fs)
noise_err = mean(abs(noise))/mean(abs(y));
fprintf('Error from original signal to noisy signal: %4.4f\n', noise_err)
% first bilinear using built ins
% Butterworth
wp = .5;
ws = .6;
rp = 1;
rs = 60;
[n, Wn] = buttord(wp, ws, rp, rs);
[b, a] = butter(n, Wn);
figure;
freqz(b, a)
title('Butterworth Filter Response')
saveas(gcf, 'Butter_response.jpg')
yb = filtfilt(b, a, noisy);
butt_err = mean(abs(yb - y))/mean(abs(y));
fprintf('Error after Butterworth Filtering: %4.4f\n', butt_err)
figure;
plot(t, yb)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Butterworth Filtered Signal')
saveas(gcf, 'handel_butter.jpg')
yb_fft = abs(fft(yb));
figure;
plot(omega, yb_fft)
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
title('FFT of Butterworth Filtered Signal')
saveas(gcf, 'handel_butter_fft.jpg')
audiowrite('Handel_butter.wav', yb, Fs)
%sound(yb, Fs)

% Cheby1
[nc, Wnc] = cheb1ord(wp, ws, rp, rs);
[bc, ac] = cheby1(nc, rp, Wnc);
figure;
freqz(bc, ac)
title('Chebyshev Type I Filter Response')
saveas(gcf, 'cheby1_response.jpg')
yc1 = filtfilt(bc, ac, noisy);
c1_err = mean(abs(yc1 - y))/mean(abs(y));
fprintf('Error after Chebyshev Type I Filtering: %4.4f\n', c1_err)
figure;
plot(t, yc1)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Chebyshev Type I Filtered Signal')
saveas(gcf, 'handel_cheby1.jpg')
yc1_fft = abs(fft(yc1));
figure;
plot(omega, yc1_fft)
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
title('FFT of Chebyshev Type I Filtered Signal')
saveas(gcf, 'handel_cheby1_fft.jpg')
%sound(yc1, Fs)
audiowrite('Handel_cheby1.wav', yc1, Fs)

% Cheby2
[nc2, Wnc2] = cheb2ord(wp, ws, rp, rs);
[bc2, ac2] = cheby2(nc2, rs, Wnc2);
figure;
freqz(bc2, ac2)
title('Chebyshev Type II Filter Response')
saveas(gcf, 'cheby2_response.jpg')
yc2 = filtfilt(bc2, ac2, noisy);
c2_err = mean(abs(yc2 - y))/mean(abs(y));
fprintf('Error after Chebyshev Type II Filtering: %4.4f\n', c2_err)
figure;
plot(t, yc2)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Chebyshev Type II Filtered Signal')
saveas(gcf, 'handel_cheby2.jpg')
yc2_fft = abs(fft(yc2));
figure;
plot(omega, yc2_fft)
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
title('FFT of Chebyshev Type II Filtered Signal')
saveas(gcf, 'handel_cheby2_fft.jpg')
%sound(yc2, Fs)
audiowrite('Handel_cheby2.wav', yc2, Fs)

% Ellipse
[ne, Wne] = ellipord(wp, ws, rp, rs);
[be, ae] = ellip(ne, rp, rs, Wne);
figure;
freqz(be, ae)
title('Ellipse Filter Response')
saveas(gcf, 'ellipse_response.jpg')
ye = filtfilt(be, ae, noisy);
e_err = mean(abs(ye - y))/mean(abs(y));
fprintf('Error after Elliptic Filtering: %4.4f\n', e_err)
figure;
plot(t, ye)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Ellipse Filtered Signal')
saveas(gcf, 'handel_ellipse.jpg')
ye_fft = abs(fft(ye));
figure;
plot(omega, ye_fft)
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
title('Ellipse Filtered Signal')
saveas(gcf, 'handel_Ellipse_fft.jpg')
%sound(ye, Fs)
audiowrite('Handel_ellipse.wav', ye, Fs)

% Impulse invariance
% Butterworth
fb = Wn * pi * Fs;
[bbc, abc] = butter(n, fb, 's');
[bbz, abz] = impinvar(bbc, abc, Fs);
figure;
freqz(bbz, abz)
title('Butter Impinvar')
saveas(gcf, 'Butter_response_impinvar.jpg')
ybz = filtfilt(bbz, abz, noisy);
but_erri = mean(abs(y - ybz) / mean(abs(y)));
fprintf('Butterworth Filter Error using impinvar: %4.4f\n', but_erri);
figure;
plot(t, ybz)
title('Butterworth impinvar')
xlabel('Time (seconds)')
ylabel('Magnitude')
saveas(gcf, 'Handel_but_impinvar.jpg')
figure;
plot(omega, abs(fft(ybz)))
title('FFT of Butterworth filtered signal using impinvar')
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
saveas(gcf, 'Handel_butt_impinvar_fft.jpg')
audiowrite('Handel_butt_impinvar.wav', ybz, Fs)

% Cheby1
fc1 = Wnc * pi * Fs;
[bc1c, ac1c] = cheby1(nc, rp, fc1, 's');
[bc1z, ac1z] = impinvar(bc1c, ac1c, Fs);
figure;
freqz(bc1z, ac1z)
title('Chebyshev I Impinvar')
saveas(gcf, 'cheby1_response_impinvar.jpg')
yc1z = filtfilt(bc1z, ac1z, noisy);
% figure;
% stem(n1, yc1z)
% title('Chebyshev I Filtered Discrete impinvar')
% saveas(gcf, 'cheby1_filtered_impinvar.jpg')
c1_erri = mean(abs(y - yc1z) / mean(abs(y)));
fprintf('Chebyshev I Filter Error using impinvar: %4.4f\n', c1_erri);
figure;
plot(t, yc1z)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Chebyshev I impinvar')
saveas(gcf, 'Handel_cheby1_impinvar.jpg')
figure;
plot(omega, abs(fft(yc1z)))
title('FFT of Chebyshev I filtered signal using impinvar')
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
saveas(gcf, 'Handel_cheby1_impinvar_fft.jpg')
audiowrite('Handel_cheby1_impinvar.wav', yc1z, Fs)

Cheby2
fc2 = Wnc2 * pi * Fs;
[bc2c, ac2c] = cheby2(nc2, rs, fc2, 's');
[bc2z, ac2z] = impinvar(bc2c, ac2c, Fs);
figure;
freqz(bc2z, ac2z)
title('Chebyshev II Impinvar')
saveas(gcf, 'cheby2_response_impinvar.jpg')
yc2z = filtfilt(bc2z, ac2z, noisy);
c2_erri = mean(abs(y - yc2z) / mean(abs(y)));
fprintf('Chebyshev II Filter Error using impinvar: %4.4f\n', c2_erri);
figure;
plot(t, yc2z)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Chebyshev II Filtered impinvar')
saveas(gcf, 'Handel_cheby2_impinvar.jpg')
figure;
plot(omega, abs(fft(yc2z)))
title('FFT of Chebyshev II filtered signal using impinvar')
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
saveas(gcf, 'Handel_cheby2_impinvar_fft.jpg')
audiowrite('Handel_cheby2_impinvar.wav', yc2, Fs)

% Ellipse
fe = Wne * pi * Fs;
[bec, aec] = ellip(ne, rp, rs, fe, 's');
[bez, aez] = impinvar(bec, aec, Fs);
figure;
freqz(bez, aez)
title('Ellipse Impinvar')
saveas(gcf, 'ellipse_response_impinvar.jpg')
yez = filtfilt(bez, aez, noisy);
e_erri = mean(abs(y - yez) / mean(abs(y)));
fprintf('Ellipse Filter Error using impinvar: %4.4f\n', e_erri);
figure;
plot(t, yez)
xlabel('Time (seconds)')
ylabel('Magnitude')
title('Ellipse impinvar')
saveas(gcf, 'Handel_ellipse_impinvar.jpg')
figure;
plot(omega, abs(fft(yez)))
title('FFT of Elipse filtered signal using impinvar')
xlabel('Normalized Frequency (x \pi rads/sample)')
ylabel('Magnitude')
saveas(gcf, 'Handel_ellipse_impinvar_fft.jpg')
audiowrite('Handel_ellipse_impinvar.wav', yez, Fs)

for i = [y, noisy, yb, ybz, yc1, yc1z, yc2, yc2z, ye, yez]
    sound(i, Fs)
    pause(10)
end


