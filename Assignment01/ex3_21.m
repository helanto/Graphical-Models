import brml.*

% Variable declaration
p1 = 1; p2 = 2; p3 = 3; p4 = 4; %players
g1_12 = 5; g2_12 = 6; g1_23 = 7; g2_23 = 8;
g1_13 = 9; g2_13 = 10; g3_13 = 11; g1_34 =12; g2_34 = 13; g1_14 = 14;   %games
% where gk_ij is the k_th game between player i and player j

% Values
skill = 1:10; %skills
w = 1; l = 2;   %result

% Variables domain and name
variable(p1).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p1).name = 'Player A';

variable(p2).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p2).name = 'Player B';

variable(p3).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p3).name = 'Player C';

variable(p4).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p4).name = 'Player D';

variable(g1_12).domain = {'Win','Loss'};
variable(g1_12).name = 'Outcome A - B';

variable(g2_12).domain = {'Win','Loss'};
variable(g2_12).name = 'Outcome A - B';

variable(g1_23).domain = {'Win','Loss'};
variable(g1_23).name = 'Outcome B - C';

variable(g2_23).domain = {'Win','Loss'};
variable(g2_23).name = 'Outcome B - C';

variable(g1_13).domain = {'Win','Loss'};
variable(g1_13).name = 'Outcome A - C';

variable(g2_13).domain = {'Win','Loss'};
variable(g2_13).name = 'Outcome A - C';

variable(g3_13).domain = {'Win','Loss'};
variable(g3_13).name = 'Outcome A - C';

variable(g1_34).domain = {'Win','Loss'};
variable(g1_34).name = 'Outcome C - D';

variable(g2_34).domain = {'Win','Loss'};
variable(g2_34).name = 'Outcome C - D';

variable(g1_14).domain = {'Win','Loss'};
variable(g1_14).name = 'Outcome A - D';

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

out_table = zeros(length(skill),length(skill),2);
for s1 = skill
    for s2 = skill
        out_table(s1,s2,w) = prob(s1,s2);
    end;
end;
out_table(:,:,l) = 1 - out_table(:,:,w);
clear s1;
clear s2;

% p(g1_12|p1,p2)
pot{g1_12} = array([p1 p2 g1_12]);
pot{g1_12}.table = out_table;

% p(g2_12|p1,p2)
pot{g2_12} = array([p1 p2 g2_12]);
pot{g2_12}.table = out_table;

% p(g1_23|p2,p3)
pot{g1_23} = array([p2 p3 g1_23]);
pot{g1_23}.table = out_table;

% p(g2_23|p2,p3)
pot{g2_23} = array([p2 p3 g2_23]);
pot{g2_23}.table = out_table;

% p(g1_13|p1,p3)
pot{g1_13} = array([p1 p3 g1_13]);
pot{g1_13}.table = out_table;

% p(g2_13|p1,p3)
pot{g2_13} = array([p1 p3 g2_13]);
pot{g2_13}.table = out_table;

% p(g3_13|p1,p3)
pot{g3_13} = array([p1 p3 g3_13]);
pot{g3_13}.table = out_table;

% p(g1_34|p3,p4)
pot{g1_34} = array([p3 p4 g1_34]);
pot{g1_34}.table = out_table;

% p(g2_34|p3,p4)
pot{g2_34} = array([p3 p4 g2_34]);
pot{g2_34}.table = out_table;

% p(g1_14|p1,p4)
pot{g1_14} = array([p1 p4 g1_14]);
pot{g1_14}.table = out_table;
clear out_table;

% jointpot = p(g1_12, g2_12, g1_23, g2_23, g1_13, g2_13, g3_13, g1_34, g2_34, g1_14, p1, p2, p3, p4)
jointpot = multpots(pot([g1_12 g2_12 g1_23 g2_23 g1_13 g2_13 g3_13 g1_34 g2_34 g1_14 p1 p2 p3 p4]));

% p_g1_14 = p(g1_14)
p_g1_14 = sumpot(jointpot,[g1_12 g2_12 g1_23 g2_23 g1_13 g2_13 g3_13 g1_34 g2_34 p1 p2 p3 p4]);

% p_g1_14_l = p(g1_14 = l)
p_g1_14_l = setpot(p_g1_14,g1_14,l);

disp(['p(D winning A) = ' num2str(p_g1_14_l.table)]);

% p_games = p(g1_12, g2_12, g1_23, g2_23, g1_13, g2_13, g3_13, g1_34, g2_34, g1_14)
p_games = sumpot(jointpot,[p1 p2 p3 p4]);   %marginalise over p1 p2 p3 p4

% p_games_wo_g1_14 = p(g1_12, g2_12, g1_23, g2_23, g1_13, g2_13, g3_13, g1_34, g2_34)
p_games_wo_g1_14 = sumpot(jointpot,[g1_14 p1 p2 p3 p4]);

% p_games_set = p_games(g1_12 = w, g2_12 = 2, ... , g1_14 = l)
p_games_set = setpot(p_games,[g1_12 g2_12 g1_23 g2_23 g1_13 g2_13 g3_13 g1_34 g2_34 g1_14],[w w w w w w l w w l]);

% p_games_wo_g1_14_set = p_games_wo_g1_14(g1_12 = w, g2_12 = 2, ... ,g2_34 = w)
p_games_wo_g1_14_set = setpot(p_games_wo_g1_14,[g1_12 g2_12 g1_23 g2_23 g1_13 g2_13 g3_13 g1_34 g2_34],[w w w w w w l w w]);

% p_g1_14_l = p(g1_14 = l|games)
p_g1_14_l_given_games = divpots(p_games_set,p_games_wo_g1_14_set);

disp(['p(D winning A|outcome of all games) = ' num2str(p_g1_14_l_given_games.table)]);