function [score,  y, x ] = Generalized_Hough_Transform(Iedg) 
    Is = Iedg;
    Itm = imread("Template_edge.png");

    %--------------------------create edge and system edge images------------------------------------------------------------------------------------------------------------------------

    Iedg=edge(Is,'canny');         

    [y, x]=find(Itm>0); 
    nvs=size(x);

    %Define Yc and Xc 
    Cy=1;
    Cx=1;

    %create gradient map of Itm, distrobotion between zero to pi
    GradientMap = gradient_direction( Itm );

    %create template descriptor array
    MaxAngelsBins=30;
    MaxPointsPerangel=nvs(1);
    PointCounter=zeros(MaxAngelsBins);
    Rtable=zeros(MaxAngelsBins,MaxPointsPerangel,2);

    %------------------fill the  angel bins with points in the Rtable---------------------------------------------------------
    for f=1:1:nvs(1)
        bin=round((GradientMap(y(f), x(f))/pi)*(MaxAngelsBins-1))+1; 
        PointCounter(bin)=PointCounter(bin)+1;
        if (PointCounter(bin)>MaxPointsPerangel)
            disp('exceed max bin in hugh transform');
        end
        Rtable(bin, PointCounter(bin),1)= Cy-y(f);
        Rtable(bin, PointCounter(bin),2)= Cx-x(f);
    end

    %-----------------------------use the array in previous image to identify the template in the main image Is----------------------------------------
    [y, x]=find(Iedg>0); 
    np=size(x);
    GradientMap=gradient_direction(Is); 
    Ss=size(Is); 
    houghspace=zeros(size(Is));
        for f=1:1:np(1)
              bin=round((GradientMap(y(f), x(f))/pi)*(MaxAngelsBins-1))+1; 
              for fb=1:1:PointCounter(bin)
                  ty=Rtable(bin, fb,1)+ y(f);
                  tx=Rtable(bin, fb,2)+ x(f);
                   if (ty>0) && (ty<Ss(1)) && (tx>0) && (tx<Ss(2))  
                       houghspace(Rtable(bin, fb,1)+ y(f), Rtable(bin, fb,2)+ x(f)) =  houghspace(Rtable(bin, fb,1)+ y(f), Rtable(bin, fb,2)+ x(f))+1; % add point in were the center of the image should be according to the pixel gradient
                   end        
              end
        end

    %---------------------------------------------------------------------------normalized according to template size (fraction of the template points that was found)------------------------------------------------------------------------------------------------
    Itr=houghspace;
    %---------------------------------------------------------------------------find  the location best score all scores which are close enough to the best score
    temp = max(Itr);
    mx=max(temp);% find the max score location
    [y,x]=find(Itr==mx);
    score=Itr(y,x); % find max score in the huogh space 




    function [ Is ] = gradient_direction( i3 )
        Dy=imfilter(double(i3),[1; -1],'same');
        Dx=imfilter(double(i3),[1  -1],'same');
        Is=mod(atan2(Dy,Dx)+pi(), pi());
    end
end