function [I] = KNN(P,X,K)
%KNN finds the K nearest neighbour by Euclidean
%   distance to each point in P from X. P and X are both matrices with the
%   same number of rows, and points are the columns of the matrices. Output
%   is a vector of indices into X such that X(:, IDX) are the K nearest
%   neighbours to P 
%   warning: K must be less than size(X)!


 Y = zeros(size(X));
    for iPoint = 1:size(P, 2)
        x = P(:, iPoint);

        % distance between 2 points
        for i = 1:size(Y, 1)
            Y(i, :) = X(i, :) - x(i);
        end

        % euclide distance
        d = sum(abs(Y).^2, 1);
        
        % K nearest neighbors
        [M, idx] = sort(d);
        idx = idx(1:K);
        
        % all neighbors
        I(iPoint,:) = idx;
    end



end

