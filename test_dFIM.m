clear all
clc

n1 = 30;
n2 = 50;

% random data
p1 = rand(n1, 2);
p1(:, 2) = sum(p1, 2); % for above the diagonal line

p2 = rand(n1, 2);
p2(:, 2) = sum(p2, 2); % for above the diagonal line

% variance for smoothing
delta = 0.1; % it typically depends on data, can be chosen from cross validation

t1 = tic;
dFIM = compute_dFIM_distance(p1, p2, delta);
runtime_dFIM = toc(t1);

t2 = tic;
dFIM_FGT = compute_dFIM_distance(p1, p2, delta);
runtime_dFIM_FGT = toc(t2);

disp(['dFIM     = ' num2str(dFIM) ' --- running time: ' num2str(runtime_dFIM)]);
disp(['dFIM_FGT = ' num2str(dFIM_FGT) ' --- running time: ' num2str(runtime_dFIM_FGT)]);

