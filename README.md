
# PROJECT NAME

基于压缩感知和密钥分发的光学图像加密处理

#### Introduction

- 应用在光学4f系统（菲涅尔改进系统）中的压缩感知算法。光学系统用于图像的传输通信，压缩感知算法在其中做图像加密。

#### Revolve Algorithm

- 2D-Wavelet;
- CS-Sparse sampling;
- Lagrange Interpolation Polynomial;
- Arnold;
- Orthogonal Matching Pursuit(OMP);

#### Sources directory

    Sources.encryptiondata/
            arnold.m
            drawline.m
            encryption.m
            iarnold.m
            ila6_n.m
            im2one.m
            la6_n.m
            omp_sw.m
            Lena_256.bmp    
            ...

#### Run

- 运行 "encryption.m" 就可以执行从加密至解密全过程。图片将被保存在encryptiondata目录下
- 如果运行报错，请先创建空文件夹encryption