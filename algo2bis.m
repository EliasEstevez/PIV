function [mask3] = algo2bis(img,path_algos)

%cd('C:\Users\Urbi\Desktop\Roger\UPC\3er\3B-PIV\Roger LAB')
%cd('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1')
cd(path_algos);
mask3 = zeros(size(img,1),size(img,2));     % Inicializamos la matriz de la mascara con semejante dimensión a la imagen de entrada, con valores a cero.

 for i = 1 : size(img,1)
        for j = 1 : size(img,2)

           if (img(i,j,2) >= 125 || img(i,j,2) <= 108|| img(i,j,3) >= 159 || img(i,j,3) <= 134 )
                mask3(i,j) = 1;
                
            else 
                mask3(i,j) = 0;
              
            end
        end
 end

SH = strel('rectangle',[5 33]);             % Creación de los elementos estructurales utilizados.
SL = strel('rectangle',[65 9]);
SLmin = strel('rectangle',[5 11]);

% dim_larga = [604,400];
tf = isequal(size(mask3),[604,400]);

CC = bwconncomp(1-mask3);                   % Buscamos las componentesque estan conectadas dentro de la mascara.
S = regionprops(CC, 'Area');
L = labelmatrix(CC);

if tf==1
    mask3=imopen(mask3,SL);
    
else 
    mask3 = ismember(L, find([S.Area] >= 20000));
    mask3 = 1-mask3;
    mask3=imclose(mask3,SH);

 end

end