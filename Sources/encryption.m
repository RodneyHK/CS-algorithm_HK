clc
clear
close all;


[X,Y]=meshgrid(1:256,1:256);

img=im2one(im2double(imread('Lena_256.bmp')));%读入要加密的图
MMM=imread('Lena_256.bmp');
NNN=im2double(imread('Lena_256.bmp'));
% figure(10),
% imshow(uint8(MMM));

siz=size(img);
[a,b]=size(img);

%%-------------------------------------以下为4级小波变换部分----------------------------------%%
[c1,s1]=wavedec2(img,4,'haar');
sre=c1;


% ca4=wcodemat(reshape(sre(1:256),[16,16]),255);%一下为分别提取各级分量并显示
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
% figure,imshow(uint8(imgdwt));imwrite(uint8(imgdwt),'.\encryptiondata\dwt.bmp')%显示小波变换后图像，并输出

%%----------------------------------以下为稀疏化部分-------------------------------------------%%
pos=find(abs(sre)<0.085);    %把绝对值小于0.085的值都命名为pos
sre(pos)=0;
iXSD=256*256-length(find(sre==0));%求稀疏度

%%--------------------------------以下为直接反小波变换测试--------------------------------------%%
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
figure,imshow(uint8(imgdwt));title('稀疏化');imwrite(uint8(imgdwt),'.\encryptiondata\sparse.bmp')

%%----------------------------------以下恢复测试部分-----------------------------------------%%
sre=reshape(sre,[256,256]);

% x=reshape(sre,[1,65536]);
% img1re=waverec2(x,s1,'haar');
% img1re=reshape(img1re,[a,b]);
% imgtre=im2one(img1re);
% figure,imshow(img1re),title('不压缩');

sre=arnold(sre,19,11,7);%arnold置乱算法，用于平均每一行的稀疏度
figure,imshow(sre);imwrite(sre,'.\encryptiondata\arnoldsre.bmp')

%%----------------------------------以下为压缩鬼成像部分-----------------------------------------%%

M=128;%%%%%%%%%%%%%%%%%%%%%%%参数可以改

meas=rand(M,a);%/sqrt(a);%生成随机测量矩阵
imwrite(meas,'.\encryptiondata\measurment.bmp')

y=meas*sre;%测量过程
guiyihuadey=im2one(y);
figure,imshow(guiyihuadey);

%%---------------------------------------以下为秘钥分享部分---------------------------------%%
%%拉格朗日差值算法已经被写入la6-n函数
x1=rand(M,a);imwrite(x1,'.\encryptiondata\x1.bmp')%随机生成需要的随机矩阵，并保存
x2=rand(M,a);imwrite(x2,'.\encryptiondata\x2.bmp')
x3=rand(M,a);imwrite(x3,'.\encryptiondata\x3.bmp')
x4=rand(M,a);imwrite(x4,'.\encryptiondata\x4.bmp')
x5=rand(M,a);imwrite(x5,'.\encryptiondata\x5.bmp')
x6=rand(M,a);imwrite(x6,'.\encryptiondata\x6.bmp')
x7=rand(M,a);imwrite(x7,'.\encryptiondata\x7.bmp')
x8=rand(M,a);imwrite(x8,'.\encryptiondata\x8.bmp')
[fx1,fx2,fx3,fx4,fx5,fx6,fx7,fx8] =la6_n(meas,x1,x2,x3,x4,x5,x6,x7,x8);%由已知秘钥fx分发秘钥
imwrite(fx1,'.\encryptiondata\fx1.bmp');imwrite(fx2,'.\encryptiondata\fx2.bmp');
imwrite(fx3,'.\encryptiondata\fx3.bmp');imwrite(fx4,'.\encryptiondata\fx4.bmp');
imwrite(fx5,'.\encryptiondata\fx5.bmp');imwrite(fx6,'.\encryptiondata\fx6.bmp');
imwrite(fx7,'.\encryptiondata\fx7.bmp');imwrite(fx8,'.\encryptiondata\fx8.bmp');


%%--------------------------------以下为解密部分--------------------------------------------%%

%%%%首先由子秘钥恢复出测量矩阵
meas_re=ila6_n(x1,x2,x3,x4,x7,x6,fx1,fx2,fx3,fx4,fx7,fx6);%ila6-n为拉格朗日的恢复公式
imwrite(meas_re,'.\encryptiondata\measurment_re.bmp')

rec=zeros(a,b);
h=waitbar(0,'start');
for i=1:b
    waitbar(i/b,h,'compressive ghost imaging decrypting.....');%压缩感知恢复过程OMP算法
   rec(:,i)=omp_sw(y(:,i),meas,a);

end
close(h);
imwrite(rec,'.\encryptiondata\arnold_re.bmp')
rec=iarnold(rec,19,11,7);%反置乱
x=reshape(rec,[1,256*256]);
imgre=waverec2(x,s1,'haar');
imgre=reshape(imgre,[a,b]);
imgre=im2one(imgre);
figure,imshow(imgre),title('解密出的总图像');
imwrite(imgre,'.\encryptiondata\imgre.bmp');
corr = corrcoef(double(imgre),double(img))


save '.\encryptiondata\ccout.mat' corr;

save .\encryptiondata\keydata  fx1 fx2 fx3 fx4 fx5 fx6 fx7 fx8 x1 x2 x3 x4 x5 x6 x7 x8;
save .\encryptiondata\ciphertext y;
save .\encryptiondata\others s1 img 


























