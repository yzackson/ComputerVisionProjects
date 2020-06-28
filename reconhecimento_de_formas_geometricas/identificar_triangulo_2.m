function [Boxes] = identificar_triangulo_2(InputImg)
img = imread(InputImg);
Index=1;
%Boxes=struct('Box',[]);
for s=1:3
      % determina o numero de objetos na imagem
      [imgN, num] = bwlabel(img,4);
      % pega as propriedades dos objetos detectados
      f = regionprops(imgN,'BoundingBox','Centroid','Extent','Eccentricity'); %Changer imfeature pour regionprops
      %para triangulo
      for i=1:num
          if(f(i).Extent>0.3) & (f(i).Extent<0.6) & (f(i).Eccentricity<0.8) & (f(i).Eccentricity>0.2)
              Boxes(Index).Box=f(i).BoundingBox;
              Index=Index+1;
          end        
      end    
 end