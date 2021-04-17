recObj = audiorecorder;
disp('Start Speaking')
recordblocking(recObj, 5);
disp('Stop Speaking')

y = getaudiodata(recObj);
plot(y)
Y = fft(y);
plot(abs(Y))