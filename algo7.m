function FSCORE = algo7(matriu,number,TP,T,P)

% Este script calcula el fscore medio, precision, recall para cada uno
% de los numeros, a parte de una accuracy generica
%
% fscore = vector de 6 posiciones, en cada una el fscore individual de cada
% numero de dedos (0,1,2,3,4 y 5)
% precision = vector de 6 posiciones, en cada una la precision
% individual de cada numero de dedos (0,1,2,3,4 y 5)
% recall = vector de 6 posiciones, en cada una la recall individual de 
% cada numero de dedos (0,1,2,3,4 y 5)

TP(number) = matriu(number,number);
            
            for i = 1 : size(matriu,1)
            P(number) = P(number) + matriu(number, i); 
            T(number) = T(number) + matriu(i,number);        
            end
            
Recall = (TP(number)/T(number));
Precision = TP(number)/P(number);
FSCORE = 2*(Recall*Precision)/(Recall+Precision);

end
