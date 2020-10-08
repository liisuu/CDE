function Q = MergeQ(Q,v,d)

[Q,F] = MergeQStep(Q,v,d);
while F
    v = Q(F,:);
    Q(F,:) = [];
    [Q,F] = MergeQStep(Q,v,d);
end

end