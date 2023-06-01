
%ubicación inicial(donde esta el conjunto de algoritmos)
path_inicial="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1";
%carpeta_imagenes=uigetdir;      % Con esto el usuario nos indica la carpeta de imágenes que desea abrir
%carpeta_mascaras=uigetdir;      % De igual forma pedimos al usuario indicar la carpeta de máscaras
% Cargamos las imágenes:
carpeta_imagenes="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Images";      % Con esto el usuario nos indica la carpeta de imágenes que desea abrir
carpeta_mascaras="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Masks-Ideal";      % De igual forma pedimos al usuario indicar la carpeta de máscaras

cd(carpeta_imagenes);                           % Nos ubicamos en el path
imagefiles = dir('*.jpg');    
nfiles = length(imagefiles);                    % Cantidad de imágenes

for ii=1:nfiles                                 % Lectura de las imágenes para posterior escritura sobre un vector
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   ima{ii} = currentimage;
end

% Repetimos el proceso para las máscaras:
cd(carpeta_mascaras);
imagefiles_m = dir('*.bmp');    
nfiles_m = length(imagefiles);
for ii=1:nfiles_m
   currentfilename_m = imagefiles_m(ii).name;
   currentimage_m = imread(currentfilename_m);
   mask{ii} = currentimage_m;
end

% Sumamos el croma con el objetivo de crear el hisograma del conjunto:
aux=1;
for i=1:nfiles                                  % Iterando sobre todas las posiciones del vector
    ima1a=ima(i);
    mask1a=mask(i);
    ima1=ima1a{1,1}; ima1=double(ima1)/255;
    mask1=mask1a{1,1};
    ima1(:,:,1)=ima1(:,:,1).*(1-mask1);         % Multiplicamos la imágen por la máscara invertida
    ima1(:,:,2)=ima1(:,:,2).*(1-mask1);
    ima1(:,:,3)=ima1(:,:,3).*(1-mask1);
    YCBCR = rgb2ycbcr(ima1);                    % Convertimos nuestra imagen RGB al espacio YCBCR
    CB = YCBCR(:,:,2); CB = [CB(:)];
    CR = YCBCR(:,:,3); CR = [CR(:)];            % Nos quedamos únicamente con las componentes CB y CR
    
    if(aux==1)
        TCB=CB;
        TCR=CR;
    else
        TCB=[TCB;CB];                           % Concatenamos todos los valores de las distintas imágenes
        TCR=[TCR;CR];
    end
    
    aux=aux+1;
    
end

valor_mas_repetido_i=mode(TCB);
valor_mas_repetido_m=mode(TCR);
TCB(TCB==valor_mas_repetido_i)=[];
TCR(TCR==valor_mas_repetido_m)=[];              % Eliminamos el valor que más se repite (píxeles de no piel)

CBCR = [TCB,TCR];
figure(2);
hist3(CBCR,'CDataMode','auto','FaceColor','interp','Nbins',[60 60]);                                    % Creamos el histograma de píxeles de piel
title("HISTOGRAMA PIEL")
xlabel('CB')
ylabel('CR')
cd(path_inicial);

