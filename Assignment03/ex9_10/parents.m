function p = parents(k)
    if k>2
        p = 1 + combn(k-1,1) + combn(k-1,2);
    elseif k>1
        p = 2;
    else
        p = 1;
    end;
end