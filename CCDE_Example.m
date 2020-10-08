% This is an example for caculating the minimum rate for coded cooperative
% data exchange problem for any given packet distribution matrix
clear
clc

% Give a particular packet distribution matrix E
%E = [];

% or randomly generate E by setting 
N = 20; % the number of nodes
K = 40; % the number of packets
P = 0.6; % the probability of each packet is available at each node
E = GenE(N,K,P);

% Compute the minimum rate (R) and the corresponding (d,K)-Basis vectors V
% for any given E
[R,V] = MNRT(E);

