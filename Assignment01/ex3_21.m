import brml.*

% variable declaration
p1 = 1; p2 = 2; out = 3;

% values
skill = 1:10; %skills
w = 1; l = 2;   %result

variable(out).domain = {'Win','Loss'};
variable(out).name = 'Outcome';

variable(p1).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p1).name = 'Player A';

variable(p2).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5','Lvl 6','Lvl 7','Lvl 8','Lvl 9','Lvl 10'};
variable(p2).name = 'Player B';

pot{p1} = array(p1);
for i = skill
    pot{p1}.table(i)=0.1;
end

pot{p2} = array(p2);
for i = skill
    pot{p2}.table(i)=0.1;
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

% out_table(s1,s1,w) = prob(s1,s1);
% out_table(s2,s1,w) = prob(s2,s1);
% out_table(s1,s2,w) = prob(s1,s2);
% out_table(s2,s2,w) = prob(s2,s2);
% out_table(:,:,l) = 1 - out_table(:,:,w);

pot{out} = array([p1 p2 out]);
pot{out}.table = out_table;

jointpot = multpots(pot([out p1 p2]));

p_w_p1_p2 = setpot(jointpot,out,w);

p_out = sumpot(jointpot,[p1 p2]);
p_w = setpot(p_out,out,w);

p1p2 = divpots(p_w_p1_p2,p_w);