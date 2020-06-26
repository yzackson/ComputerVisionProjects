im = imread('circulo_fr.jpg');

bw = im2bw(im,0.2999);

label = bwlabel(bw);

stats = regionprops(label, 'Extrema');

extremo = stats.Extrema;

if extremo(1,:) == extremo(8,:)
    if (extremo(2,:) <= (extremo(3,:)+1)) & (extremo(2,:) >= (extremo(3,:)-1))
        if extremo(4,:) == extremo(5,:)
            if extremo(6,:) == extremo(7,:)
                figure; imshow(bw); title('Isto é um retângulo');
            else
                figure; imshow(bw); title('Isto NÃO é um retângulo');
            end
        else
            figure; imshow(bw); title('Isto NÃO é um retângulo');
        end
    else
        figure; imshow(bw); title('Isto NÃO é um retângulo');    
    end
else
    figure; imshow(bw); title('Isto NÃO é um retângulo');
end