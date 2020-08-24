% LSB
% Con este script se puede tanto introducir una marca de agua (no visible)
% en una imagen como recuperarla.
base = imread("base.jpg");
mark = imread("mark.jpg");

% PARAMETROS A CONFIGURAR
% Aunque aqui se facilita una breve descripcion, en el manual se encuentra
% detallada la configuración a realizar por el usuario.
insertionType = 1; % 1 para redimensionado, 2 para centrado y 3 para bloque
markDepth = 1; % Bits a usar para la marca de agua. Por defecto, un objeto binario
colouredBase = 0; % Para resultado en GS 0, en color 1


% NO TOCAR

% INSERTAR
toMark = creaMarca(baseHeight,baseWidth,markHeight,markWidth,colorDepth,marca,type);

if colouredBase == 0
   base = rgb2gray(base);
   deleteMask = bitcmp(uint8((2^(markDepth))-1));
   watermarked = toMark + bitand(base, deleteMask);
else
   watermarked = base; % Copiamos la base
   apanio = [1,2,3,1,2,3,1,2]; % Apaño para trabajar facilmente con cada canal en el bucle
   offset = 0;
   deleteMask = uint(254); % Mascara para establecer bits a 0
   for i = 1 : markDepth % Bucle para eliminar bits de base e introducir de marca
       if ((i == 4) || (i == 7)) % Hay que cambiar la mascara cuando necesitemos mas bits de un canal
        deleteMask = bitshift(deleteMask,1)+1;
        offset = offset + 1;
       end
       watermarked(:,:,apanio(i)) = bitshift(bitget(mark, i),offset) + bitand(watermarked(:,:,apanio(i)), deleteMask); 
   end
end