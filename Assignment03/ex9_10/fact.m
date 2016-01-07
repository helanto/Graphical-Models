function p = fact(k)
    if k>1
        p = k*fact(k-1);
    else
        p = 1;
    end;
end