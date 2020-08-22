% LSB | 1 Bit | RGB y binario | Ajustado a Base

% Lectura imagenes
objetivo = imread("banco.jpg");
% Conversion marca a objeto binario
marca = imbinarize(rgb2gray(imread("logo.jpg")));

% Obtenemos tamaño de imagen objetivo y de marca
[X,Y,~] = size(objetivo);
[F,C,~] = size(marca);

% LSB de objetivo a 0
objetivo(:,:,1)=objetivo(:,:,1)-mod(objetivo(:,:,1),2);
% Escalamos marca al mismo tamaño que objetivo
logo = imresize(marca,[X,Y]);
% Convertimos objeto binario al mismo tipo que objetivo
logo = cast(logo, 'uint8');
% Insertamos marca en un canal de objetivo
final = objetivo;
final(:,:,1) = final(:,:,1) + logo;

% Recuperamos marca
test1=~mod(final(:,:,1),2);
% La mostramos
imtool(test1);