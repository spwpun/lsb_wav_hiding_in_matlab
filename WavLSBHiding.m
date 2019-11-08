function [wav_out] = WavLSBHiding(wav_in,msg)
%wav_in:������Ϣ����Ƶ�ļ�����wav��ʽ���ַ���
%msg�����ص���Ϣ���ַ���
%wav_out������֮�����Ƶ����
%fs:����Ĳ�����
size_data = prod(size(wav_in));
sign_m = sign(wav_in);     %�����ŵı���
wav_int16 = uint16(abs(wav_in)*(2^15));    %ȡ����ֵ,����2^15��ת��int16
[bin_str, len_str, len] = str2bi(msg);  %�Զ���ĺ���
wav_tmp = wav_int16;
%������Ϣ����
if size_data < 7*(len+1)
    fprintf('The message size must be less than %d bits.\n', size_data);
    error('The message is too long!\n');
end
i = 1;
j = 1;
%i��Ƕ����Ϣ��������j��wav���ݵ�����
while i <= 7*(len+1) 
    if wav_int16(j) >= 2  %�ж�wav�����Ƿ�>=2,�����0������1�Ļ���Ƕ�����Ϣ���ܻ�ʧ��
        if i <= 7
            wav_tmp(j) = bitset(wav_int16(j), 1, len_str(i));     %ǰ7λǶ�볤����Ϣ            
        else
            wav_tmp(j) = bitset(wav_int16(j), 1, bin_str(i-7));   %����Ƕ����Ϣ
        end
        i = i + 1;
    end
    j = j + 1;
end
wav_tmp = double(wav_tmp)/(2^15);   %ת��Ϊdouble��
wav_out = wav_tmp.*sign_m;    %����Ϣ���������ŵľ���
end

function [bin_str, len_str,len] = str2bi(msg)
%���ַ���ת��Ϊ����������
len = length(msg);
msg_ascii = double(msg);
bin_str = de2bi(msg_ascii, 7, 2);
bin_str = bin_str';
len_str = de2bi(len, 7,2);
end