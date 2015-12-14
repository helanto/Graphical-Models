function [dec val]=optdec(epsilonA1,epsilonB1,desired,T,w1,pars)
dyn = {};

for epAt = 1:length(pars.epsilonAval)
   for epBt = 1:length(pars.epsilonBval)
       for wt = 1:length(pars.WealthValue)

           decs=[];
           for dt = 1:5
               total = 0;
               for i = 1:length(pars.epsilonAval)
                   for j = 1:length(pars.epsilonBval)
                       for l = 1:length(pars.WealthValue)
                           delts = pars.WealthValue(l) - pars.WealthValue(wt)*(pars.DecisionValue(dt)*(1+pars.epsilonAval(i))+(1-pars.DecisionValue(dt))*(1+pars.epsilonBval(j)));
                           store = 0.5 * pars.epsilonBtran(j,epBt)* (abs(delts)<0.1) * (10000*(pars.WealthValue(l)>=1.5));
                           total = total + store;
                       end
                   end
               end
               decs = [decs total];
           end
           dyn{epAt,epBt,wt} = max(decs);
       end
   end
end

tsteps = 38;
for t = 1:tsteps
   for epAt = 1:length(pars.epsilonAval)
       for epBt = 1:length(pars.epsilonBval)
           for wt = 1:length(pars.WealthValue)

               decs=[];
               for dt = 1:5
                   total = 0;                
                   for i = 1:length(pars.epsilonAval)
                       for j = 1:length(pars.epsilonBval)
                           for l = 1:length(pars.WealthValue)
                               delts = pars.WealthValue(l) - pars.WealthValue(wt)*(pars.DecisionValue(dt)*(1+pars.epsilonAval(i))+(1-pars.DecisionValue(dt))*(1+pars.epsilonBval(j)));
                               store = 0.5 * pars.epsilonBtran(j,epBt) * (abs(delts)<0.1) * dyn{i,j,l};
                               total = total + store;
                           end
                       end
                   end
                   decs = [decs total];
               end
               dyn{epAt,epBt,wt} = max(decs);
           end
       end
   end
end

wt = find(pars.WealthValue== w1);
epAt = epsilonA1;
epBt = epsilonB1;
decs=[];
for dt = 1:5
   total = 0;                
   for i = 1:length(pars.epsilonAval)
       for j = 1:length(pars.epsilonBval)
           for l = 1:length(pars.WealthValue)
               delts = pars.WealthValue(l) - pars.WealthValue(wt)*(pars.DecisionValue(dt)*(1+pars.epsilonAval(i))+(1-pars.DecisionValue(dt))*(1+pars.epsilonBval(j)));
               store = 0.5 * pars.epsilonBtran(j,epBt) * (abs(delts)<0.1) * dyn{i,j,l};
               total = total + store;
           end
       end
   end
   decs = [decs total];
end
[val dec] = max(decs);
end