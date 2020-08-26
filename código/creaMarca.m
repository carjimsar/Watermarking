function [marcaFinal] = creaMarca(baseHeight,baseWidth,markHeight,markWidth,bitDepth,marca,type)
% Función que crea la marca a incrustar a partir de las opciones
% indicadas por el usuario y la marca original facilitada.

if bitDepth < 2
    % Si solo podemos usar un bit, la marca a introducir es binaria
    marca = imbinarize(marca);
elseif bitDepth < 8
    % De otra forma
    %[marca,~] = rgb2ind(marca, colorDepth);
    marca = bitshift(marca, 8-bitDepth);
else
    % Si podemos usar los 8, insertamos como marca en escala de grises
    marca = rgb2gray(marca);
end

switch type
    case 1 % Redimensionado
        marcaFinal = imresize(marca,[baseHeight,baseWidth]);
    case 2 % Centrado
        marcaFinal = zeros(baseHeight,baseWidth, 'uint8');
        % Centramos la marca en una imagen en blanco del tamaño apropiado
        marcaFinal( (baseHeight-markHeight)/2 : ((baseHeight-markHeight)/2 + markHeight) - 1, (baseWidth-markWidth)/2 : ((baseWidth-markWidth)/2 + markWidth) - 1) = marca;
    case 3 % Patron
        % Calculamos cuantas veces es la imagen base la marca
        times2repeat = ceil(max([baseHeight/markHeight, baseWidth/baseHeight]));
        % Replicamos la marca por exceso
        patron = repmat(marca, times2repeat+5);
        % Quitamos el exceso
        marcaFinal = patron(1 : baseHeight, 1 : baseWidth);
end

end