clc
clear
close all;


[X,Y]=meshgrid(1:256,1:256);

img=im2one(im2double(imread('Lena_256.bmp')));%����Ҫ���ܵ�ͼ
MMM=imread('Lena_256.bmp');
NNN=im2double(imread('Lena_256.bmp'));
% figure(10),
% imshow(uint8(MMM));

siz=size(img);
[a,b]=size(img);

%%-------------------------------------����Ϊ4��С���任����----------------------------------%%
[c1,s1]=wavedec2(img,4,'haar');
sre=c1;


% ca4=wcodemat(reshape(sre(1:256),[16,16]),255);%һ��Ϊ�ֱ���ȡ������������ʾ
% ch4=wcodemat(reshape(sre(257:512),[16,16]),255);
% cv4=wcodemat(reshape(sre(513:768),[16,16]),255);
% cd4=wcodemat(reshape(sre(769:1024),[16,16]),255);
% ch3=wcodemat(reshape(sre(1025:2048),[32,32]),255);
% cv3=wcodemat(reshape(sre(2049:3072),[32,32]),255);
% cd3=wcodemat(reshape(sre(3073:4096),[32,32]),255);
% ch2=wcodemat(reshape(sre(4097:8192),[64,64]),255);
% cv2=wcodemat(reshape(sre(8193:12288),[64,64]),255);
% cd2=wcodemat(reshape(sre(12289:16384),[64,64]),255);
% ch1=wcodemat(reshape(sre(16385:32768),[128,128]),255);
% cv1=wcodemat(reshape(sre(32769:49152),[128,128]),255);
% cd1=wcodemat(reshape(sre(49153:65536),[128,128]),255);
% imgdwt=([[[[ca4,ch4;cv4,cd4],ch3;cv3,cd3],ch2;cv2,cd2],ch1;cv1,cd1]);
% figure,imshow(uint8(imgdwt));imwrite(uint8(imgdwt),'.\encryptiondata\dwt.bmp')%��ʾС���任��ͼ�񣬲����

%%----------------------------------����Ϊϡ�軯����-------------------------------------------%%
pos=find(abs(sre)<0.085);    %�Ѿ���ֵС��0.085��ֵ������Ϊpos
sre(pos)=0;
iXSD=256*256-length(find(sre==0));%��ϡ���

%%--------------------------------����Ϊֱ�ӷ�С���任����--------------------------------------%%
ca4=wcodemat(reshape(sre(1:256),[16,16]),255);
ch4=wcodemat(reshape(sre(257:512),[16,16]),255);
cv4=wcodemat(reshape(sre(513:768),[16,16]),255);
cd4=wcodemat(reshape(sre(769:1024),[16,16]),255);
ch3=wcodemat(reshape(sre(1025:2048),[32,32]),255);
cv3=wcodemat(reshape(sre(2049:3072),[32,32]),255);
cd3=wcodemat(reshape(sre(3073:4096),[32,32]),255);
ch2=wcodemat(reshape(sre(4097:8192),[64,64]),255);
cv2=wcodemat(reshape(sre(8193:12288),[64,64]),255);
cd2=wcodemat(reshape(sre(12289:16384),[64,64]),255);
ch1=wcodemat(reshape(sre(16385:32768),[128,128]),255);
cv1=wcodemat(reshape(sre(32769:49152),[128,128]),255);
cd1=wcodemat(reshape(sre(49153:65536),[128,128]),255);
imgdwt=([[[[ca4,ch4;cv4,cd4],ch3;cv3,cd3],ch2;cv2,cd2],ch1;cv1,cd1]);
figure,imshow(uint8(imgdwt));title('ϡ�軯');imwrite(uint8(imgdwt),'.\encryptiondata\sparse.bmp')

%%----------------------------------���»ָ����Բ���-----------------------------------------%%
sre=reshape(sre,[256,256]);

% x=reshape(sre,[1,65536]);
% img1re=waverec2(x,s1,'haar');
% img1re=reshape(img1re,[a,b]);
% imgtre=im2one(img1re);
% figure,imshow(img1re),title('��ѹ��');

sre=arnold(sre,19,11,7);%arnold�����㷨������ƽ��ÿһ�е�ϡ���
figure,imshow(sre);imwrite(sre,'.\encryptiondata\arnoldsre.bmp')

%%----------------------------------����Ϊѹ������񲿷�-----------------------------------------%%

M=128;%%%%%%%%%%%%%%%%%%%%%%%�������Ը�

meas=rand(M,a);%/sqrt(a);%���������������
imwrite(meas,'.\encryptiondata\measurment.bmp')

y=meas*sre;%��������
guiyihuadey=im2one(y);
figure,imshow(guiyihuadey);

%%---------------------------------------����Ϊ��Կ������---------------------------------%%
%%�������ղ�ֵ�㷨�Ѿ���д��la6-n����
x1=rand(M,a);imwrite(x1,'.\encryptiondata\x1.bmp')%���������Ҫ��������󣬲�����
x2=rand(M,a);imwrite(x2,'.\encryptiondata\x2.bmp')
x3=rand(M,a);imwrite(x3,'.\encryptiondata\x3.bmp')
x4=rand(M,a);imwrite(x4,'.\encryptiondata\x4.bmp')
x5=rand(M,a);imwrite(x5,'.\encryptiondata\x5.bmp')
x6=rand(M,a);imwrite(x6,'.\encryptiondata\x6.bmp')
x7=rand(M,a);imwrite(x7,'.\encryptiondata\x7.bmp')
x8=rand(M,a);imwrite(x8,'.\encryptiondata\x8.bmp')
[fx1,fx2,fx3,fx4,fx5,fx6,fx7,fx8] =la6_n(meas,x1,x2,x3,x4,x5,x6,x7,x8);%����֪��Կfx�ַ���Կ
imwrite(fx1,'.\encryptiondata\fx1.bmp');imwrite(fx2,'.\encryptiondata\fx2.bmp');
imwrite(fx3,'.\encryptiondata\fx3.bmp');imwrite(fx4,'.\encryptiondata\fx4.bmp');
imwrite(fx5,'.\encryptiondata\fx5.bmp');imwrite(fx6,'.\encryptiondata\fx6.bmp');
imwrite(fx7,'.\encryptiondata\fx7.bmp');imwrite(fx8,'.\encryptiondata\fx8.bmp');


%%--------------------------------����Ϊ���ܲ���--------------------------------------------%%

%%%%����������Կ�ָ�����������
meas_re=ila6_n(x1,x2,x3,x4,x7,x6,fx1,fx2,fx3,fx4,fx7,fx6);%ila6-nΪ�������յĻָ���ʽ
imwrite(meas_re,'.\encryptiondata\measurment_re.bmp')

rec=zeros(a,b);
h=waitbar(0,'start');
for i=1:b
    waitbar(i/b,h,'compressive ghost imaging decrypting.....');%ѹ����֪�ָ�����OMP�㷨
   rec(:,i)=omp_sw(y(:,i),meas,a);

end
close(h);
imwrite(rec,'.\encryptiondata\arnold_re.bmp')
rec=iarnold(rec,19,11,7);%������
x=reshape(rec,[1,256*256]);
imgre=waverec2(x,s1,'haar');
imgre=reshape(imgre,[a,b]);
imgre=im2one(imgre);
figure,imshow(imgre),title('���ܳ�����ͼ��');
imwrite(imgre,'.\encryptiondata\imgre.bmp');
corr = corrcoef(double(imgre),double(img))


save '.\encryptiondata\ccout.mat' corr;

save .\encryptiondata\keydata  fx1 fx2 fx3 fx4 fx5 fx6 fx7 fx8 x1 x2 x3 x4 x5 x6 x7 x8;
save .\encryptiondata\ciphertext y;
save .\encryptiondata\others s1 img 


























