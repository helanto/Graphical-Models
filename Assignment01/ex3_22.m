import brml.*

% Variable declaration
ad1 = 1; ad2 = 2; ad3 = 3; ad4 = 4; ad5 = 5; ad6 = 6; ad7 = 7; ad8 = 8; ad9 = 9; ad10 = 10; %Adverts
g123 = 11; g235 = 12; g4710 = 13; g346 = 14; g568 = 15;
g379 = 16; g2410 = 17; g127 =18; g278 = 19; g368 = 20;
g468 = 21; g349 = 22; g145 = 23; g159 = 24; g678 = 25;
g479 = 26; g6810 = 27; g345 = 28; g236 = 29; g124 = 30; %Adverts conflicts
%gijk means we have seen a conflict between adverts i, j and k

% Values
interest = 1:5; %skills
% we assume that gijk variables take values: 1,2 or 3

% Advert variables domain and name
for i  = 1:10
    variable(i).domain = {'Lvl 1','Lvl 2','Lvl 3','Lvl 4','Lvl 5'};
    variable(i).name = ['Advert ', num2str(i)];
end;

% Conflict variables domain and name
for i = 11:30   %we use number instead of gijk
    variable(i).domain = {'1','2','3'};
    variable(i).name = ['Conflict ', num2str(i)];
end;
clear i;

% p(ad1), p(ad2), p(ad3), p(ad4), p(ad5), p(ad6), p(ad7), p(ad8), p(ad9), p(ad10)
pot{ad1} = array(ad1);
pot{ad2} = array(ad2);
pot{ad3} = array(ad3);
pot{ad4} = array(ad4);
pot{ad5} = array(ad5);
pot{ad6} = array(ad6);
pot{ad7} = array(ad7);
pot{ad8} = array(ad8);
pot{ad9} = array(ad9);
pot{ad10} = array(ad10);
for ad = 1:10
    for lv = interest
        pot{ad}.table(lv) = 0.2;
    end;
end;
clear ad;
clear lv;

% out_table = 5x5x5x3
out_table = zeros(length(interest),length(interest),length(interest),3);
for i = interest
    for j = interest
        for k = interest
            out_table(i,j,k,1) = probAdv(i,j,k);    %last dimension take values 1,2,3
            out_table(i,j,k,2) = probAdv(j,i,k);
            out_table(i,j,k,3) = probAdv(k,i,j);
        end;
    end;
end;
clear i;
clear j;
clear k;

% gijk = p(gijk|adi,adj,adk)
pot{g123} = array([ad1 ad2 ad3 g123]);
pot{g123}.table = out_table;

pot{g235} = array([ad2 ad3 ad5 g235]);
pot{g235}.table = out_table;

pot{g4710} = array([ad4 ad7 ad10 g4710]);
pot{g4710}.table = out_table;

pot{g346} = array([ad3 ad4 ad6 g346]);
pot{g346}.table = out_table;

pot{g568} = array([ad5 ad6 ad8 g568]);
pot{g568}.table = out_table;

pot{g379} = array([ad3 ad7 ad9 g379]);
pot{g379}.table = out_table;

pot{g2410} = array([ad2 ad4 ad10 g2410]);
pot{g2410}.table = out_table;

pot{g127} = array([ad1 ad2 ad7 g127]);
pot{g127}.table = out_table;

pot{g278} = array([ad2 ad7 ad8 g278]);
pot{g278}.table = out_table;

pot{g368} = array([ad3 ad6 ad8 g368]);
pot{g368}.table = out_table;

pot{g468} = array([ad4 ad6 ad8 g468]);
pot{g468}.table = out_table;

pot{g349} = array([ad3 ad4 ad9 g349]);
pot{g349}.table = out_table;

pot{g145} = array([ad1 ad4 ad5 g145]);
pot{g145}.table = out_table;

pot{g159} = array([ad1 ad5 ad9 g159]);
pot{g159}.table = out_table;

pot{g678} = array([ad6 ad7 ad8 g678]);
pot{g678}.table = out_table;

pot{g479} = array([ad4 ad7 ad9 g479]);
pot{g479}.table = out_table;

pot{g6810} = array([ad6 ad8 ad10 g6810]);
pot{g6810}.table = out_table;

pot{g345} = array([ad3 ad4 ad5 g345]);
pot{g345}.table = out_table;

pot{g236} = array([ad2 ad3 ad6 g236]);
pot{g236}.table = out_table;

pot{g124} = array([ad1 ad2 ad4 g124]);
pot{g124}.table = out_table;

% pijk_2 = p(gijk = 2|adi,adj,adk)
p123_1 = setpot(pot{g123},g123,1);
p235_1 = setpot(pot{g235},g235,1);
p4710_1 = setpot(pot{g4710},g4710,1);
p346_3 = setpot(pot{g346},g346,3);
p568_2 = setpot(pot{g568},g568,2);
p379_3 = setpot(pot{g379},g379,3);
p2410_3 = setpot(pot{g2410},g2410,3);
p127_3 = setpot(pot{g127},g127,3);
p278_3 = setpot(pot{g278},g278,3);
p368_3 = setpot(pot{g368},g368,3);
p468_3 = setpot(pot{g468},g468,3);
p349_2 = setpot(pot{g349},g349,2);
p145_3 = setpot(pot{g145},g145,3);
p159_3 = setpot(pot{g159},g159,3);
p678_1 = setpot(pot{g678},g678,1);
p479_1 = setpot(pot{g479},g479,1);
p6810_3 = setpot(pot{g6810},g6810,3);
p345_3 = setpot(pot{g345},g345,3);
p236_3 = setpot(pot{g236},g236,3);
p124_1 = setpot(pot{g124},g124,1);

% p_conflicts_given_ads = p(gijk = 1,2,3|adi,adj,adk)*p(gijk = 1,2,3|adi,adj,adk)*...*p(gijk = 1,2,3|adi,adj,adk)
p_conflicts_given_ads = multpots([p123_1 p235_1 p4710_1 p346_3 p568_2 p379_3 p2410_3 p127_3 p278_3 p368_3
    p468_3 p349_2 p145_3 p159_3 p678_1 p479_1 p6810_3 p345_3 p236_3 p124_1]);

% p_ads = p(ad1)*p(ad2)*p(ad3)*...*p(ad10)
p_ads = multpots(pot(1:10));

% p_numer = p_conflicts_given_ad * p_ads
p_numer = multpots([p_conflicts_given_ads,p_ads]);

% p_denom = p(gijk = value, gijk = value, gijk = value, ... 20 confilicts) 
p_denom = sumpot(p_numer,1:10);

% p_ads_given_conflicts = p(ad1,ad2,ad3,...ad10|gijk = value, gijk = value ... 20 conflicts)
p_ads_given_conflicts = divpots(p_numer,p_denom);

pad1 = sumpot(p_ads_given_conflicts,2:10);
pad2 = sumpot(p_ads_given_conflicts,[1 3:10]);
pad3 = sumpot(p_ads_given_conflicts,[1:2 4:10]);
pad4 = sumpot(p_ads_given_conflicts,[1:3 5:10]);
pad5 = sumpot(p_ads_given_conflicts,[1:4 6:10]);
pad6 = sumpot(p_ads_given_conflicts,[1:5 7:10]);
pad7 = sumpot(p_ads_given_conflicts,[1:6 8:10]);
pad8 = sumpot(p_ads_given_conflicts,[1:7 9:10]);
pad9 = sumpot(p_ads_given_conflicts,[1:8 10]);
pad10 = sumpot(p_ads_given_conflicts,1:9);

disp('p(Advert 01|choises of all 20 users) :');
disp(pad1.table);

disp('p(Advert 02|choises of all 20 users) :');
disp(pad2.table);

disp('p(Advert 03|choises of all 20 users) :');
disp(pad3.table);

disp('p(Advert 04|choises of all 20 users) :');
disp(pad4.table);

disp('p(Advert 05|choises of all 20 users) :');
disp(pad5.table);

disp('p(Advert 06|choises of all 20 users) :');
disp(pad6.table);

disp('p(Advert 07|choises of all 20 users) :');
disp(pad7.table);

disp('p(Advert 08|choises of all 20 users) :');
disp(pad8.table);

disp('p(Advert 09|choises of all 20 users) :');
disp(pad9.table);

disp('p(Advert 10|choises of all 20 users) :');
disp(pad10.table);