

function [R,V] = MNRT(E)
% Function MNRT(E) computes the minimal number of required transmissions
% (minimum rate) for given E.
% Input: E: packet distribution matrix
% Output: R: minimum rate
%         V: corresonding (d,K)-Basis vectors

% some preprocessing
% if there are column of E that are all zeros remove them
E(:,sum(E)==0)=[];
[~,K] = size(E); 
% sort E according to the number of available packets
SE = sum(E,2);
[~,Ind] = sort(SE,'descend');
E = E(Ind,:);


% compute the minimum rate by using binary search method and SdB().
dmin = 1;
dmax = min(sum(E(end,:)),sum(E(1,:)));

[Fc,Vc] = SdB(E,dmax);
if Fc
    d = dmax;
    V = Vc;
else
    [Fc,V] = SdB(E,dmin);
    if ~Fc
        d = 0;
        V = eye(K);
    else
        while dmax-dmin > 1
            dt = max(fix((dmax+dmin)/2),dmin+1);
            if fix((dmax+dmin)/2)<=dmin
               disp('x'); 
            end
            [Fc,Vc] = SdB(E,dt);
            if Fc
                dmin = dt;
                V = Vc;
            else
                dmax = dt;
            end 
        end
        d = dmin;
    end
end

R = K - d;

end