function plidemo_ssvq(op)
%PLIDEMO_SSVQ Demonstrates the use of pli_ssvq
%
%   PLIDEMO_SSVQ;
%
%   PLIDEMO_SSVQ('mc');
%       Uses multi-consolidation.
%

%% configuration

use_mc = nargin == 1 && strcmpi(op, 'mc');

d = 2;
K = 100;
n = 10000;
kmax = 500;
cbnd = 1;

fprintf('Configuration:');
fprintf('\tsize = (%d, %d)\n', d, n);
fprintf('\tkmax = %d\n', kmax);
fprintf('\tcbnd = %g\n', cbnd);
fprintf('\n');

%% data generation

disp('Generate data ...');
X = cell(1, K);
for k = 1 : K
    X{k} = bsxfun(@plus, randn(d, 1) * 20, randn(d, n));
end
X = [X{:}];
X = X(:, randperm(size(X,2)));

disp('Run SSVQ ...');
tic;
if use_mc
    C = pli_ssvq_mc(X, [], cbnd, kmax);
else
    C = pli_ssvq(X, [], cbnd, kmax);
end
elapsed_time = toc;

fprintf('Elapsed time = %.5f sec\n\n', elapsed_time);

%% visualize results

figure;
plot(X(1,:), X(2,:), '.', 'MarkerSize', 5);
hold on;
plot(C(1,:), C(2,:), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
title('Using SSVQ');

% figure;
% plot(X(1,:), X(2,:), '.', 'MarkerSize', 5);
% hold on;
% plot(X(1,1:kmax), X(2,1:kmax), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
% title('Random');

