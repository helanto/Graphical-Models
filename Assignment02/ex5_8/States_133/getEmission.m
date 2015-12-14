function B = getEmission()
    B = ones(26,133)*0.028;
    for i = 1:133
        B(getNum(i),i) = 0.3;
    end;
end