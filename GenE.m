function E = GenE(N,K,P)
% Function GenE(N,K,P) is used to randomly generate the packet distribution
% matrix E.
% Inputs: N: number of nodes
%         K: number of pakcets
%         P: probability of that one packet is available at each node
% Output: E: packet distribution matrix
% As each packet should be available at at least 1 node, we fixed the
% number of nodes that have each packet to be M.

if P <=0 || P >= 1
    error('P should be between 0 and 1.');
end

% each packet is randomly available at eaxact M nodes
M = ceil(N*P);

X = ceil(rand(M,K)*N);

E = zeros(N,K);

for i = 1:K
    for j = 1:size(X,1)
        E(X(j,i),i) = 1;
    end
    
end

end