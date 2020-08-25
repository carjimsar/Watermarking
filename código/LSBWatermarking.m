% LSB
% Con este script se puede tanto introducir una marca de agua (no visible)
% en una imagen como recuperarla.
base = imread("banco.jpg");
mark = imread("logo.jpg");

% PARAMETROS A CONFIGURAR
% Aunque aqui se facilita una breve descripcion, en el manual se encuentra
% detallada la configuración a realizar por el usuario.
insertionType = 3; % 1 para redimensionado, 2 para centrado y 3 para bloque
markDepth = 7; % Bits a usar para la marca de agua. Por defecto, un objeto binario
colouredBase = 0; % Para resultado en GS 0, en color 1


% NO TOCAR

% INSERTAR
[baseHeight,baseWidth,~] = size(base);
[markHeight,markWidth,~] = size(mark);
toMark = creaMarca(baseHeight,baseWidth,markHeight,markWidth,markDepth,mark,insertionType);
toMark = cast(toMark, 'uint8');

if colouredBase == 0
   baseGS = rgb2gray(base);
   deleteMask = bitcmp(uint8((2^(markDepth))-1));
   watermarked = toMark + bitand(baseGS, deleteMask);
else
   watermarked = base; % Copiamos la base
   apanio = [1,2,3,1,2,3,1,2]; % Apaño para trabajar facilmente con cada canal en el bucle
   offset = 0;
   deleteMask = uint8(254); % Mascara para establecer bits a 0
   for i = 1 : markDepth % Bucle para eliminar bits de base e introducir de marca
       if ((i == 4) || (i == 7)) % Hay que cambiar la mascara cuando necesitemos mas bits de un canal
        deleteMask = bitshift(deleteMask,1)+1; % Sumamos 1 para no eliminar la info ya introducida
        offset = offset + 1;
       end
       watermarked(:,:,apanio(i)) = bitshift(bitget(toMark, i),offset) + bitand(watermarked(:,:,apanio(i)), deleteMask); 
   end
end

% RECUPERAR

recovered = zeros(baseHeight, baseWidth, 'uint8'); % Reserva de espacio para la marca recuperada

if colouredBase == 1
    recoverMask = uint8(1); % Máscara para realizar las ops por bit para recuperarlos
    for i = 1 : markDepth % Bucle para recuperar bit a bit de la marca
        if ((i == 4) || (i == 7)) % Hay que cambiar la mascara cuando necesitemos mas bits de un canal
            recoverMask = bitshift(recoverMask,1)+1; % Sumamos 1 para no eliminar la info ya introducida
        end
        recovered = recovered + bitshift(bitand(watermarked(:,:,apanio(i)),recoverMask),i);
    end
else
    recoverMask = uint8((2^(markDepth))-1);
    recovered = recovered + bitand(watermarked,recoverMask);
end

% Presentacion por pantalla
figure();
subplot(2,3,1);
imshow(base);
title('Base Original');
subplot(2,3,2);
imshow(mark);
title('Marca Original');
subplot(2,3,3);
if (colouredBase == 1)
    imshow(base);
else
    imshow(baseGS);
end
title('Base Objetivo');
subplot(2,3,4);
%toMark = cast(toMark, 'logical');
imshow(~toMark);
title('Marca Objetivo');
subplot(2,3,5);
imshow(watermarked);
title('Resultado');
subplot(2,3,6);
imshow(~recovered);
title('Marca Recuperada');