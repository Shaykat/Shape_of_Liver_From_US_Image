img_name = "test3.jpeg";
clean_img_name = "clean_image.png";

I = imread(img_name);

% I_M = imread("edge.png");
% I_M_I = ~I_M;
% figure;
% imshow(I_M_I);

clean_img = imread(clean_img_name);

I_G = rgb2gray(I);
clean_img_n = rgb2gray(clean_img);

% Call Sticks Line to get the enhanced Image
new_I_G = sticks_line(I_G);

% dilation
BN_new_I_G = imbinarize(new_I_G);
se = strel('line',11,60);
BN_new_I_G_D = imdilate(BN_new_I_G,se);
BN_new_I_G_D_1 = imdilate(~BN_new_I_G_D,se);
BN_new_I_G_D_2 = imdilate(BN_new_I_G_D_1,se);

% Show Clean Image
figure;
subplot(1,2,1)
imshow(I_G,[])
title('Original image')
subplot(1,2,2)
imshow(new_I_G,[])
title('Enhanced image')

% Save the new Enhanced Image
imwrite(new_I_G, 'clean_' + img_name);
% actual_shape_edge_n

% find the thresold 
% sum_of_pix = 0;
% for j=1:256
%     sum_of_pix = sum_of_pix + (j-1)*counts(j);
% end


% edge points ploting
figure;
[max_boundary, L, Iedg] = get_interest_object_bounday(new_I_G);
% plot(max_boundary(:,2), max_boundary(:,1)*-1, 'black', 'LineWidth', 1);
imshow(Iedg);

%Hough Transform
[score,  y, x ] = Generalized_Hough_Transform(Iedg); 

