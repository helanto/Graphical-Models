%% exercise 7.4
% load airplane data
load('airplane');

% Compute sequence of positions in part 1
optPath1 = airplaneMDP(U);

% Compute sequence of positions in part 2 with faulty right operation
optPath2 = airplaneFaultyMDP(U);
