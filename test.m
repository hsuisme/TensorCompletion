clc;
clear;
close all;

pic_name = [ 'data/peppers.png'];
I = double(imread(pic_name));
X = I/255;

p = 0.1;
[M, Omega ] = sensing (I, p );


% maxP = max(abs(X(:)));
% Omega = rand(n1*n2*n3,1)<p;
% omega = find(Omega);
% M = zeros(n1,n2,n3);
% M(omega) = X(omega);

alpha = [1, 1, 1e-3];
alpha = alpha / sum(alpha);


 %% test lrtc_snn 

opts.mu = 1e-3;
opts.tol = 1e-6;
opts.rho = 1.2;
opts.max_iter = 500;
opts.DEBUG = 1;

[Xhat,err,iter] = lrtc_snn(M,Omega,alpha,opts);
% [Xhat,err,iter] = lrtc_tnn(M,omega,opts);

err
iter
 
% Xhat = max(Xhat,0);
% Xhat = min(Xhat,maxP);
% RSE = norm(X(:)-Xhat(:))/norm(X(:))
% psnr = PSNR(X,Xhat,maxP)



%% HaLRTC

maxIter = 500;
epsilon = 1e-5;
rho = 1e-6;

[X_H, errList_H] = HaLRTC(...
    M, ...                       % a tensor whose elements in Omega are used for estimating missing value
    Omega,...               % the index set indicating the obeserved elements
    alpha,...                  % the coefficient of the objective function, i.e., \|X\|_* := \alpha_i \|X_{i(i)}\|_* 
    rho,...                      % the initial value of the parameter; it should be small enough  
    maxIter,...               % the maximum iterations
    epsilon...                 % the tolerance of the relative difference of outputs of two neighbor iterations 
    );



%% TMac




%% show
figure(1)
subplot(2,3,1)
imshow(X,[])
title('Original')
subplot(2,3,2)
imshow(uint8(M))
title('Missing Values')
subplot(2,3,3)
imshow(uint8(Xhat))
title('LRTC_snn')
subplot(2,3,4)
imshow(uint8(X_H))
title('HaLRTC')

