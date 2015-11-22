function res = probAdv(lA,lB,lC)
    sum = exp(lA - max(lB,lC)) + exp(lB - max(lA,lC)) + exp(lC - max(lB,lA));
    res = exp(lA - max(lB,lC))/sum;
end