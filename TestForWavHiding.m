clear;
[wav, Fs] = audioread('conan.wav');
msg = 'Ren sir is an inspiring teacher!';
wav2 = WavLSBHiding(wav, msg);
subplot(2,1,1);plot(wav(1:4500,1));title('The On');
subplot(2,1,2);plot(wav2(1:4500,1));title('The Steg');
sound(wav2, Fs);
audiowrite('Steg.wav', wav2, Fs);  %Ð´ÈëÎÄ¼þ
prompt = 'Press B to Break playing:';
Break = input(prompt, 's');
if Break == 'B'
    clear sound
end
prompt = 'Continue to extract?[y/n]';
extract = input(prompt, 's');
if extract == 'y'
    msg_extract = WavLSBExtract(wav2);
    fprintf('The extarct message is :%s\n', msg_extract);
end