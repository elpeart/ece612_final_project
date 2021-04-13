<<<<<<< HEAD
%pkg load signal % Octave only, comment out for Matlab
wp = 40/100;
ws = 60/100;
=======
pkg load signal % Octave only comment out for MATLAB
wp = [0.3 0.5];
ws = [0.2 0.6];
>>>>>>> 108b1d54b29c60004ec40dc27a44045cfb3c42c6
rp = 1;
rs = 100;
t = 0:0.005:1;
Fs = 200;

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
<<<<<<< HEAD
saveas(gcf, 'Butter_response.jpg')
yb = filter(b, a, total_d);
stem(n1, yb)
title('Butterworth Filtered Discrete')
saveas(gcf, 'butter_filtered.jpg')
=======
saveas(gcf, 'Butter.jpg')
>>>>>>> 108b1d54b29c60004ec40dc27a44045cfb3c42c6

[nc, Wnc] = cheb1ord(wp, ws, rp, rs);
[bc, ac] = cheby1(nc, rp, Wnc);
figure;
freqz(bc, ac)
title('cheby1')
<<<<<<< HEAD
saveas(gcf, 'cheby1_response.jpg')
yc1 = filter(bc, ac, total_d);
stem(n1, yc1)
title('Cheby1 filtered')
saveas(gcf, 'cheby1_filt.jpg')
=======
saveas(gcf, 'cheby1.jpg')
>>>>>>> 108b1d54b29c60004ec40dc27a44045cfb3c42c6

[nc2, Wnc2] = cheb2ord(wp, ws, rp, rs);
[bc2, ac2] = cheby1(nc2, rs, Wnc2);
figure;
freqz(bc2, ac2)
title('cheby2')
<<<<<<< HEAD
saveas(gcf, 'cheby2_response.jpg')
yc2 = filter(bc2, ac2, total_d);
stem(n1, yc2)
title('Cheby2 filtered')
saveas(gcf, 'cheby2_filt.jpg')
=======
saveas(gcf, 'cheby2.jpg')
>>>>>>> 108b1d54b29c60004ec40dc27a44045cfb3c42c6

[ne, Wne] = ellipord(wp, ws, rp, rs);
[be, ae] = ellip(ne, rp, rs, Wne);
figure;
freqz(be, ae)
title('ellipse')
<<<<<<< HEAD
saveas(gcf, 'ellipse_response.jpg')
ye = filter(be, ae, total_d);
stem(n1, yc1)
title('Ellipse filtered')
saveas(gcf, 'ellipse_filt.jpg')
=======
saveas(gcf, 'ellipse.jpg')
>>>>>>> 108b1d54b29c60004ec40dc27a44045cfb3c42c6
