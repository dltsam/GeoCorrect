
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[x,y,X,Y]=textread("控制点.txt",'%f %f %f %f');
[m,n]=size(x);
%系数矩阵
A=[ones(m,1),X,Y];
B=[ones(m,1),x,y];
%计算多项式系数
Da=((A'*A)^-1)*A'*x;
Db=((A'*A)^-1)*A'*y;
Da_1=((B'*B)^-1)*B'*X;
Db_1=((B'*B)^-1)*B'*Y;
img=imread("待纠正图像.bmp");
[m,n,~]=size(img);
X1=Da_1'*[1;0;0];
X2=Da_1'*[1;0;m];
X3=Da_1'*[1;n;0];
X4=Da_1'*[1;n;m];
Y1=Db_1'*[1;0;0];
Y2=Db_1'*[1;0;m];
Y3=Db_1'*[1;n;0];
Y4=Db_1'*[1;n;m];
X=[X1,X2,X3,X4];
Y=[Y1,Y2,Y3,Y4];
Xmax=max(X);
Xmin=min(X);
Ymax=max(Y);
Ymin=min(Y);
M=ceil(Ymax-Ymin)+1;
N=ceil(Xmax-Xmin)+1;
img=double(img);
for a=1:M
    for b=1:N
        Xp=Xmin+(b-1);
        Yp=Ymin+(a-1);
        xp=Da'*[1;Xp;Yp];
        yp=Db'*[1;Xp;Yp];
        i=ceil(xp+0.5);
        j=ceil(yp+0.5);  
        for k=1:3
            if i>1&&i<n&&j>1&&j<m
                if rem(yp,1)~=0 && rem(xp,1)~=0
                    p=img(j,i,k);
                end
            else
                p=0;
            end
            img2(a,b,k)=p;
        end         
    end
end
img2=uint8(img2);   
img=uint8(img);
imwrite(img2,'纠正图像.bmp');
img1=imread('参考图像.bmp');
subplot(1,3,1);imshow(img);title('源图像');
subplot(1,3,2);imshow(img1);title('参考图像');
subplot(1,3,3);imshow(img2);title('纠正图像');

    
%plot(x,y,'o');

