function [FSCORE,T,P,TP] = maskFSCORE(maskval,maskv,T,P,TP)

for l = 3 : size(maskval,1)
        for m= 1 : size(maskval,2)
            if maskv(l,m) == 0
                P=P+1;
            end
            if maskval(l,m) == 0
                T=T+1;
            end
            if maskv(l,m) == 0 && maskval(l,m)== 0
                TP=TP+1;
            end
        end
end
    
RECALLTOT = TP/T;
PRECTOT = TP/P;
FSCORE = 2*(RECALLTOT*PRECTOT)/(RECALLTOT+PRECTOT);

end

