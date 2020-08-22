% Lectura imagenes
objetivo = imread("banco.jpg");
objetivo = rgb2gray(objetivo);
marca = imbinarize(imread("logo.png"));

% Obtenemos tamaño de imagen objetivo y de marca
[X,Y,~] = size(objetivo);
[F,C,~] = size(marca);

% Comprobamos que es mayor, si la imagen objetivo o la marca
if (X>F) && (Y>C)
    offsetX = (X-F)/2;
    offsetY = (Y-C)/2;
    i = 1;
    for w = offsetX:(offsetX+F)
        for p = offsetY:(offsetY+C)
            bitset(objetivo(w,p), 0, marca(i))
            i = i+1;
        end
    end
end