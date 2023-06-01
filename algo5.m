function [numberOfFingers,BW3,maskv] = algo5(maskv,i,name)
%Este algoritmo nos permite contar el numero de dedos que contiene cada
%imagen pasada como parametro 

    CC = bwconncomp(1-maskv);
    S = regionprops(CC, 'Area');
    L = labelmatrix(CC); 
    BW2 = ismember(L, find([S.Area] >= 5000));
    SE = strel('rectangle',[5 5]);
    maskv=imclose(BW2,SE);
    SHnueva = strel('rectangle',[45 65]);
    SLnueva = strel('rectangle',[50 25]);
    
    dim_larga = [604,400];
    tf = isequal(size(maskv),dim_larga);
    
    if tf==1
    JP = imopen(maskv,SLnueva);
        dedos = maskv - JP;
    else 
    
    JP = imopen(maskv,SHnueva);
    dedos = maskv - JP;
    end

    SU = strel('rectangle',[3 3]);
    dedosv2 = imopen(dedos, SU);
    BW3 = bwareaopen(dedosv2, 700);
    L = bwlabel(BW3);
    numberOfFingers = max(max(L));

    if(numberOfFingers > 5) 
       numberOfFingers = 5; 
    end

end

