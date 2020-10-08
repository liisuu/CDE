% This is an example for caculating the minimum rate for coded cooperative
% data exchange with weighted cost problem for any given packet
% distribution matrix and weight vector.
clear
clc

% Give a particular packet distribution matrix E
 E = [0 1 0 1 0 0 1 1 1;
      1 0 0 0 1 1 0 1 1;
      0 1 1 0 0 1 0 1 1;
      1 0 1 0 1 1 0 1 0;
      1 1 0 1 1 0 1 0 1];

% % or randomly generate E
% N = 20; % the number of nodes
% K = 40; % the number of packets
% P = 0.6; % the probability of each packet is available at each node
% E = GenE(N,K,P);

% set the weight vector
%W = rand(N,1);
W = [2,3,6,8,10];

% Compute the optimal rate vector (r), minimum weigted cost (C) and
% (d,K)-Basis V
% for any given E and W
[r,C,V] = MNRT_weight(E,W);
