function [wav_out] = WavLSBHiding(wav_in,msg)
%wav_in:隐藏信息的音频文件名，wav格式，字符串
%msg：隐藏的信息，字符串
%wav_out：隐藏之后的音频数据
%fs:输出的采样率
size_data = prod(size(wav_in));
sign_m = sign(wav_in);     %正负号的保存
wav_int16 = uint16(abs(wav_in)*(2^15));    %取绝对值,乘以2^15，转成int16
[bin_str, len_str, len] = str2bi(msg);  %自定义的函数
wav_tmp = wav_int16;
%错误信息处理
if size_data < 7*(len+1)
    fprintf('The message size must be less than %d bits.\n', size_data);
    error('The message is too long!\n');
end
i = 1;
j = 1;
%i是嵌入信息的索引，j是wav数据的索引
while i <= 7*(len+1) 
    if wav_int16(j) >= 2  %判断wav数据是否>=2,如果是0或者是1的话，嵌入的信息可能会失真
        if i <= 7
            wav_tmp(j) = bitset(wav_int16(j), 1, len_str(i));     %前7位嵌入长度信息            
        else
            wav_tmp(j) = bitset(wav_int16(j), 1, bin_str(i-7));   %后续嵌入消息
        end
        i = i + 1;
    end
    j = j + 1;
end
wav_tmp = double(wav_tmp)/(2^15);   %转换为double型
wav_out = wav_tmp.*sign_m;    %将信息乘以正负号的矩阵
end

function [bin_str, len_str,len] = str2bi(msg)
%将字符串转换为二进制数据
len = length(msg);
msg_ascii = double(msg);
bin_str = de2bi(msg_ascii, 7, 2);
bin_str = bin_str';
len_str = de2bi(len, 7,2);
end