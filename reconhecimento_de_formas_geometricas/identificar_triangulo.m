im=imread('triangulo_fl.jpg'); %lê uma imagem e a grava na variavel
I = im2bw(im,0.2999);
figure, imshow(I); title('Imagem Original'); %mostra a imagem
%Gray_im = rgb2gray(I);
[Edge_im,thres] = edge(I,'sobel'); %detecção de contorno na imagem
figure, imshow(Edge_im); title('Imagem Segmentada por contorno'); %mostra a figura com os contornos
[H,T,R] = hough(Edge_im); %faz o cálculo bruto ----- retorna 3 variaveis de saida, matriz H, os Tetas e os Rôs
P  = houghpeaks(H,10,'threshold',ceil(0.35*max(H(:)))); %encontra os máximos
lines = houghlines(Edge_im,T,R,P,'FillGap',20,'MinLength',5); %%fillgap -> completa retas falhadas // minlength é o tamanho minimo de 