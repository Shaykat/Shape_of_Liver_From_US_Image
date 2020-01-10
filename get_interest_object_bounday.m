function [max_boundary, L, Iedg] = get_interest_object_bounday(new_I_G)
%   GET_INTEREST_OBJECT_BOUNDAY Summary of this function goes here
%   Detailed explanation goes here

    [B,L] = bwboundaries(new_I_G,'noholes');
%   imshow(label2rgb(L, @jet, [.5 .5 .5]))
    hold on;
    max_area = 0;
    for k = 1:length(B)
       boundary = B{k};
       X = boundary(:,2);
       Y = boundary(:,1);
       area = polyarea(X,Y);
       if area >= max_area
           max_area = area;
           max_boundary = boundary;
       end
    end
    
    Iedg=new_I_G;
    row = size(Iedg,1);
    colomn = size(Iedg,2);
    X = max_boundary(:,1);
    Y = max_boundary(:,2);

    for i=2:row-1
        for j=2:colomn-1
            Iedg(i, j) = 0;
        end
    end

    for i = 1: size(X, 1)
        Iedg(X(i), Y(i)) = 1;
    end
end

