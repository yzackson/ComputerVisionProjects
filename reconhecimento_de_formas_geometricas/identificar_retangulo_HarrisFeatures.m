I = imread('triangulo_fl.jpg');

bw = im2bw(I,0.2999);

corners = detectHarrisFeatures(bw);

if length(selectStrongest(corners,50)) == 4
    figure; imshow(bw); title('Isto � um ret�ngulo');
else
    figure; imshow(bw); title('Isto n�o � um ret�ngulo');
end