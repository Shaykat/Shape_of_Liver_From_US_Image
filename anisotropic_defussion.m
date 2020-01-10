% I = imread("baby1.jpeg");
% I = imread("baby2.jpg");
% I = imread("liver_model.jpg");
I = imread("test3.jpeg");


% figure;
% imshow(I);

I_G = rgb2gray(I);

% figure;
% imshowpair(I, I_G, "montage");

% I_G_BN = imbinarize(I_G);
% I_I_G_BN = ~I_G_BN;

% imhist(I_G_BN);
% figure;
% imhist(I_G_BN);

% figure;
% imshowpair(I_G_BN, I_I_G_BN, "montage");

% Anisotropic Defussion 
diffusedImage = imdiffusefilt(I_G);

nB = ssim(I_G,diffusedImage);
disp(['The SSIM value using default anisotropic diffusion is ',num2str(nB),'.'])

figure;
imshowpair(I_G, diffusedImage, "montage");


[gradThresh,numIter] = imdiffuseest(I_G,'ConductionMethod','quadratic');
c_diffusedImage = imdiffusefilt(I_G,'ConductionMethod','quadratic','GradientThreshold',gradThresh,'NumberOfIterations',numIter);

c_nB = ssim(I_G,c_diffusedImage);
disp(['The SSIM value using default anisotropic diffusion is ',num2str(c_nB),'.'])

figure;
imshowpair(I_G, c_diffusedImage, "montage");
