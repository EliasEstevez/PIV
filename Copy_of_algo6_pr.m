%algo6
tic
% Creamos la carpeta auxiliar con el nombre cada imagen, en un formato '.txt' el cual contiene el numero de dedos detectados.
mkdir('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\','Fingers');   
dir_fingers = "C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Fingers";
dir_ima="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Images";
% Creamos la carpeta donde guardaremos las mascaras generadas. 
mkdir('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\','MASKS');
dir_MASKS="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\MASKS";
dir_maskval = "C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Masks-Ideal";
mkdir('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\','Recortes');
% Creamos la carpeta donde guardaremos los recortes de los dedos detectados en las mascaras 
dir_recortes = "C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Recortes";

T = zeros(1,6); Tmask = 0;
P = zeros(1,6); Pmask = 0;
TP = zeros(1,6); TPmask = 0;
FSCORE = zeros(1,6);
matriz = zeros(6,6);
filenames = dir(fullfile(dir_ima,'*.jpg'));
mask_ideal_names = dir(fullfile(dir_maskval,'*.bmp'));

total_images = numel(filenames);

for n=1:total_images
    
    
    mv=fullfile(dir_maskval,mask_ideal_names(n).name);
    filename_maskval= filenames(n).name;
    maskval = imread(mv);
    f=fullfile(dir_ima,filenames(n).name);
    filename= filenames(n).name;
    our_images = imread(f);
    our_images_ycbcr = rgb2ycbcr(our_images);
    MASK = algo2bis(our_images_ycbcr);
    [numberOfFingers,fingers,maskv] = algo5(MASK,n,filename);
    
    
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

avg_FSCORE = (FSCORE(1)+FSCORE(2)+FSCORE(3)+FSCORE(4)+FSCORE(5)+FSCORE(6))/6;
toc