import brml.*

%variable declaration
gm = 1; rm = 2; aml = 3; nlm = 4; ir = 5; mv = 6; at = 7; ac = 8; cm = 9; pr = 10; bio = 11;   %courses
maths = 12; biology = 13; organisation = 14; writing = 15; programming = 16;     %skills

%values
have = 1; not_have = 2; %skill
pass = 1; fail = 2; %course results

variable(bio).domain = {'pass', 'fail'};
variable(bio).name = 'Bioinformatics';

variable(pr).domain = {'pass', 'fail'};
variable(pr).name = 'Project';

variable(gm).domain = {'pass', 'fail'};
variable(gm).name = 'Graphical Models';

variable(ir).domain = {'pass', 'fail'};
variable(ir).name = 'Information Retrieval';

variable(aml).domain = {'pass', 'fail'};
variable(aml).name = 'Applied Machine Learning';

variable(nlm).domain = {'pass', 'fail'};
variable(nlm).name = 'Graphical Models';

variable(rm).domain = {'pass', 'fail'};
variable(rm).name = 'Graphical Models';

variable(mv).domain = {'pass', 'fail'};
variable(mv).name = 'Graphical Models';

variable(at).domain = {'pass', 'fail'};
variable(at).name = 'Graphical Models';

variable(ac).domain = {'pass', 'fail'};
variable(ac).name = 'Graphical Models';

variable(cm).domain = {'pass', 'fail'};
variable(cm).name = 'Graphical Models';

variable(maths).domain = {'have', 'not_have'};
variable(maths).name = 'Maths';
variable(biology).domain = {'have', 'not_have'};
variable(biology).name= 'Biology';
variable(programming).domain = {'have', 'not_have'};
variable(programming).name= 'Programming';
variable(writing).domain = {'have', 'not_have'};
variable(writing).name= 'Writing';
variable(organisation).domain = {'have', 'not_have'};
variable(organisation).name= 'Organisation';

pot{maths} = array(maths);
pot{maths}.table(have) = 0.95;
pot{maths}.table(not_have) = 0.05;

pot{biology} = array(biology);
pot{biology}.table(have) = 0.3;
pot{biology}.table(not_have) = 0.7;

pot{writing} = array(writing);
pot{writing}.table(have) = 0.95;
pot{writing}.table(not_have) = 0.05;

pot{programming} = array(programming);
pot{programming}.table(have) = 0.8;
pot{programming}.table(not_have) = 0.2;

pot{organisation} = array(organisation);
pot{organisation}.table(have) = 0.7;
pot{organisation}.table(not_have) = 0.3;

% p(course | skills)
pot{pr} = array([pr, writing, organisation]);
pr_w_o(pass, have, have) = 0.99;
pr_w_o(pass, have, not_have) = 0.75;
pr_w_o(pass, not_have, have) = 0.75;
pr_w_o(pass, not_have, not_have) = 0.01;
pr_w_o(fail,:,:) = 1 - pr_w_o(pass,:,:);
pot{pr}.table = pr_w_o;

pot{bio} = array([bio, biology, writing]);
b_b_w(pass, have, have) = 0.99;
b_b_w(pass, have,not_have) = 0.75;
b_b_w(pass, not_have, have) = 0.75;
b_b_w(pass, not_have, not_have) = 0.01;
b_b_w(fail, :,:) = 1 - b_b_w(pass,:,:);
pot{bio}.table = b_b_w;

pot{gm} = array([gm, maths, programming]);
gm_m_p(pass, have, have) = 0.99;
gm_m_p(pass, have, not_have) = 0.75;
gm_m_p(pass, not_have, have) = 0.75;
gm_m_p(pass, not_have, not_have) = 0.01;
gm_m_p(fail, :,:) = 1 - gm_m_p(pass,:,:);
pot{gm}.table = gm_m_p;

pot{ir} = array([ir, programming]);
ir_p(pass, have) = 0.995;
ir_p(pass, not_have) = 0.005;
ir_p(fail, :) = 1 - ir_p(pass,:);
pot{ir}.table=ir_p;

pot{mv} = array([mv, maths]);
mv_m(pass, have) = 0.995;
mv_m(pass, not_have) = 0.005;
mv_m(fail, :) = 1 - mv_m(pass,:);
pot{mv}.table = mv_m;

pot{at} = array([at, maths]);
at_m(pass, have) = 0.995;
at_m(pass, not_have) = 0.005;
at_m(fail, :) = 1 - at_m(pass,:);
pot{at}.table = at_m;

pot{ac} = array([ac, writing]);
ac_w(pass, have) = 0.995;
ac_w(pass, not_have) = 0.005;
ac_w(fail, :) = 1 - ac_w(pass,:);
pot{ac}.table = ac_w;

pot{cm} = array([cm, maths]);
cm_m(pass, have) = 0.995;
cm_m(pass, not_have) = 0.005;
cm_m(fail,:) = 1 - cm_m(pass,:);
pot{cm}.table = cm_m;

pot{aml} = array([aml, maths, programming]);
aml_m_p(pass, have, have) = 0.99;
aml_m_p(pass, have, not_have) = 0.75;
aml_m_p(pass, not_have, have) = 0.75;
aml_m_p(pass, not_have, not_have) = 0.01;
aml_m_p(fail,:,:) = 1 - aml_m_p(pass,:,:);
pot{aml}.table = aml_m_p;

pot{rm} = array([rm, programming, organisation]);
rm_p_o(pass, have, have) = 0.99;
rm_p_o(pass, have, not_have) = 0.75;
rm_p_o(pass, not_have, have) = 0.75;
rm_p_o(pass, not_have, not_have) = 0.01;
rm_p_o(fail,:,:) = 1 - rm_p_o(pass,:,:);
pot{rm}.table = rm_p_o;

pot{nlm} = array([nlm, programming, maths]);
nlm_m_p(pass, have, have) = 0.99;
nlm_m_p(pass, have, not_have) = 0.75;
nlm_m_p(pass, not_have, have) = 0.75;
nlm_m_p(pass, not_have, not_have) = 0.01;
nlm_m_p(fail,:,:) = 1 - nlm_m_p(pass,:,:);
pot{nlm}.table = nlm_m_p;

jointpot = multpots(pot([gm rm nlm cm ac at mv ir aml bio pr maths organisation biology writing programming]));
sum_gm = sum(jointpot, [rm nlm cm ac at mv ir aml bio pr maths organisation biology writing programming]);
sum_rm = sum(jointpot, [gm nlm cm ac at mv ir aml bio pr maths organisation biology writing programming]);
sum_nlm =sum(jointpot, [gm rm cm ac at mv ir aml bio pr maths organisation biology writing programming]);
sum_cm =sum(jointpot, [rm nlm gm ac at mv ir aml bio pr maths organisation biology writing programming]);
sum_ac =sum(jointpot, [rm nlm cm gm at mv ir aml bio pr maths organisation biology writing programming]);
sum_mv =sum(jointpot, [rm nlm cm ac at gm ir aml bio pr maths organisation biology writing programming]);
sum_ir =sum(jointpot, [rm nlm cm ac at mv gm aml bio pr maths organisation biology writing programming]);
sum_at =sum(jointpot, [rm nlm cm ac gm mv ir aml bio pr maths organisation biology writing programming]);
sum_aml =sum(jointpot, [rm nlm cm ac at mv ir gm bio pr maths organisation biology writing programming]);
sum_bio =sum(jointpot, [rm nlm cm ac at mv ir aml gm pr maths organisation biology writing programming]);
sum_pr=sum(jointpot, [rm nlm cm ac at mv ir aml bio gm maths organisation biology writing programming]);

%p(course, maths, organisation)
sum_gm_m_o = sum(jointpot, [rm nlm cm ac at mv ir aml bio pr biology writing programming]);
sum_rm_m_o = sum(jointpot, [gm nlm cm ac at mv ir aml bio pr biology writing programming]);
sum_nlm_m_o =sum(jointpot, [gm rm cm ac at mv ir aml bio pr biology writing programming]);
sum_cm_m_o =sum(jointpot, [rm nlm gm ac at mv ir aml bio pr biology writing programming]);
sum_ac_m_o =sum(jointpot, [rm nlm cm gm at mv ir aml bio pr biology writing programming]);
sum_mv_m_o =sum(jointpot, [rm nlm cm ac at gm ir aml bio pr biology writing programming]);
sum_ir_m_o =sum(jointpot, [rm nlm cm ac at mv gm aml bio pr biology writing programming]);
sum_at_m_o =sum(jointpot, [rm nlm cm ac gm mv ir aml bio pr biology writing programming]);
sum_aml_m_o =sum(jointpot, [rm nlm cm ac at mv ir gm bio pr biology writing programming]);
sum_bio_m_o =sum(jointpot, [rm nlm cm ac at mv ir aml gm pr biology writing programming]);
sum_pr_m_o =sum(jointpot, [rm nlm cm ac at mv ir aml bio gm biology writing programming]);

%p(course, biology, writing)
sum_gm_b_w = sum(jointpot, [rm nlm cm ac at mv ir aml bio pr maths organisation programming]);
sum_rm_b_w = sum(jointpot, [gm nlm cm ac at mv ir aml bio pr maths organisation programming]);
sum_nlm_b_w =sum(jointpot, [gm rm cm ac at mv ir aml bio pr maths organisation programming]);
sum_cm_b_w =sum(jointpot, [rm nlm gm ac at mv ir aml bio pr maths organisation programming]);
sum_ac_b_w =sum(jointpot, [rm nlm cm gm at mv ir aml bio pr maths organisation programming]);
sum_mv_b_w =sum(jointpot, [rm nlm cm ac at gm ir aml bio pr maths organisation programming]);
sum_ir_b_w =sum(jointpot, [rm nlm cm ac at mv gm aml bio pr maths organisation programming]);
sum_at_b_w =sum(jointpot, [rm nlm cm ac gm mv ir aml bio pr maths organisation programming]);
sum_aml_b_w =sum(jointpot, [rm nlm cm ac at mv ir gm bio pr maths organisation programming]);
sum_bio_b_w =sum(jointpot, [rm nlm cm ac at mv ir aml gm pr maths organisation programming]);
sum_pr_b_w =sum(jointpot, [rm nlm cm ac at mv ir aml bio gm maths organisation programming]);

%p(maths, organisation)
sum_m_o = sum(jointpot, [pr rm nlm cm ac at mv ir aml bio gm biology writing programming]);

%p(biology, writing)
sum_b_w = sum(jointpot, [pr rm nlm cm ac at mv ir aml bio gm maths organisation programming]);

%p(course | biology, writing)
gm_b_w = divpots(setpot(sum_gm_b_w,[gm,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(GM|B,W) :']);
disp(gm_b_w.table);
rm_b_w = divpots(setpot(sum_rm_b_w,[rm,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(RM|B,W) :']);
disp(rm_b_w.table);
nlm_b_w = divpots(setpot(sum_nlm_b_w,[nlm,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(NLM|B,W) :']);
disp(nlm_b_w.table);
cm_b_w = divpots(setpot(sum_cm_b_w,[cm,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(CM|B,W) :']);
disp(cm_b_w.table);
ac_b_w = divpots(setpot(sum_ac_b_w,[ac,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(AC|B,W) :']);
disp(ac_b_w.table);
mv_b_w = divpots(setpot(sum_mv_b_w,[mv,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(MV|B,W) :']);
disp(mv_b_w.table);
ir_b_w = divpots(setpot(sum_ir_b_w,[ir,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(IR|B,W) :']);
disp(ir_b_w.table);
at_b_w = divpots(setpot(sum_at_b_w,[at,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(AT|B,W) :']);
disp(at_b_w.table);
aml_b_w = divpots(setpot(sum_aml_b_w,[aml,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(AML|B,W) :']);
disp(aml_b_w.table);
bio_b_w = divpots(setpot(sum_bio_b_w,[bio,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(BIO|B,W) :']);
disp(bio_b_w.table);
pr_b_w = divpots(setpot(sum_pr_b_w,[pr,biology,writing],[1,1,1]),setpot(sum_b_w,[biology,writing],[1,1]));
disp(['P(PR|B,W) :']);
disp(pr_b_w.table);

%p(course | maths, organisation)
gm_m_o = divpots(setpot(sum_gm_m_o,[gm,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(GM|M,O) :']);
disp(gm_m_o.table);
rm_m_o = divpots(setpot(sum_rm_m_o,[rm,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(RM|M,O) :']);
disp(rm_m_o.table);
nlm_m_o = divpots(setpot(sum_nlm_m_o,[nlm,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(NLM|M,O) :']);
disp(nlm_m_o.table);
cm_m_o = divpots(setpot(sum_cm_m_o,[cm,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(CM|M,O) :']);
disp(cm_m_o.table);
ac_m_o = divpots(setpot(sum_ac_m_o,[ac,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(AC|M,O) :']);
disp(ac_m_o.table);
mv_m_o = divpots(setpot(sum_mv_m_o,[mv,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(MV|M,O) :']);
disp(mv_m_o.table);
ir_m_o = divpots(setpot(sum_ir_m_o,[ir,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(IR|M,O) :']);
disp(ir_m_o.table);
at_m_o = divpots(setpot(sum_at_m_o,[at,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(AT|M,O) :']);
disp(at_m_o.table);
aml_m_o = divpots(setpot(sum_aml_m_o,[aml,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(AML|M,O) :']);
disp(aml_m_o.table);
bio_m_o = divpots(setpot(sum_bio_m_o,[bio,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(BIO|M,O) :']);
disp(bio_m_o.table);
pr_m_o = divpots(setpot(sum_pr_m_o,[pr,maths,organisation],[1,1,1]),setpot(sum_m_o,[maths,organisation],[1,1]));
disp(['P(PR|M,O) :']);
disp(pr_m_o.table);

disp(['P(Graphical Models) : ']);
disp(sum_gm.table);
disp(['P(Research Methods) : ']);
disp(sum_rm.table);
disp(['P(Information Retrieval) : ']);
disp(sum_ir.table);
disp(['P(Applied Machine Learning) : ']);
disp(sum_aml.table);
disp(['P(Bioinformatics) : ']);
disp(sum_bio.table);
disp(['P(NL Modelling) : ']);
disp(sum_nlm.table);
disp(['P(Project) : ']);
disp(sum_pr.table);
disp(['P(Advanced Topics) : ']);
disp(sum_at.table);
disp(['P(Machine Vision) : ']);
disp(sum_mv.table);
disp(['P(Affective Computing) : ']);
disp(sum_cm.table);
disp(['P(Computational Modeling) : ']);
disp(sum_cm.table);
