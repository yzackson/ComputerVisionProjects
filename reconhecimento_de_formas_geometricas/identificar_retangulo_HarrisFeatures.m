I = imread('triangulo_fl.jpg');

bw = im2bw(I,0.2999);

corners = detectHarrisFeatures(bw);

if length(selectStrongest(corners,50)) == 4
    figure; imshow(bw); title('Isto é um retângulo');
else
    figure; imshow(bw); title('Isto não é um retângulo');
end