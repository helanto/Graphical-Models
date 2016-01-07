function c = combn(n,r)
    c = fact(n)/(fact(r)*(fact(n-r)));
end