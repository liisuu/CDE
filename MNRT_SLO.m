

function [R,V] = MNRT_SLO(E,G)
% Function MNRT_SLO(E,G) computes the minimum rate for given E and G.
% Input: E: packet distribution matrix
%        G: priority groups
% Output: R: minimum rate
%         V: corresonding (d,K)-Basis vectors         

% some preprocessing
% if there are column of E that are all zeros remove them
E(:,sum(E)==0)=[];
[N,K] = size(E); 



% compute the minimum rate by using binary search method and SdB().
m = size(G,2); % the number of groups
r = zeros(N,m);
R = zeros(1,m);
d = zeros(1,m);
EG = [];
d_op = K;
K_n = zeros(1,m);% number of packets in each group
V = zeros(size(E));

for i = 1:m
    for j = G{i}
        EG = [EG;E(j,:)];
    end
    EG_c = EG(:,sum(EG)~=0);% for some group they may not contain all packets
    K_n(i) = size(EG_c,2);
    
    dmin = 1;
    dmax = min(min(sum(EG_c,2)),d_op);
    [Fc,Vc,rc] = SdB(EG_c,dmax);
    if Fc
        d(i) = dmax;
        r(:,i) = rc;  
    else
        [Fc,Vc,rc] = SdB(EG_c,dmin);
        if ~Fc
            d(i) = 0;
            % Vi = I_K_i;
        else
            while dmax-dmin > 1
                d_op = fix((dmin+dmax)/2);
                [Fc,Vc,rc] = SdB(EG_c,d_op);
                if Fc
                    dmin = d_op;
                    d(i) = d_op;
                    % V = Vc;
                else
                    dmax = d_op;
                end 
            end
        end
    end
    
end

R = K_n -d;
end