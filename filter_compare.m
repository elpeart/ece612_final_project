%pkg load signal % Octave only, comment out for Matlab
wp = 50/100;
ws = 60/100;
rp = 1;
rs = 100;
t = 0:0.005:1;
Fs = 200;

sig = cos(20*2*pi*t) + cos(30*2*pi*t) + cos(40*2*pi*t);
noise = cos(100*2*pi*t) + cos(80*2*pi*t);
figure;
plot(t, sig)
title('Original Signal')
saveas(gcf, 'original.jpg')
total = sig + noise;
figure;
plot(t, total)
title('Signal plus Noise')
saveas(gcf, 'with_noise.jpg')

n1 = 0:length(t)-1;
total_d = cos(20*2*pi*n1/Fs) + cos(30*2*pi*n1/Fs) + cos(40*2*pi*n1/Fs) + cos(100*2*pi*n1/Fs) + cos(80*2*pi*n1/Fs);
figure;
stem(n1, total_d)
title('Sampled Signal')
saveas(gcf, 'sampled.jpg')


[n, Wn] = buttord(wp, ws, rp, rs);
[b, a] = butter(n, Wn);
figure;
freqz(b, a)
title('Butter')
saveas(gcf, 'Butter_response.jpg')
yb = filtfilt(b, a, total_d);
figure;
stem(n1, yb)
title('Butterworth Filtered Discrete')
saveas(gcf, 'butter_filtered.jpg')
but_err = mean(abs(sig - yb) / mean(abs(sig)));
fprintf('Butterworth Filter Error: %4.4f\n', but_err);
figure;
plot(t, yb)
title('Butterworth Continuous')
saveas(gcf, 'but_cont.jpg')

[nc, Wnc] = cheb1ord(wp, ws, rp, rs);
[bc, ac] = cheby1(nc, rp, Wnc);
figure;
freqz(bc, ac)
title('cheby1')
saveas(gcf, 'cheby1_response.jpg')
figure;
yc1 = filtfilt(bc, ac, total_d);
stem(n1, yc1)
title('Cheby1 filtered')
saveas(gcf, 'cheby1_filt.jpg')
c1_err = mean(abs(sig - yc1) / mean(abs(sig)));
fprintf('Chebyshev Type I Filter Error: %4.4f\n', c1_err);
figure;
plot(t, yc1)
title('Chebyshev I continuous')
saveas(gcf, 'cheby1_cont.jpg')

[nc2, Wnc2] = cheb2ord(wp, ws, rp, rs);
[bc2, ac2] = cheby2(nc2, rs, Wnc2);
figure;
freqz(bc2, ac2)
title('cheby2')
saveas(gcf, 'cheby2_response.jpg')
figure;
yc2 = filtfilt(bc2, ac2, total_d);
stem(n1, yc2)
title('Cheby2 filtered')
saveas(gcf, 'cheby2_filt.jpg')
c2_err = mean(abs(sig - yc2) / mean(abs(sig)));
fprintf('Chebyshev Type II Filter Error: %4.4f\n', c2_err);
figure;
plot(t, yc2)
title('Chebyshev II continuous')
saveas(gcf, 'cheby2_cont.jpg')

[ne, Wne] = ellipord(wp, ws, rp, rs);
[be, ae] = ellip(ne, rp, rs, Wne);
figure;
freqz(be, ae)
title('ellipse')
saveas(gcf, 'ellipse_response.jpg')
figure;
ye = filtfilt(be, ae, total_d);
stem(n1, ye)
title('Ellipse filtered')
saveas(gcf, 'ellipse_filt.jpg')
e_err = mean(abs(sig - ye) / mean(abs(sig)));
fprintf('Ellipse Filter Error: %4.4f\n', e_err);
figure;
plot(t, ye)
title('Ellipse continuous')
saveas(gcf, 'e_cont.jpg')

fb = Wn * pi * Fs;
[bbc, abc] = butter(9, fb, 's');
[bbz, abz] = impinvar(bbc, abc, Fs);
figure;
freqz(bbz, abz)
title('Butter Impinvar')
saveas(gcf, 'Butter_response_impinvar.jpg')
ybz = filtfilt(bbz, abz, total_d);
figure;
stem(n1, ybz)
title('Butterworth Filtered Discrete impinvar')
saveas(gcf, 'butter_filtered_impinvar.jpg')
but_erri = mean(abs(sig - ybz) / mean(abs(sig)));
fprintf('Butterworth Filter Error using impinvar: %4.4f\n', but_erri);
figure;
plot(t, ybz)
title('Butterworth Continuous impinvar')
saveas(gcf, 'but_cont_impinvar.jpg')

fc1 = Wnc * pi * Fs;
[bc1c, ac1c] = cheby1(nc, rp, fc1, 's');
[bc1z, ac1z] = impinvar(bc1c, ac1c, Fs);
figure;
freqz(bc1z, ac1z)
title('Chebyshev I Impinvar')
saveas(gcf, 'cheby1_response_impinvar.jpg')
yc1z = filtfilt(bc1z, ac1z, total_d);
figure;
stem(n1, yc1z)
title('Chebyshev I Filtered Discrete impinvar')
saveas(gcf, 'cheby1_filtered_impinvar.jpg')
c1_erri = mean(abs(sig - yc1z) / mean(abs(sig)));
fprintf('Chebyshev I Filter Error using impinvar: %4.4f\n', c1_erri);
figure;
plot(t, yc1z)
title('Chebyshev I Continuous impinvar')
saveas(gcf, 'cheby1_cont_impinvar.jpg')

fc2 = Wnc2 * pi * Fs;
[bc2c, ac2c] = cheby2(9, rs, fc2, 's');
[bc2z, ac2z] = impinvar(bc2c, ac2c, Fs);
figure;
freqz(bc2z, ac2z)
title('Chebyshev II Impinvar')
saveas(gcf, 'cheby2_response_impinvar.jpg')
yc2z = filtfilt(bc2z, ac2z, total_d);
figure;
stem(n1, yc2z)
title('Chebyshev II Filtered Discrete impinvar')
saveas(gcf, 'cheby2_filtered_impinvar.jpg')
c2_erri = mean(abs(sig - yc2z) / mean(abs(sig)));
fprintf('Chebyshev II Filter Error using impinvar: %4.4f\n', c2_erri);
figure;
plot(t, yc2z)
title('Chebyshev II Continuous impinvar')
saveas(gcf, 'cheby2_cont_impinvar.jpg')

fe = Wne * pi * Fs;
[bec, aec] = ellip(ne, rp, rs, fe, 's');
[bez, aez] = impinvar(bec, aec, Fs);
figure;
freqz(bez, aez)
title('Ellipse Impinvar')
saveas(gcf, 'ellipse_response_impinvar.jpg')
yez = filtfilt(bez, aez, total_d);
figure;
stem(n1, yez)
title('Ellipse Filtered Discrete impinvar')
saveas(gcf, 'ellipse_filtered_impinvar.jpg')
e_erri = mean(abs(sig - yez) / mean(abs(sig)));
fprintf('Ellipse Filter Error using impinvar: %4.4f\n', e_erri);
figure;
plot(t, yez)
title('Ellipse Continuous impinvar')
saveas(gcf, 'ellipse_cont_impinvar.jpg')