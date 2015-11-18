import brml.*

% Variable declaration
p1 = 1; p2 = 2; p3 = 3; p4 = 4; %players
g12 = 5; g23 = 6; g13 = 7; g34 =8; g14 = 9;
% where gk_ij is the k_th game between player i and player j

% Values
skill = 1:10; %skills
w = 1; l = 2;   %result
ww =1; wl = 2; ll =3;
www =1; wwl =2; wll = 3; lll = 4;

% Variables domain and name
variable(p1).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p1).name = 'Player A';

variable(p2).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p2).name = 'Player B';

variable(p3).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p3).name = 'Player C';

variable(p4).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p4).name = 'Player D';

variable(g12).domain = {'Win Win','Win Loss','Loss Loss'};
variable(g12).name = 'Outcome A - B';

variable(g23).domain = {'Win Win','Win Loss','Loss Loss'};
variable(g23).name = 'Outcome B - C';

variable(g13).domain = {'Win Win Win','Win Win Loss','Win Loss Loss','Loss Loss Loss'};
variable(g13).name = 'Outcome A - C';

variable(g34).domain = {'Win Win','Win Loss','Loss Loss'};
variable(g34).name = 'Outcome C - D';

variable(g14).domain = {'Win','Loss'};
variable(g14).name = 'Outcome A - D';

% p(p1), p(p2), p(p3), p(p4)
pot{p1} = array(p1);
pot{p2} = array(p2);
pot{p3} = array(p3);
pot{p4} = array(p4);
for i = skill
    pot{p1}.table(i)=0.1;
    pot{p2}.table(i)=0.1;
    pot{p3}.table(i)=0.1;
    pot{p4}.table(i)=0.1;
end;
clear i;

out_table2 = zeros(length(skill),length(skill),2);
out_table3 = zeros(length(skill),length(skill),3);
out_table4 = zeros(length(skill),length(skill),4);
for s1 = skill
    for s2 = skill
        probab = prob(s1,s2);
        out_table2(s1,s2,w) = probab;
        out_table2(s1,s2,l) = 1 -out_table2(s1,s2,w);
        
        out_table3(s1,s2,ww) = probab*probab;
        out_table3(s1,s2,wl) = 2*probab*(1-probab);
        out_table3(s1,s2,ll) = (1-probab)*(1-probab);
        
        out_table4(s1,s2,www) = probab*probab*probab;
        out_table4(s1,s2,wwl) = 3*probab*probab*(1-probab);
        out_table4(s1,s2,wll) = 3*probab*(1-probab)*(1-probab);
        out_table4(s1,s2,lll) = (1-probab)*(1-probab)*(1-probab);
    end;
end;
clear s1;
clear s2;

% p(g12|p1,p2)
pot{g12} = array([p1 p2 g12]);
pot{g12}.table = out_table3;

% p(g23|p2,p3)
pot{g23} = array([p2 p3 g23]);
pot{g23}.table = out_table3;

% p(g13|p1,p3)
pot{g13} = array([p1 p3 g13]);
pot{g13}.table = out_table4;

% p(g34|p3,p4)
pot{g34} = array([p3 p4 g34]);
pot{g34}.table = out_table3;

% p(g14|p1,p4)
pot{g14} = array([p1 p4 g14]);
pot{g14}.table = out_table2;
clear out_table2;
clear out_table3;
clear out_table4;

% jointpot = p(g1_12, g2_12, g1_23, g2_23, g1_13, g2_13, g3_13, g1_34, g2_34, g1_14, p1, p2, p3, p4)
jointpot = multpots(pot([g12 g23 g13 g34 g14 p1 p2 p3 p4]));

% p_g14 = p(g14)
p_g14 = sumpot(jointpot,[g12 g23 g13 g34 p1 p2 p3 p4]);

% p_g14Loss = p(g14 = l)
p_g14Loss = setpot(p_g14,g14,l);

disp(['p(D winning A) = ' num2str(p_g14Loss.table)]);

% p_games = p(g12 g23 g13 g34 g14)
p_games = sumpot(jointpot,[p1 p2 p3 p4]);   %marginalise over p1 p2 p3 p4

% p_games_wo_g14 = p(g12 g23 g13 g34 g14)
p_games_wo_g14 = sumpot(jointpot,[g14 p1 p2 p3 p4]);

% p_games_set = p_games(g12 = ww, g23 = ww, ... , g14 =l)
p_games_set = setpot(p_games,[g12 g23 g13 g34 g14],[ww ww wwl ww l]);

% p_games_wo_g14_set = p_games_wo_g1_14(g12 = ww, g23 = ww, ... ,34 = ww)
p_games_wo_g14_set = setpot(p_games_wo_g14,[g12 g23 g13 g34],[ww ww wwl ww]);

% p(g14 = l|games)
p_g14Loss_given_games = divpots(p_games_set,p_games_wo_g14_set);

disp(['p(D winning A|outcome of all games) = ' num2str(p_g14Loss_given_games.table)]);

% jointpot_wo_g14 = p(g12, g23, g13, g34, p1, p2, p3, p4)
jointpot_wo_g14 = sumpot(jointpot,g14);

% p_p1p2p3p4_games_set = p(g12 = ww, g23 = ww,..., g34 = ww, p1, p2, p3, p4)
p_p1p2p3p4_games_set = setpot(jointpot_wo_g14,[g12 g23 g13 g34],[ww ww wwl ww]);

% p(p1,p2,p3,p4|g12 = ww, g23=ww, g13= wwl, g34 = ww)
p_p1p2p3p4_given_games = divpots(p_p1p2p3p4_games_set,p_games_wo_g14_set);

% p(p1|g12 = ww, g23=ww, g13= wwl, g34 = ww)
p1_given_games = sumpot(p_p1p2p3p4_given_games,[p2 p3 p4]); %marginalising
% p(p2|g12 = ww, g23=ww, g13= wwl, g34 = ww)
p2_given_games = sumpot(p_p1p2p3p4_given_games,[p1 p3 p4]);
% p(p3|g12 = ww, g23=ww, g13= wwl, g34 = ww)
p3_given_games = sumpot(p_p1p2p3p4_given_games,[p1 p2 p4]);
% p(p4|g12 = ww, g23=ww, g13= wwl, g34 = ww)
p4_given_games = sumpot(p_p1p2p3p4_given_games,[p1 p2 p3]);

% disp('p(A|outcome of all games) :');
% disp(p1_given_games.table);
% 
% disp('p(B|outcome of all games) :');
% disp(p2_given_games.table);
% 
% disp('p(C|outcome of all games) :');
% disp(p3_given_games.table);
% 
% disp('p(D|outcome of all games) :');
% disp(p4_given_games.table);

disp(['Expected skill level of A: ' num2str(expected(p1_given_games.table))]);
disp(['Expected skill level of B: ' num2str(expected(p2_given_games.table))]);
disp(['Expected skill level of C: ' num2str(expected(p3_given_games.table))]);
disp(['Expected skill level of D: ' num2str(expected(p4_given_games.table))]);

% disptable(p1_given_games,variable);
% disptable(p2_given_games,variable);
% disptable(p3_given_games,variable);
% disptable(p4_given_games,variable);