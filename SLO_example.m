% This is an example for caculating the minimum rate for coded cooperative
% data exchange with priority problem for any given packet
% distribution matrix.
% Also known as successive local omniscience.

clear
clc

% Give a particular packet distribution matrix E
 E = [1 1 1 1 0 0 0 0 0;
      0 1 1 1 1 0 0 0 0;
      1 1 0 0 0 1 0 0 0;
      0 0 1 1 0 0 1 0 0;
      1 0 1 1 1 1 1 1 0;
      1 1 1 1 1 0 1 0 1];
% % or randomly generate an E
% N = 20; % the number of nodes
% K = 40; % the number of packets
% P = 0.6; % the probability of each packet is available at each node
% E = GenE(N,K,P);  

% set the priority group
G = {[1,2],[3,4],[5,6]};

% Compute the minimum accumulated rate vector (R = [R_1,...,R_M]) and
% (d,K)-Basis V
% for any given E and W
[R,~] = MNRT_SLO(E,G);