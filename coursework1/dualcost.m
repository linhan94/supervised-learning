function MSE = dualcost( K, y, alpha )
%excercise 10b
%   take in a kernel matrix K, y vector, and dual weight vector ? as inputs
%   and return a single value

MSE = length(y) \ (K*alpha - y)' * (K*alpha - y);

end

