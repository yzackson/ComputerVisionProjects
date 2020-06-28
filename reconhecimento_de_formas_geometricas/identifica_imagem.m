function y = identifica_imagem(I)
%IDENTIFICA_IMAGEM analisa e reconhece qual a forma que aparece na imagem.
%   identifica_imagem(I) � o comando que chama a fun��o passando como
%   par�metro I o caminho completo da imagem que se deseja analizar, no
%   caso de a imagem n�o estar na mesma pasta que a fun��o. O nome da
%   imagem deve sempre estar acompanhado da extens�o (.jpg, .png etc).
%
%   Ap�s processamento a imagem ser� mostrada na tela tendo como t�tulo o
%   nome da forma identificada.

%% LEITURA E PR�-PROCESSAMENTO DA IMAGEM
im = imread(I);
bw = im2bw(im,0.299);
label = bwlabel(bw,4);

%% Calcula a circularidade da forma
imagem = regionprops(label,'Circularity');
img = imagem.Circularity; % comando para mostrar no coommand line o valor da circularidade

%% VERIFICA��O DA CIRCULARIDADE E CLASSIFICA��O DA FORMA

if (imagem.Circularity >= 1) % CIRCULO
    imagem.Circularity
    figure;imshow(im);title('Isto � um circulo');
elseif (imagem.Circularity < 0.484) % ESTRELA
    imagem.Circularity
    figure;imshow(im);title('Isto � uma estrela');
elseif (imagem.Circularity < 0.621) % TRIANGULO
    imagem.Circularity
    figure;imshow(im);title('Isto � um tri�ngulo');
elseif (imagem.Circularity < 0.714) % RETANGULO
    imagem.Circularity
    figure;imshow(im);title('Isto � um ret�ngulo');
elseif (imagem.Circularity < 0.825) % ELIPSE
    imagem.Circularity
    figure;imshow(im);title('Isto � uma elipse');
end

end