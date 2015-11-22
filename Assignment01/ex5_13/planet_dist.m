function res  = planet_dist(x1,x2)
    res = sqrt(sum((x1-x2).^2));
end