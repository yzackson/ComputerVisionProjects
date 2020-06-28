function y = identifica_imagem(I)
%IDENTIFICA_IMAGEM analisa e reconhece qual a forma que aparece na imagem.
%   identifica_imagem(I) é o comando que chama a função passando como
%   parâmetro I o caminho completo da imagem que se deseja analizar, no
%   caso de a imagem não estar na mesma pasta que a função. O nome da
%   imagem deve sempre estar acompanhado da extensão (.jpg, .png etc).
%
%   Após processamento a imagem será mostrada na tela tendo como título o
%   nome da forma identificada.

%% LEITURA E PRÉ-PROCESSAMENTO DA IMAGEM
im = imread(I);
bw = im2bw(im,0.299);
label = bwlabel(bw,4);

%% Calcula a circularidade da forma
imagem = regionprops(label,'Circularity');
img = imagem.Circularity; % comando para mostrar no coommand line o valor da circularidade

%% VERIFICAÇÃO DA CIRCULARIDADE E CLASSIFICAÇÃO DA FORMA

if (imagem.Circularity >= 1) % CIRCULO
    imagem.Circularity
    figure;imshow(im);title('Isto é um circulo');
elseif (imagem.Circularity < 0.484) % ESTRELA
    imagem.Circularity
    figure;imshow(im);title('Isto é uma estrela');
elseif (imagem.Circularity < 0.621) % TRIANGULO
    imagem.Circularity
    figure;imshow(im);title('Isto é um triângulo');
elseif (imagem.Circularity < 0.714) % RETANGULO
    imagem.Circularity
    figure;imshow(im);title('Isto é um retângulo');
elseif (imagem.Circularity < 0.825) % ELIPSE
    imagem.Circularity
    figure;imshow(im);title('Isto é uma elipse');
end

end