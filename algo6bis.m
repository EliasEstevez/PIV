%algo6
function [T,P,TP,FSCORE,avg_FSCORE]=algo6bis(path_algos,path_mascaras_creadas,path_Imges,path_IdealMasks)
tic
cd(path_algos);
% Creamos la carpeta auxiliar con el nombre cada imagen, en un formato '.txt' el cual contiene el numero de dedos detectados.
mkdir(path_mascaras_creadas,'Fingers');   
dir_fingers= convertCharsToStrings(strcat(path_mascaras_creadas,'\Fingers'));
dir_ima=convertCharsToStrings(path_Imges);
% Creamos la carpeta donde guardaremos las mascaras generadas. 
mkdir(path_mascaras_creadas,'MASKS');
dir_MASKS=convertCharsToStrings(strcat(path_mascaras_creadas,'\MASKS'))
dir_maskval =convertCharsToStrings(path_IdealMasks);
% Creamos la carpeta donde guardaremos los recortes de los dedos detectados en las mascaras 
mkdir(path_mascaras_creadas,'Recortes');
dir_recortes = convertCharsToStrings(strcat(path_mascaras_creadas,'\Recortes'));
%Como nos encotraremos seis posibles casos en cuanto a los numeros de dedos mostrados,
%creamos vectores para asi poder valorar la eficacia a la hora de detectar
%los dedos mostrados.
T = zeros(1,6); Tmask = 0;
P = zeros(1,6); Pmask = 0;
TP = zeros(1,6); TPmask = 0;
FSCORE = zeros(1,6);
matriz = zeros(6,6);
%Hacemos la busqueda de las imagenes que hay en las carpetas
filenames = dir(fullfile(dir_ima,'*.jpg')); 
mask_ideal_names = dir(fullfile(dir_maskval,'*.bmp'));

total_images = numel(filenames); %Conteo de numero de imagenes que hay en la carpeta

for n=1:total_images
    
    %Proceso de selección de imagen y su conversión a matriz YCBCR
    mv=fullfile(dir_maskval,mask_ideal_names(n).name);
    filename_maskval= filenames(n).name;
    maskval = imread(mv);
    f=fullfile(dir_ima,filenames(n).name);
    filename= filenames(n).name;
    our_images = imread(f);
    our_images_ycbcr = rgb2ycbcr(our_images);
    MASK = algo2bis(our_images_ycbcr,path_algos); %Creamos la mascara de la imagen  
    [numberOfFingers,fingers,maskv] = algo5(MASK,n,filename); % Detección de dedos
    
    %Proceso para registrar y valorar el numero de dedos detectados
    
    g=fullfile(dir_MASKS, filename);
    gc = strrep(g, 'jpg','bmp');
    
    name_finger = [dir_recortes,'\',filename];
    name_ima_fingers = fullfile(dir_recortes, name_finger{3});
    imwrite (fingers,name_ima_fingers);
    nametxt = strrep( filename, 'jpg','txt');
    imwrite(MASK,gc);
    
    [FSCOREmask,Tmask,Pmask,TPmask] = maskFSCORE(maskval,1-maskv,Tmask,Pmask,TPmask);
    numero_real_dedos = str2double(extractBetween(filename,1,1));
    matriz(numberOfFingers+1,numero_real_dedos+1) = matriz(numberOfFingers+1,numero_real_dedos+1) + 1;

    FSCORE(numero_real_dedos+1) = algo7(matriz,numero_real_dedos+1,TP,T,P);
   
    
    Finger =fopen(fullfile(dir_fingers,nametxt),'w');
    fprintf(Finger,'%i\n',numberOfFingers');
    
    fclose(Finger);
end

%Finalemnte evaluamos el sistema haciendo la media total de la seis
%'FSCORE'

avg_FSCORE = (FSCORE(1)+FSCORE(2)+FSCORE(3)+FSCORE(4)+FSCORE(5)+FSCORE(6))/6;

toc