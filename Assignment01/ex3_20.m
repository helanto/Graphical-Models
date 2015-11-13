import brml.*

% variable declaration
w = 1; h = 2; inc = 3;

% values
c1 = 1; c2 = 2; c3 = 3; c4 = 4; % cars
low = 1; hight = 2;             % income

variable(inc).domain = {'low','hight'};
variable(inc).name = 'Income';

variable(w).domain = {'1','2','3','4'};
variable(w).name = 'Wife';

variable(h).domain = {'1','2','3','4'};
variable(h).name = 'Husband';

% p(inc)
pot{inc} = array(inc);
pot{inc}.table(low)=0.9;
pot{inc}.table(hight)= 1- pot{inc}.table(low);

% p(w|inc)
pot{w} = array([w inc]);
w_inc_table(c1,low) = 0.7;
w_inc_table(c2,low) = 0.3;
w_inc_table(c3,low) = 0.0;
w_inc_table(c4,low) = 0.0;
w_inc_table(c1,hight) = 0.2;
w_inc_table(c2,hight) = 0.1;
w_inc_table(c3,hight) = 0.4;
w_inc_table(c4,hight) = 0.3;
pot{w}.table = w_inc_table;
clear w_inc_table;

% p(h|inc)
pot{h} = array([h inc]);
h_inc_table(c1,low) = 0.2;
h_inc_table(c2,low) = 0.8;
h_inc_table(c3,low) = 0.0;
h_inc_table(c4,low) = 0.0;
h_inc_table(c1,hight) = 0.0;
h_inc_table(c2,hight) = 0.0;
h_inc_table(c3,hight) = 0.3;
h_inc_table(c4,hight) = 0.7;
pot{h}.table = h_inc_table;
clear h_inc_table;

% joint distribution
jointpot = multpots(pot([w h inc]));

% marginal over inc
% p(h,w)
sum_inc = sum(jointpot,inc);
disp('p(w,h):');
disp(sum_inc.table);

% p(w)
w_dist = sum(jointpot,[h inc]);
% p(h)
h_dist = sum(jointpot,[w inc]);
% p(h)*p(w)
p_w_times_p_h = w_dist*h_dist;
disp('p(w) * p(h):');
disp(p_w_times_p_h.table);
% disptable(jointpot,variable);