import brml.*
table = [exp(1) 1 ; 1 exp(1)];

pot = cell(200,1);
ind = 1;
T = 10;
for var1=1:T^2
    for var2=var1+1:T^2
        if var2==var1+T
            %disp([num2str(var1),num2str(var2)]);
            pot(ind) = {array([var1 var2],table)};
            ind = ind+1;
        else
            if var2==var1+1 && not(mod(var1,T)==0)
                %disp([num2str(var1),num2str(var2)]);
                pot(ind) = {array([var1 var2],table)};
                ind = ind+1;
            end;
        end;
    end;
end;

pot=str2cell(setpotclass(pot,'array')); % convert to cell array 

[jtpot jtsep infostruct]=jtree(pot); % setup the Junction Tree

jtpot=absorption(jtpot,jtsep,infostruct); % do full round of absorption

t=sumpot(jtpot);
disp(log10(t{1}.table));