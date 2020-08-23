% LSB | 1 Bit | RGB y 3 bits (1 x canal) | Ajustado a Base

% Lectura imagenes
objetivo = imread("banco.jpg");
[X,Y,~] = size(objetivo);
% Degradado de profundida de color de marca a bits deseados
marca = imread("logo.jpg");
marca = imresize(marca,[X,Y]);
[downbited,map] = rgb2ind(marca, 8);

% Obtenemos tamaño de imagen objetivo y de marca
[X,Y,~] = size(objetivo);
[F,C,~] = size(marca);

% Una matriz por cada bit de la marca
R = bitget(downbited, 1);
G = bitget(downbited, 2);
B = bitget(downbited, 3);

% Ponemos a 0 el ultimo bit de cada canal y le sumamos la marca
objetivo(:,:,1)=(objetivo(:,:,1)-mod(objetivo(:,:,1),2))+R;
objetivo(:,:,2)=(objetivo(:,:,2)-mod(objetivo(:,:,2),2))+G;
objetivo(:,:,3)=(objetivo(:,:,3)-mod(objetivo(:,:,3),2))+B;

% Recuperamos la marca
recupera=zeros(3000,4500, 'uint8');

mask = uint8(1);

recupera = recupera + bitand(mask, objetivo(:,:,1));
recupera = recupera + bitshift(bitand(mask, objetivo(:,:,2)),1);
recupera = recupera + bitshift(bitand(mask, objetivo(:,:,3)),2);

imwrite(recupera,map,'test.tif');
imshow(imread("test.tif"));
