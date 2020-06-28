function y = identifica_forma(I);

im = imread(I);
bw = im2bw(im,0.299);

label = bwlabel(bw);


imagem = regionprops(label,'Perimeter','Area','BoundingBox','Circularity','Eccentricity','Extent','Image','MajorAxisLength','MinorAxisLength');

%% para a verifica��o da Elipse
%contorno = boundary(bw);
a = imagem.MajorAxisLength/2;
b = imagem.MinorAxisLength/2;
c = sqrt(a^2-b^2);
e = c/a;

%% Analisa os dados lidos na imagem pela fun��o regionprops
%   e aplica as condi��es espec�ficas para cada forma
if (imagem.Circularity >= 0.95)
    %% C�RCULO
    %
    %
    %
    figure;imshow(im);title('Isto � um C�rculo');
    
elseif ((imagem.Area == (imagem.BoundingBox(3)*imagem.BoundingBox(4))) && (imagem.BoundingBox(3)~= imagem.BoundingBox(4)))
    %% RET�NGULO
    %
    %
    %
    figure;imshow(im);title('Isto � um Ret�ngulo');
    
elseif ((imagem.Extent >= 0.50) || (imagem.Extent <= 0.55))
    %% TRI�NGULO OU ESTRELA
    %
    %
    %
    [Edge_im,thres] = edge(bw,'sobel');
    [H,T,R] = hough(Edge_im); % faz o c�lculo bruto ----- retorna 3 variaveis de saida, matriz H, os Tetas e os R�s
    P  = houghpeaks(H,10,'threshold',ceil(0.35*max(H(:)))); % encontra os m�ximos
    lines = houghlines(Edge_im,T,R,P,'FillGap',20,'MinLength',5); % fillgap -> completa retas falhadas // minlength � o tamanho minimo de
    if (length(lines) == 3)
        figure;imshow(im);title('Isto � um Tri�ngulo');
    elseif (length(lines) == 13) % TEM QUE REVER ESSA PARTE
        figure;imshow(im);title('Isto � uma Estrela');
    end
    
elseif (e == imagem.Eccentricity) 
    %% ELIPSE
    %
    %
    %
    figure;imshow(im);title('Isto � uma Elipse');
    
else
    figure;imshow(im);title('Forma n�o reconhecida');
end
end
%%
%
%