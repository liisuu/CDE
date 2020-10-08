

function [r,C,V] = MNRT_weight(E,W)
% Function MNRT_weight(E,W) computes the minimum cost for given E and W.
% Input: E: packet distribution matrix
%        W: weight vector
% Output: R: rate
%         V: corresonding (d,K)-Basis vectors
%         C: minimum weighted cost

% some preprocessing
% if there are column of E that are all zeros remove them
E(:,sum(E)==0)=[];
[N,K] = size(E); 
M = min(sum(E,2));


% sort E according to the ascending weight
W = W(:);
[~,Ind] = sort(W,'ascend');
W = W(Ind);
E = E(Ind,:);




% compute the minimum cost by using binary search method and SdB().
dmin = 0;
dmax = M;
r = zeros(N,1); 

while dmin<dmax
   d = max(fix((dmin+dmax)/2),dmin+1); 
   [Fc,Vc,rc] = SdB(E,d);
   if ~Fc
       dmax = d;
   else
       dh = d-1;
       [~,Vh,rh] = SdB(E,dh);
       if W'*rc > W'*rh
           dmax = dh;
           r = rh;
           V = Vh;
       else
           dmin = d;
           r = rc;
           V = Vc;
       end
   end
end

C = W'*r;
end