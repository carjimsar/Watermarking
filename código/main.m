% Lectura imagenes
objetivo = imread("banco.jpg");
objetivo = rgb2gray(objetivo);
% Conversion marca a objeto binario
marca = imbinarize(rgb2gray(imread("logo.jpg")));

% Obtenemos tamaño de imagen objetivo y de marca
[X,Y,~] = size(objetivo);
[F,C,~] = size(marca);

% LSB de objetivo a 0
objetivo(:)=objetivo(:)-mod(objetivo(:),2);
% Escalamos marca al mismo tamaño que objetivo
logo = imresize(marca,[X,Y]);
% Convertimos objeto binario al mismo tipo que objetivo
logo = cast(logo, 'uint8');
% Insertamos marca en objetivo
final = objetivo + logo;
% Recuperamos marca
test1=~mod(final,2);
% La mostramos
imtool(test1);