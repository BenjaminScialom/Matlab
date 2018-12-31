clc, close all, clear all;

%% Step 1 - Training phase

% Data
D = {[1,1],[2,5],[1,3],[1,4],[2,3],[3,2];'class3', 'class2', 'class1','class2', 'class2', 'class3'};




%% Step 2 - Classification phase (Euclidian distance)

%% K nearest neighbour search

% 2D points of interest
% P = rand(2, 5);
P = [1,2,1;5,1,6];

% % Candidate point set
% X = rand(2, 10);
for ii=1:length(D(1,:));
    X(:,ii) = D{1,ii};
end

% K nearest neighbours
K = 3;

% Find the neighbours
I = KNN(P, X, K);

% Plot the points (works only for K=1)
% plot(X(1,:), X(2,:), 'b.', P(1,:), P(2,:), 'r.', 'MarkerSize', 15);
% hold on
% quiver(P(1, :), P(2, :), X(1,I) - P(1, :), X(2, I) - P(2, :), 0, 'k');
% hold off

%% Determination of the most common class for each point

for ii=1:length(I)
    
    
    % Determine the classes of the nearest neighbors
    idx = I(ii,:);

    for kk=1:length(idx)
        x(kk) = D(2,idx(kk))
    end

    % find the most common one
    y = unique(x);
    n = zeros(length(y), 1);
    for iy = 1:length(y)
      n(iy) = length(find(strcmp(y{iy}, x)));
    end
    [~, itemp] = max(n);
    C(ii) = y(itemp)


end

