% Function for mergeQ when new bais vector is found

function [Q,FoundQ] = MergeQStep(Q,v,d)

% v can only merged with one or two vectors in Q

% check whether it is possible to merge with one vector
FoundQ = 0;
for i = 1:size(Q,1)
    w1 = sum((Q(i,:)+v)>0);
    w2 = sum(Q(i,:))+ sum(v) - d;
    if w1 <= w2
        % found the vector that should be merged with v
        Q(i,:) = (Q(i,:)+v)>0;
        FoundQ = i;
        break;
    end
end

if FoundQ
    % further check whether it can be merged with another vector or not
    for i = 1:size(Q,1)
        if i ~= FoundQ
            w1 = sum((Q(i,:)+Q(FoundQ,:))>0);
            w2 = sum(Q(i,:))+ sum(Q(FoundQ,:)) - d;
            if w1 <= w2
                % can be merged together
                Q(i,:) = (Q(i,:)+Q(FoundQ,:))>0;
                Q(FoundQ,:) = [];
                if i < FoundQ
                    FoundQ = i;
                else
                    FoundQ = i-1;
                end

                break;
            end
        end
    end
else
    % check whether it is possible to merge with two vectors
    for i = 1:size(Q,1)-1
        for j = i+1:size(Q,1)
            w1 = sum((Q(i,:)+ Q(j,:)+v)>0);
            w2 = sum(Q(i,:))+ sum(Q(j,:)) + sum(v) - 2*d;
            if w1 <= w2
                % found the vector pair that should be mereged with v
                Q(i,:) = (Q(i,:)+ Q(j,:)+v)>0;
                Q(j,:) = [];
                if i < FoundQ
                    FoundQ = i;
                else
                    FoundQ = i-1;
                end

                break;
            end
        end
        if FoundQ
            break;
        end
    end
end




if ~FoundQ
    Q = [Q;v];
end




end