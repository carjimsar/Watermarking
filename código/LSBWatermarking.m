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
toMark = creaMarca(baseHeight,baseWidth,markHeight,markWidth,colorDepth,marca,type);

if colouredBase == 0
   base = rgb2gray(base);
   deleteMask = bitcmp(uint8((2^(markDepth))-1));
   watermarked = toMark + bitand(base, deleteMask);
else
   apanio = [1,2,3,1,2,3,1,2]; % Apaño para trabajar facilmente con cada canal
   deleteMask = uint(254);
   for i = 1 : markDepth
       if(i == 4) || (i == 7)
        deleteMask = bitshift(deleteMask,1);
       end
       watermarked(:,:,apanio(i)) = bitand(watermarked(:,:,apanio(i)), deleteMask) % AQUI SE SUMA LA INFO CORRESPONDIENTE Y A JUIR;

   end
end