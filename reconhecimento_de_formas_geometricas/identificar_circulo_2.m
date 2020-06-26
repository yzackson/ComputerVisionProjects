im = imread('circulo_fl.jpg');

bw = im2bw(im,0.2999);

label = bwlabel(bw,4);

stats = regionprops(label,'Area','MajorAxisLength');

d = stats.MajorAxisLength;
r = d/2;
a = stats.Area;
perimetro = 2*pi*r;

metric = 4*pi*a/perimetro^2;

treshold = 0.94;

if metric >= treshold
    figure;imshow(label);title('Isto é um círculo');
else
    figure;imshow(label);title('Isto não é um círculo');
end