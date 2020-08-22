% Lectura imagenes
objetivo = imread("banco.jpg");
objetivo = rgb2gray(objetivo);
marca = imbinarize(rgb2gray(imread("logo.jpg")));

% Obtenemos tamaño de imagen objetivo y de marca
[X,Y,~] = size(objetivo);
[F,C,~] = size(marca);

% Todos los bits de la imagen original a 0
objetivo(:)=objetivo(:)-mod(objetivo(:),2);
logo = imresize(marca,[X,Y]);
logo = cast(logo, 'uint8');
final = objetivo + logo;
test1=mod(final,2);