function [ M, Omega ] = sensing(I, p)
    M = I;
    [n1,n2,n3]=size(M);
 
%采样数据总数
amount = fix(n1*n2*p);
sampledata = zeros(amount,3);
%随机生成采样点的坐标
for j=1:amount
    x = randi(n1,1,1);    
    y = randi(n2,1,1);        
    %取得的数据
    sampledata(j,:) = M(x,y,:);
    %在图上标注为白色
    M(x,y,:)=[255 255 255];
end
Omega = (M < 254);
end

