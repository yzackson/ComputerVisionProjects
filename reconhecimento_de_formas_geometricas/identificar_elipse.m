I = imread('retangulo_fl.jpg');

% Pela definição de Elipse a fórmula abaixo deve ser verdadeira para o caso
% de uma elipse na horizontal
%           (x^2/a^2) + (y^2/b^2) = 1
% onde
% a => metade do maior eixo da elipse
% b => metade do menor eixo da elipse
%
% Para uma elipse na vertical a formula é a seguinte
%           (x^2/b^2) + (y^2/a^2) = 1
%
%

I = imread('retangulo_fl.jpg');

bw = im2bw(I,0.2999);

label = bwlabel(bw);

cont = bwboundaries(label);

contorno = cont{1,1};

stats = regionprops(label,'MajorAxisLength','MinorAxisLength','Eccentricity');

maiorEixo = stats.MajorAxisLength;
menorEixo = stats.MinorAxisLength;

a = maiorEixo/2;
b = menorEixo/2;

soma = 0;

linha = 0;

%soma = (contorno(linha,1)^2/a^2) + (contorno(linha,2)^2/b^2);

for linha = 1:length(contorno)
    soma = soma + (contorno(linha,1)^2/a^2) + (contorno(linha,2)^2/b^2);
end

metric = soma/linha;
