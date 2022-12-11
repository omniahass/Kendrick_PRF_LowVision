function [CrossMask] = MyMakeCross(FixSize_Pix,LineWidth_Pix)


Yloc(1)=1;
Yloc(4)=Yloc(1)+FixSize_Pix-1;

Yloc(2)=ceil((FixSize_Pix-LineWidth_Pix)/2);
Yloc(3)=ceil(Yloc(2)+LineWidth_Pix);

Xloc(1)=1;
Xloc(4)=Xloc(1)+FixSize_Pix-1;

Xloc(2)=ceil((FixSize_Pix-LineWidth_Pix)/2);
Xloc(3)=ceil(Xloc(2)+LineWidth_Pix);


CrossMask = zeros(FixSize_Pix);
CrossMask(Yloc(1):Yloc(4), Xloc(2):Xloc(3)) = 255; %verical line
CrossMask(Yloc(2):Yloc(3), Xloc(1):Xloc(4)) = 255; %horizontal line


end

