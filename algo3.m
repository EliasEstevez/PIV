clc;
clear;

cd('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1')

ima_dir="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Images";
imaNames = dir(fullfile(ima_dir,'*.jpg'));          % Nos quedamos con el path de imágenes a analizar
mkdir('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\','OurMasks');% Creamos la carpeta donde guardaremos las mascaras creadas
mask_dir="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\OurMasks";
maskNames = dir(fullfile(mask_dir,'*.bmp'));        % Creamos el path de máscaras generadas

total_images = numel(imaNames);                     % Guardamos el número de elementos (imágenes)

for n=1:total_images
    ima_file = fullfile(ima_dir,imaNames(n).name);
    mask_str = fullfile(mask_dir, imaNames(n).name);
    mask_file = strrep(mask_str,'jpg','bmp');       % Cogemos el mismo nombre que la imagen y cambiamos la extensión a bmp
    our_ima = imread(ima_file);                     % Leemos la imagen con nombre coincidente
    cd('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1');
    gen_mask = algo2(our_ima);                      % Generamos una máscara con algo2
    %gen_mask = algo2bis(our_ima);                   % Generamos una máscara con algo2bis
    imwrite(gen_mask,mask_file);                    % Guardamos dicha máscara en la carpeta OurMasks 
    
end
