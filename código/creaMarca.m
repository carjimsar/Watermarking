function [marcaFinal] = creaMarca(baseHeight,baseWidth,markHeight,markWidth,colorDepth,marca,type)
% Función que crea la marca a incrustar a partir de las opciones
% indicadas por el usuario y la marca original facilitada.

if colorDepth == 1
    % Si solo podemos usar un bit, la marca a introducir es binaria
    marca = imbinarize(rgb2gray(marca));
else
    % De otra forma, 
    [marca,~] = rgb2ind(marca, colorDepth);
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
        times2repeat = round(max([baseHeight/markHeight, baseWidth/baseHeight]),0);
        % Replicamos la marca por exceso
        patron = repmat(marca, times2repeat);
        % Quitamos el exceso
        marcaFinal = patron(1 : baseWidth, 1 : baseHeight);
end

end