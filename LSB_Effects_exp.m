value = [0 0 0];
wav2 = int16(ones(10381296,2));
wav4 = int16(ones(10381296,2));
%for i = 1:5000
 %   wav2(i) = bitset(wav(i), 1:3, value);
  %  wav4(i) = bitset(wav(i), 4:6, value);
%end
wav2 = bitset(wav,1, 0);
%wav2 = bitset(wav2, 2, 0);
%wav2 = bitset(wav2, 3, 0);
wav4 = bitset(wav,4);
len = 6500;
subplot(3, 1, 1); plot(wav(1:len)); title('origin audio');
subplot(3, 1, 2); plot(wav2(1:len)); title('discard the lowest 1-3 bits');
audiowrite('out1.wav', wav2, fs);
subplot(3, 1, 3); plot(wav4(1:len)); title('discard the 4-6 bits');
audiowrite('out2.wav', wav4, fs);