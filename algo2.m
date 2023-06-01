function [mask2] = algo2(img)

cd('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1')

[numRows, numColsRGB] = size(img);
numCols = numColsRGB / 3;
mask2 = zeros(numRows, numCols);    % Creamos una matriz de ceros del mismo tamaño que la imagen pasada por el usuario
image = rgb2ycbcr(img);             % Convertimos la imagen de referencia a YCBCR

% Intentamos pasar los valores máximos y mínimos encontrados con el algo1 sin éxito:
% CBCR2 = algo1();
% maxCB = max(CBCR2(:,1)); maxCB = maxCB*255;
% minCB = min(CBCR2(:,1)); minCB = minCB*255;
% maxCR = max(CBCR2(:,2)); maxCR = maxCR*255;
% minCR = min(CBCR2(:,2)); minCR = minCR*255;


for i = 1 : size(img,1)             % Los valores máximos/mínimos son los encontrados a partir de las imágenes de Training
        for j = 1 : size(img,2)

            if (image(i,j,2) >= 125 || image(i,j,2) <= 108 || image(i,j,3) >= 159 || image(i,j,3) <= 134)
                mask2(i,j) = 1;
            else 
                mask2(i,j) = 0;     % Ponemos a 0 los píxeles dentro del rango encontrado (píxeles de piel)
            end
        end
end

imshow(mask2);