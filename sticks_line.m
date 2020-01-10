function [new_I_G] = sticks_line(I_G)
%   STICKS_LINE Summary of this function goes here
%   Detailed explanation goes here

%   allocate space for thresholded image
    new_I_G = zeros(size(I_G));    
    row = size(I_G,1);
    colomn = size(I_G,2);
    max_list = zeros(1,100000);
    i = 1;
    for ii=2:row-1
       for jj=2:colomn-1
           % get pixel value
%            pixel = zeros(1,11);
%            temp_list = zeros(1,5);
%            pixel(1)=I_G(ii,jj);
%            pixel(2)=I_G(ii-1,jj-1);
%            pixel(3)=I_G(ii-1,jj);
%            pixel(4)=I_G(ii-1,jj+1);
%            pixel(5)=I_G(ii,jj-1);
%            pixel(6)=I_G(ii,jj+1);
%            pixel(7)=I_G(ii+1,jj-1);
%            pixel(8)=I_G(ii+1,jj);
%            pixel(9)=I_G(ii+1,jj+1);
% 
% %          pixel = uint8(pixel);
% 
%            temp_list(1) = (pixel(1)+pixel(3)+pixel(8));
%            temp_list(2) = (pixel(1)+pixel(5)+pixel(6));
%            temp_list(3) = (pixel(1)+pixel(2)+pixel(9));
%            temp_list(4) = (pixel(1)+pixel(4)+pixel(7));


           temp_list = zeros(1,5);
           pixel_1=I_G(ii,jj);
           pixel_2=I_G(ii-1,jj-1);
           pixel_3=I_G(ii-1,jj);
           pixel_4=I_G(ii-1,jj+1);
           pixel_5=I_G(ii,jj-1);
           pixel_6=I_G(ii,jj+1);
           pixel_7=I_G(ii+1,jj-1);
           pixel_8=I_G(ii+1,jj);
           pixel_9=I_G(ii+1,jj+1);

           temp_list(1) = (pixel_1+pixel_3+pixel_8);
           temp_list(2) = (pixel_1+pixel_5+pixel_6);
           temp_list(3) = (pixel_1+pixel_2+pixel_9);
           temp_list(4) = (pixel_1+pixel_4+pixel_7);



           max_value = max(temp_list);

           if max_value >= 255 
               i = i + 1;
           end

           min_value = min(temp_list);

           if max_value > 190
               max_list(i) = max_value;
               i = i + 1;
               new_I_G(ii-1,jj-1)=max_value;
           else
               new_I_G(ii-1,jj-1)=min_value;
           end

       end
    end
end

