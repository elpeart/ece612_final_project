pkg load signal % Octave only, comment out for Matlab
wp = 40/100;
ws = 60/100;
rp = 1;
rs = 100;
t = 0:0.005:1;
Fs = 250

sig = cos(30*2*pi*t) + cos(40*2*pi*t);
noise = cos(100*2*pi*t);
figure;
plot(t, sig)
title('Original Signal')
saveas(gcf, 'original.jpg')
total = sig + noise;
figure;
plot(t, total)
title('Signal plus Noise')
saveas(gcf, 'with_noise.jpg')

n1 = t*Fs;
total_d = cos(30*2*pi*n1) + cos(40*2*pi*n1) + cos(100*2*pi*n1);
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
yb = filter(b, a, total_d);
figure;
stem(n1, yb)
title('Butterworth Filtered Discrete')
saveas(gcf, 'butter_filtered.jpg')

[nc, Wnc] = cheb1ord(wp, ws, rp, rs);
[bc, ac] = cheby1(nc, rp, Wnc);
figure;
freqz(bc, ac)
title('cheby1')
saveas(gcf, 'cheby1_response.jpg')
figure;
yc1 = filter(bc, ac, total_d);
stem(n1, yc1)
title('Cheby1 filtered')
saveas(gcf, 'cheby1_filt.jpg')

[nc2, Wnc2] = cheb2ord(wp, ws, rp, rs);
[bc2, ac2] = cheby1(nc2, rs, Wnc2);
figure;
freqz(bc2, ac2)
title('cheby2')
saveas(gcf, 'cheby2_response.jpg')
figure;
yc2 = filter(bc2, ac2, total_d);
stem(n1, yc2)
title('Cheby2 filtered')
saveas(gcf, 'cheby2_filt.jpg')

[ne, Wne] = ellipord(wp, ws, rp, rs);
[be, ae] = ellip(ne, rp, rs, Wne);
figure;
freqz(be, ae)
title('ellipse')
saveas(gcf, 'ellipse_response.jpg')
figure;
ye = filter(be, ae, total_d);
stem(n1, yc1)
title('Ellipse filtered')
saveas(gcf, 'ellipse_filt.jpg')
