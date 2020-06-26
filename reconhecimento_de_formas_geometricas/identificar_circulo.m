im = imread('circulo_fr.jpg');
figure; imshow(im); title('Imagem original');

% Separo os objetos da imagem;
bw = im2bw(im,0.35); figure; imshow(bw);

stats = regionprops(bw,'Centroid','MajorAxisLength','MinorAxisLength');

centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
d1 = stats.MajorAxisLength;
d2 = stats.MinorAxisLength;

hold on
viscircles(centers,radii);
hold off
