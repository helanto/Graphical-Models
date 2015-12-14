clear all;
import brml.*

load noisystring;

% noisystring = noisystring(1:100);

A = getTransition();
B = getEmission();

ph1 = condp(ones(26,1)); % uniform first hidden state distribution
ph1 = [ph1; zeros(107,1)];

v = zeros(length(noisystring),1);
for i = 1:length(noisystring)
    v(i) = letter2num(noisystring(i));
end;    
clear i;

[viterbi_maxstate logprob]=HMMviterbi(v',A,ph1,B); % most likely joint state

decoded = '';
for j = 1:length(viterbi_maxstate)
    decoded(j) = num2letter(getNum(viterbi_maxstate(j)));
end;
disp(decoded);


cell_names = {};
j=1;
name = '';
for state = viterbi_maxstate
    if state>26 && state<49
        name = [name num2letter(getNum(state))];
    else
        if ~isempty(name)>0
            cell_names{j} = name;
            j = j+1;
            name = '';
        end;
    end;
end;

cell_surnames = {};
j=1;
name = '';
for state =  viterbi_maxstate
    if state>74
        name = [name num2letter(getNum(state))];
    else
        if ~isempty(name)>0
            cell_surnames{j} = name;
            j = j+1;
            name = '';
        end;
    end;
end;

cell_names = cell_names(1:size(cell_surnames,2));
cell_names = [cell_names ; cell_surnames];
names = cell_names';
clear j; clear name; clear state; clear decoded;
clear cell_surnames; clear cell_names;

m = zeros(5,7);
for i = 1:size(names,1)
    m(getIndexFirst(names{i,1}),getIndexLast(names{i,2})) =...
        m(getIndexFirst(names{i,1}),getIndexLast(names{i,2}))+1;
end;
clear i;
disp(m);
%% SUMPRODUCT ALGORITHM

% T = length(noisystring);
% hh=1:T; vv=T+1:2*T;
% empot=array([vv(1) hh(1)],B);
% prior=array(hh(1),ph1);
% pot{1} = multpots([setpot(empot,vv(1),v(1)) prior]);
% for t=2:T
%     tranpot=array([hh(t) hh(t-1)],A);
%     empot=array([vv(t) hh(t)],B);
%     pot{t} = multpots([setpot(empot,vv(t),v(t)) tranpot]);
% end
% FG = FactorGraph(pot);
% 
% [maxstate maxvalpot mess]=maxprodFG(pot,FG);
% 
% decoded = '';
% for j = 1:length(maxstate)
%     decoded(j) = num2letter(getNum(maxstate(j)));
% end;
% disp(decoded);
% 
% for i =1:length(viterbi_maxstate)
%     if viterbi_maxstate(i) ~= maxstate(i)
%         disp(i);
%         disp(num2letter(getNum(maxstate(i))));
%         disp(num2letter(getNum(viterbi_maxstate(i))))
%     end;
% end;