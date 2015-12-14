function [dec val] = optdec(epsilonA1,epsilonB1,desired,T,w1,pars)
import brml.*

% A = transition matrxi p(w_t+1|w_t,eA_t+1,eB_t+1,d_t)
A= zeros(length(pars.WealthValue),length(pars.WealthValue),...
    length(pars.epsilonAval),length(pars.epsilonBval),length(pars.DecisionValue));
for epsA = 1:length(pars.epsilonAval)
    for epsB = 1:length(pars.epsilonBval)
        for wT = 1:length(pars.WealthValue)
            for wT1 = 1:length(pars.WealthValue)
                for d = 1:length(pars.DecisionValue)
                    A(wT1,wT,epsA,epsB,d) = myDirac(pars.WealthValue(wT1),pars.WealthValue(wT),...
                        pars.DecisionValue(d),pars.epsilonAval(epsA),...
                        pars.epsilonBval(epsB));
                end;
            end;
        end;
    end;
end;

% Utility vector
Utility = (pars.WealthValue>desired)*10000';
% eA and eB transition matrices
Am = pars.epsilonAtran;
Bm = pars.epsilonBtran;

% Set variables to each number
[wT w epsAT epsBT d epsA epsB] = assign(1:7);
% wT = 1; w = 2; epsAT = 3; epsBT = 4;
% d = 5; epsA = 6; epsB = 7; ut = 8;

% create brml arrays, binding variables to matrices dimensions
tranpot=array([wT w epsAT epsBT d],A);
Atran = array([epsAT epsA],Am);
Btran = array([epsBT epsB],Bm);
utilitypot = array(wT,Utility);

% First decision - use utility vector
[message_pot move] = maxpot(sumpot(multpots([tranpot Atran Btran utilitypot]),[wT epsAT epsBT]),d);
% Send message from the end to the beginning
for iter = 1:T-1
    old_table = message_pot.table;
    % message message_old in order to calculate the new message
    message_old = array([wT epsAT epsBT],old_table);
    [message_pot move] = maxpot(sumpot(multpots([tranpot Atran Btran message_old]),[wT epsAT epsBT]),d);
end;
% calculate val
val = setpot(message_pot,[w,epsA,epsB],[find(pars.WealthValue==w1),epsilonA1,epsilonB1]);
val = val.table;
% message_pot.table(6,1,1)
% and optimal decision
dec = move(find(pars.WealthValue==w1));
end
