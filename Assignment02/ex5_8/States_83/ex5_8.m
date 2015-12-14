clear all;
import brml.*

load noisystring;

% noisystring = noisystring(1:100);

% Get transition and emission matrices
A = getTransition();
B = getEmission();

% initial state
% ph1 = condp(ones(1,1)); % uniform first hidden state distribution
ph1 = ones(1,1);
ph1 = [ph1; zeros(82,1)];

% transform initial noisy string to numbers
v = zeros(length(noisystring),1);
for i = 1:length(noisystring)
    v(i) = letter2num(noisystring(i));
end;    
clear i;

% Use viterbi algorithm to find max state
[viterbi_maxstate logprob]=HMMviterbi(v',A,ph1,B); % most likely joint state

% Print decoded string
decoded = '';
for j = 1:length(viterbi_maxstate)
    decoded(j) = num2letter(getNum(viterbi_maxstate(j)));
end;
disp(decoded);

% Put names in a cell_array
cell_names = {};
j=1;
name = '';
for state = viterbi_maxstate
    if state>1 && state<24
        name = [name num2letter(getNum(state))];
    else
        if ~isempty(name)>0
            cell_names{j} = name;
            j = j+1;
            name = '';
        end;
    end;
end;

% Put surnames in a cell_array
cell_surnames = {};
j=1;
name = '';
for state =  viterbi_maxstate
    if state>24
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

% Calculate matrix m
m = zeros(5,7);
for i = 1:size(names,1)
    m(getIndexFirst(names{i,1}),getIndexLast(names{i,2})) =...
        m(getIndexFirst(names{i,1}),getIndexLast(names{i,2}))+1;
end;
clear i;
disp(m);