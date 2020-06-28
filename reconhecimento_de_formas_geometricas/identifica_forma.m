function y = identifica_forma(I);
% A função identifica_forma(I), onde I é o caminho da imagem a ser
% analisada, é utilizada para identificar determinadas formas
% prédeterminadas nas imagens passadas como parâmetro para a função.
%
% Chamando a função:
%                   identifica_forma('D:\nome_da_imagem')
%
%      Obs: o nome da imagem deve vir junto com a extensão do arquivo
%
% Após ler a imagem a função separa e realiza a análise da forma
% encontrada, identificando parâmetros como área, Altura e largura do
% objeto, cicularidade e ecentricidade do objeto.
%
% Baseado nessas informações é possível separar as formas de acordo com os
% seguintes critérios:
%	CIRCULO -> utilizando o parâmetro "Circularity" na função regionprops a
%	circularidade da forma deve ser maior que 0.98, que corresponde a um
%	círculo com uma margem de tolerância de 0.02 a imperfeição da forma.
%
%	RETANGULO -> a propriedade "Area" da forma deve ser igual a area
%   calculada utilizando a proprieade "BoundingBox".
%
%   TRIANGULO -> o "Extent" da forma deve estar entre 0.5 e 0.55. Visto que
%   a area dos triangulos correspondem a metade da area do quadrado formado
%   a partir da base e altura do triangulo.
%
%   ESTRELA -> através de testes observa-se que as estrelas tem a mesma
%   propriedade de metade da area do quadrado gerado entorno dela, assim
%   como com os triangulos. Porém, pela transformada de Hough e encontrando
%   a quantidade de linhas que hé na forma determinamos que essa forma deve
%   ter no mínimo 13 linhas interligadas, que é a verificação para ser uma
%   estrela ou triangulo.
%
%   ELIPSE -> a elipse é verificada de acordo com sua ecentricidade. Se a
%   ecentricidade calculada pela função regionprops for igual a
%   ecentricidade calculada pela formula e = sqrt((maior eixo/2)^2- (menor
%   eixo/2)^2)/a e também pelo fato de ser a última verificação significa
%   que a forma não é nenhuma das anteriores, sobrando apenas a elipse.
%
% Para mostrar o resultado a função mostra a imagem na tela para o usuário
% tendo como título o nome da forma identificada
%

%% LEITURA E PRÉ-PROCESSAMENTO DA IMAGEM
im = imread(I);
bw = im2bw(im,0.299);
label = bwlabel(bw);
imagem = regionprops(label,'Area','BoundingBox','Circularity','Eccentricity','Extent','Image','MajorAxisLength','MinorAxisLength');

%% para a verificação da Elipse
%contorno = boundary(bw);
a = imagem.MajorAxisLength/2;
b = imagem.MinorAxisLength/2;
c = sqrt(a^2-b^2);
e = c/a;

%% VERIFICAÇÃO DA CIRCULARIDADE E CLASSIFICAÇÃO DA FORMA
if (imagem.Circularity >= 0.98) %% CÍRCULO
    figure;imshow(im);title('Isto é um Círculo');
    
elseif ((imagem.Area == (imagem.BoundingBox(3)*imagem.BoundingBox(4))) && imagem.BoundingBox(3)~= imagem.BoundingBox(4))) %% RETÂNGULO
    figure;imshow(im);title('Isto é um Retângulo');
    
elseif ((imagem.Extent >= 0.50) || (imagem.Extent <= 0.55)) %% TRIÂNGULO OU ESTRELA
    [Edge_im,thres] = edge(bw,'sobel');
    [H,T,R] = hough(Edge_im); % faz o cálculo bruto ----- retorna 3 variaveis de saida, matriz H, os Tetas e os Rôs
    P  = houghpeaks(H,10,'threshold',ceil(0.35*max(H(:)))); % encontra os máximos
    lines = houghlines(Edge_im,T,R,P,'FillGap',20,'MinLength',5); % fillgap -> completa retas falhadas // minlength é o tamanho minimo de
    
    if (length(lines) == 3) %% TRIÂNGULO
        figure;imshow(im);title('Isto é um Triângulo');
    elseif (length(lines) == 13) %% ESTRELA 
        figure;imshow(im);title('Isto é uma Estrela');
    end
    
elseif (e == imagem.Eccentricity) %% ELIPSE
    figure;imshow(im);title('Isto é uma Elipse');
    
else %% FORMA NÃO IDENTIFICADA
    figure;imshow(im);title('Forma não reconhecida');
end
end