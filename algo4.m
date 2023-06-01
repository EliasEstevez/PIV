cd('C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1')

% Nos quedamos con el path de imágenes/máscaras a analizar y con el de máscaras a generar:
img_dir="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Images";
imgNames = dir(fullfile(img_dir,'*.jpg'));
ideal_msk_dir="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\Masks-Ideal";
idmskNames = dir(fullfile(ideal_msk_dir,'*.bmp'));
msk_dir="C:\Users\Administrador\OneDrive - Universitat Politècnica de Catalunya\2022-2023 q1\PIV\LAB\Project\Project1\Project1\DataBase Train-Valid Prog 1 i 2\DataBase Train-Valid Prog 1  i  2\Training-Dataset\OurMasks";
mskNames = dir(fullfile(msk_dir,'*.bmp'));

tot_ima = numel(idmskNames);
P = 0;                                      % Contador de 'positives'
T = 0;                                      % Contador de 'trues'
TP = 0;                                     % Contador de 'true positives'
N = 0;                                      % Contador de 'negatives'

for n=1:tot_ima

    idmsk_file = fullfile(ideal_msk_dir,idmskNames(n).name);
    msk_file = fullfile(msk_dir, idmskNames(n).name);
    idealmsk = imread(idmsk_file);
    ourmsk = imread(msk_file);              % Guardamos en una variable la máscara ideal y la generada para compararlas
    
    for i = 1 : size(idealmsk,1)
        for j = 1 : size(idealmsk,2)
            if( ourmsk(i,j) == 0) P = P+1;                  % Aumentamos los 'Positive' en caso de píxel generado negro
            else N = N+1;                                   % En caso contrario aumentamos los 'Negatives'
            end
            if( idealmsk(i,j) == 0) T = T+1; end            % Aumentamos los 'True' en caso de píxel ideal negro
            if( idealmsk(i,j) == ourmsk(i,j)) 
                if(idealmsk(i,j) == 0) TP = TP+1; end       % Aumentamos los 'True Positive' si los píxeles coinciden a negro
            end
        end
    end      
end

precision = TP/P;
recall = TP/T;
Fscore = 2 * ((precision*recall)/(precision+recall));       % Finalmente calculamos la Fscore con los parámetros obtenidos
