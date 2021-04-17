[y, Fs] = audioread('voicesample2.wav');

noise = 1/20 * wgn(length(y), 1, 0.1);
wp = .2;
ws = .1;
rp = 1;
rs = 100;
[n, Wn] = buttord(wp, ws, rp, rs);
[b, a] = butter(n, Wn, 'high');
figure;
freqz(b, a)
title('Butter')
noise = filter(b, a, noise);
figure;
plot(noise)
figure;
plot(abs(fft(noise)))
title('FFT of Noise')
saveas(gcf, 'noise_fft_voice.jpg')
figure;
noisy_voice = y + noise;
plot(noisy_voice)
title('Voice plus Noise')
figure;
plot(abs(fft(noisy_voice)))
title('FFT of Voice Sample Plus Noise')
%sound(noisy_voice, Fs)

[b, a] = butter(n, Wn);
voice_f = filter(b, a, noisy_voice);
figure;
plot(voice_f)
title('Filtered Voice Sample')
figure;
plot(abs(fft(voice_f)))
sound(voice_f, Fs);
