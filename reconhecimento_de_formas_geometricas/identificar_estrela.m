I=imread('triangulo_fl.jpg'); %l� uma imagem e a grava na variavel
figure, imshow(I); title('Imagem Original'); %mostra a imagem
%Gray_im = rgb2gray(I);
[Edge_im,thres] = edge(I,'sobel',0.09); %detec��o de contorno na imagem
figure, imshow(Edge_im); title('Imagem Segmentada por contorno'); %mostra a figura com os contornos
[H,T,R] = hough(Edge_im); %faz o c�lculo bruto ----- retorna 3 variaveis de saida, matriz H, os Tetas e os R�s


P  = houghpeaks(H,10,'threshold',ceil(0.35*max(H(:)))); %encontra os m�ximos
lines = houghlines(Edge_im,T,R,P,'FillGap',30,'MinLength',5); %%fillgap -> completa retas falhadas // minlength � o tamanho minimo de 
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
%title('Hough Transform of Gantrycrane Image');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);

figure, imshow(Edge_im);title('Imagem Submetida � Detec��o de Contornos');hold on;
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

if length(lines) == 3
    fprintf('E um triangulo');
end

%
