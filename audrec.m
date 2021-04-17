recObj = audiorecorder(44100, 16, 1);
disp('Start Speaking')
recordblocking(recObj, 5);
disp('Stop Speaking')

y = getaudiodata(recObj);
audiowrite('voicesample2.wav', y, recObj.SampleRate)
sound(y, recObj.SampleRate)
plot(y)
title('Voice Sample')
saveas(gcf, 'voice.jpg')
Y = fft(y);
figure;
plot(abs(Y))
title('FFT of Voice Sample')
saveas(gcf, 'voice_fft.jpg')