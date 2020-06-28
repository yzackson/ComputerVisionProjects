function y = identifica_imagem(I)
% Help
%
%
%
im = imread(I);
bw = im2bw(im,0.299);

label = bwlabel(bw,4);

imagem = regionprops(label,'Circularity');

img = imagem.Circularity;

if (imagem.Circularity >= 1)
    imagem.Circularity
    figure;imshow(im);title('Isto � um circulo');
elseif (imagem.Circularity < 0.484)
    imagem.Circularity
    figure;imshow(im);title('Isto � uma estrela');
elseif (imagem.Circularity < 0.621)
    imagem.Circularity
    figure;imshow(im);title('Isto � um tri�ngulo');
elseif (imagem.Circularity < 0.714)
    imagem.Circularity
    figure;imshow(im);title('Isto � um ret�ngulo');
elseif (imagem.Circularity < 0.825)
    imagem.Circularity
    figure;imshow(im);title('Isto � uma elipse');
end



end