[x,y,X,Y]=textread('¿ØÖÆµã.txt','%f %f %f %f');
[m,~]=size(x);
A=[ones(m,1),X,Y];
B=[ones(m,1),x,y];
Da_x=((A'*A)^-1)*A'*x;
Da_y=((A'*A)^-1)*A'*y;
Db_X=((B'*B)^-1)*B'*X;
Db_Y=((B'*B)^-1)*B'*Y;
img=imread('´ı¾ÀÕıÍ¼Ïñ.bmp');
[m,n,~]=size(img);
X1=Db_X'*[1;0;0];
X2=Db_X'*[1;n;0];
X3=Db_X'*[1;n;m];
X4=Db_X'*[1;0;m];
Y1=Db_Y'*[1;0;0];
Y2=Db_Y'*[1;n;0];
Y3=Db_Y'*[1;n;m];
Y4=Db_Y'*[1;0;m];
X=[X1,X2,X3,X4];Y=[Y1,Y2,Y3,Y4];
Xmax=max(X);Xmin=min(X);Ymax=max(Y);Ymin=min(Y);
M=ceil(Ymax-Ymin)+1;
N=ceil(Xmax-Xmin)+1;
img=double(img);
for a=1:M
    for b=1:N
        Xp=Xmin+(b-1);
        Yp=Ymin+(a-1);
        xp=Da_x'*[1;Xp;Yp];
        yp=Da_y'*[1;Xp;Yp];
       for k=1:3
        if xp>1&&xp<n&&yp>1&&yp<m
            if rem(xp,1)~=0 ||rem(yp,1)~=0
                xp=ceil(xp+0.5);yp=ceil(yp+0.5);
                if xp>n ;xp=n; end
                if yp>m;yp=m;end
            end
                imgout(a,b,k)=img(yp,xp,k);
        else imgout(a,b,k)=0;
        end
       end
    end
end
imgout=uint8(imgout);
img=uint8(img);
img2=imread('²Î¿¼Í¼Ïñ.bmp');
imwrite(imgout,'¾ÀÕıºóÍ¼Ïñ.bmp');
subplot(1,3,3);imshow(imgout);title('¾ÀÕıºóÍ¼Ïñ');
subplot(1,3,1);imshow(img);title('Ô´Í¼Ïñ');
subplot(1,3,2);imshow(img2);title('²Î¿¼Í¼Ïñ');
        
                
