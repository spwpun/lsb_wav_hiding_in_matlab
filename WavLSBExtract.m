function [msg] = WavLSBExtract(wav_steg)
%wav_steg:隐藏信息的wav数据
%msg:恢复出来的信息
wav_int16 = uint16(abs(wav_steg)*(2^15));
%恢复长度数据
len = zeros(1,7);
i = 1;
j = 1;
%提取长度
while i <= 7
    if wav_int16(j) >= 2
        len(i) = bitget(wav_int16(j), 1); %提取长度信息
        i = i + 1;
    end
    j = j + 1;
end
len = bi2de(len);
msg = zeros(7, len);
%提取消息
while i <= 7*(len+1)
    if wav_int16(j) >= 2
        msg(i-7) = bitget(wav_int16(j),1);    %提取消息
        i = i + 1;
    end
    j = j + 1;
end
%将二进制消息转换为字符串
msg_ascii = bi2de(msg');
msg = char(msg_ascii);
msg = msg'; %转置使横向输出
end