function exp = expected(x)
    exp = 0;
    for i = 1:length(x)
        exp = exp+x(i)*i;
    end;
end