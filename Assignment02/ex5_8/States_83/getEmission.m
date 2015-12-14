function B = getEmission()
    B = ones(26,83)*0.028;
    B(:,1) = 0.038461538;
    B(:,24) = 0.038461538;
    for i = 2:83
        if i~=24
            B(getNum(i),i) = 0.3;
        end;
    end;
end