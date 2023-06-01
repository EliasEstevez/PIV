%Inicializamos pidiendole al usuario que indique los 'paths' necesarios,
%el primero para ubicar donde se encuentran los 'algos' para poder
%ejecutarlos de manera interumpida( ya que unos dependen de otros), el siguiente lo pediremos
%para tener la ubicación de donde guardaremos las carpetas creadas(MAKS,Recortes y Fingers), 
%finalmente le pediremos que nos indique la carpeta donde se encuentran
%todas las imagenes y sus mascaras ideales.

disp("Seleccione la carpeta donde se encuentran los algoritmos: ")
path_algos=uigetdir;

disp("Seleccione la carpeta general donde quiere guardar la carpeta de las mascaras creadas: ")
path_mascaras_creadas=uigetdir;

disp("Seleccione la carpeta que contenga las imagenes a utilizar: ")
path_Imges=uigetdir;

disp("Seleccione la carpeta que contenga las mascaras ideales iniciales: ")
path_IdealMasks=uigetdir;

%Finalmente hemos decidido que el algo6_bis devolvera datos interesantes
%para la evaluación del sistema desarrollado.   
[T,P,TP,FSCORE,avg_FSCORE]=algo6bis(path_algos,path_mascaras_creadas,path_Imges,path_IdealMasks);
disp("El FSCORE total es = "+avg_FSCORE);