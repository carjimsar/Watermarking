function [marcaFinal] = creaMarca(baseHeight,baseWidth,markHeight,markWidth,colorDepth,marca,type)
% Función que crea la marca a incrustar a partir de las opciones
% indicadas por el usuario y la marca original facilitada.

switch type
    case 1 %Redimensionado
        marcaFinal = imresize(marca,[baseHeight,baseWidth]);
    case 2 %Centrado
        marcaFinal = zeros(baseHeight,baseWidth, 'uint8');
        marcaFinal( (baseHeight-markHeight)/2 : ((baseHeight-markHeight)/2 + markHeight) - 1, (baseWidth-markWidth)/2 : ((baseWidth-markWidth)/2 + markWidth) - 1)= marca;
    case 3 %Bloque
        disp('tonto')
    otherwise
        disp('tonto')
end

end