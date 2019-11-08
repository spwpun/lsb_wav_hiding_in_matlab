function [msg] = WavLSBExtract(wav_steg)
%wav_steg:������Ϣ��wav����
%msg:�ָ���������Ϣ
wav_int16 = uint16(abs(wav_steg)*(2^15));
%�ָ���������
len = zeros(1,7);
i = 1;
j = 1;
%��ȡ����
while i <= 7
    if wav_int16(j) >= 2
        len(i) = bitget(wav_int16(j), 1); %��ȡ������Ϣ
        i = i + 1;
    end
    j = j + 1;
end
len = bi2de(len);
msg = zeros(7, len);
%��ȡ��Ϣ
while i <= 7*(len+1)
    if wav_int16(j) >= 2
        msg(i-7) = bitget(wav_int16(j),1);    %��ȡ��Ϣ
        i = i + 1;
    end
    j = j + 1;
end
%����������Ϣת��Ϊ�ַ���
msg_ascii = bi2de(msg');
msg = char(msg_ascii);
msg = msg'; %ת��ʹ�������
end