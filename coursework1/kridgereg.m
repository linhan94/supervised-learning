function alpha = kridgereg( K, y, lamda )
% excercise 10a
%   take in a kernel matrix K, y vector, and scalar ridge parameter ? as inputs 
%   and return a vector ? of dual weights.

alpha = (K+lamda*length(y)*eye(length(y)))\y;

end

