function y = identifica_forma(I);
% A fun��o identifica_forma(I), onde I � o caminho da imagem a ser
% analisada, � utilizada para identificar determinadas formas
% pr�determinadas nas imagens passadas como par�metro para a fun��o.
%
% Chamando a fun��o:
%                   identifica_forma('D:\nome_da_imagem')
%
%      Obs: o nome da imagem deve vir junto com a extens�o do arquivo
%
% Ap�s ler a imagem a fun��o separa e realiza a an�lise da forma
% encontrada, identificando par�metros como �rea, Altura e largura do
% objeto, cicularidade e ecentricidade do objeto.
%
% Baseado nessas informa��es � poss�vel separar as formas de acordo com os
% seguintes crit�rios:
%	CIRCULO -> utilizando o par�metro "Circularity" na fun��o regionprops a
%	circularidade da forma deve ser maior que 0.98, que corresponde a um
%	c�rculo com uma margem de toler�ncia de 0.02 a imperfei��o da forma.
%
%	RETANGULO -> a propriedade "Area" da forma deve ser igual a area
%   calculada utilizando a proprieade "BoundingBox".
%
%   TRIANGULO -> o "Extent" da forma deve estar entre 0.5 e 0.55. Visto que
%   a area dos triangulos correspondem a metade da area do quadrado formado
%   a partir da base e altura do triangulo.
%
%   ESTRELA -> atrav�s de testes observa-se que as estrelas tem a mesma
%   propriedade de metade da area do quadrado gerado entorno dela, assim
%   como com os triangulos. Por�m, pela transformada de Hough e encontrando
%   a quantidade de linhas que h� na forma determinamos que essa forma deve
%   ter no m�nimo 13 linhas interligadas, que � a verifica��o para ser uma
%   estrela ou triangulo.
%
%   ELIPSE -> a elipse � verificada de acordo com sua ecentricidade. Se a
%   ecentricidade calculada pela fun��o regionprops for igual a
%   ecentricidade calculada pela formula e = sqrt((maior eixo/2)^2- (menor
%   eixo/2)^2)/a e tamb�m pelo fato de ser a �ltima verifica��o significa
%   que a forma n�o � nenhuma das anteriores, sobrando apenas a elipse.
%
% Para mostrar o resultado a fun��o mostra a imagem na tela para o usu�rio
% tendo como t�tulo o nome da forma identificada
%

%% LEITURA E PR�-PROCESSAMENTO DA IMAGEM
im = imread(I);
bw = im2bw(im,0.299);
label = bwlabel(bw);
imagem = regionprops(label,'Area','BoundingBox','Circularity','Eccentricity','Extent','Image','MajorAxisLength','MinorAxisLength');

%% para a verifica��o da Elipse
%contorno = boundary(bw);
a = imagem.MajorAxisLength/2;
b = imagem.MinorAxisLength/2;
c = sqrt(a^2-b^2);
e = c/a;

%% VERIFICA��O DA CIRCULARIDADE E CLASSIFICA��O DA FORMA
if (imagem.Circularity >= 0.98) %% C�RCULO
    figure;imshow(im);title('Isto � um C�rculo');
    
elseif ((imagem.Area == (imagem.BoundingBox(3)*imagem.BoundingBox(4))) && imagem.BoundingBox(3)~= imagem.BoundingBox(4))) %% RET�NGULO
    figure;imshow(im);title('Isto � um Ret�ngulo');
    
elseif ((imagem.Extent >= 0.50) || (imagem.Extent <= 0.55)) %% TRI�NGULO OU ESTRELA
    [Edge_im,thres] = edge(bw,'sobel');
    [H,T,R] = hough(Edge_im); % faz o c�lculo bruto ----- retorna 3 variaveis de saida, matriz H, os Tetas e os R�s
    P  = houghpeaks(H,10,'threshold',ceil(0.35*max(H(:)))); % encontra os m�ximos
    lines = houghlines(Edge_im,T,R,P,'FillGap',20,'MinLength',5); % fillgap -> completa retas falhadas // minlength � o tamanho minimo de
    
    if (length(lines) == 3) %% TRI�NGULO
        figure;imshow(im);title('Isto � um Tri�ngulo');
    elseif (length(lines) == 13) %% ESTRELA 
        figure;imshow(im);title('Isto � uma Estrela');
    end
    
elseif (e == imagem.Eccentricity) %% ELIPSE
    figure;imshow(im);title('Isto � uma Elipse');
    
else %% FORMA N�O IDENTIFICADA
    figure;imshow(im);title('Forma n�o reconhecida');
end
end