function res = myDirac(w1,w2,d,eA,eB)
% myDirac - returns 1 if w1 is the closest number to expected wealth
    profit = w2*(d*(1+eA)+(1-d)*(1+eB));
    res = abs(profit-w1)<0.1;
    % If expected wealth is more than 5.1 and w1 = 5.0
    % give value 1.0 in order to keep distribution consistent
    if profit>=5.1 && w1==5.0
        res = 1;
    end;
end