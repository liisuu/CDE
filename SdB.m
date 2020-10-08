function [Flag, V,r] = SdB(E,d)
% Function SdB(E,d) searches the feasibility of fixed (d,K)-Basis for given packet
% distribution matrix
% Inputs: E: packet distribution matrix
%         d: parameter for (d,K)-Basis
% Outputs: Flag: existence of (d,K)-Basis, "0" for No, "1" for Yes
%          V: (d,K)-Basis
%          r: rate vector



Q = [];
V = [];
[N,K] = size(E);
r = zeros(N,1);

Flag = 0;

for i = 1:N
    if sum(E(i,:)) <= d
        Flag = 0;
        V = [];
    else
        if isempty(Q)
            nonzeroindex = find(E(i,:) == 1);
            if length(nonzeroindex)==K
                Flag =1;
                break;
            end
                
                
            for j = 1: length(nonzeroindex)-d
                v_temp = zeros(1,K);
                v_temp(nonzeroindex(j:j+d)) = 1;
                r(i) = r(i)+1;
                V = [V;v_temp];
            end
            Q = [Q;E(i,:)];
        else
            
            while 1
                % check whether E(i,:) can generate a new (d,K)-Basis vector or
                % not.
                t = 1;
                for j = 1:size(Q,1)
                    if all((Q(j,:)+E(i,:)>0) == Q(j,:))
                        t = 0;
                        break;
                    end
                end
                if t ==0
                    % No new vector
                    break;
                else
                    % E(i,:) can generate a new (d,K)-Basis vector
                    nonzeroindex = find(E(i,:) == 1);
                    for l = 1:length(nonzeroindex)-d
                        v_temp = zeros(1,K);
                        v_temp((nonzeroindex(l:l+d))) = 1;
                        IsBasisVector = 1;
                        for j = 1:size(Q,1)
                            if all((Q(j,:)+v_temp>0) == Q(j,:))
                                IsBasisVector =0;
                            end
                        end
                        if IsBasisVector == 1
                            % found a feasible vector, add it to V
                            r(i) = r(i)+1;
                            V = [V;v_temp];
                            if size(V,1) == K-d
                                % found enough d-basis vectors
                                Flag = 1;
                                break;
                            end
                            
                            % add it to Q and check whether it can be
                            % mereged with some one or not
                            X = MergeQ(Q,v_temp,d);
                            Q = X;
                        end
                    end
                    
                end
                if Flag
                    break;
                end
            end
        end
    end
    if Flag
        break;
    end
end


end