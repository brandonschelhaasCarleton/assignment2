set(0, 'DefaultFigureWindowStyle', 'Docked')

clc
clear
close all

% ELEC 4700 - Assignment 2
% Brandon Schelhaas
% 101036851
% Programmed on MATLAB 2020a

doAll = 1;
doPart1a = 1;
doPart1b = 1;
doPart2a = 0;
doPart2b = 0;
doPart2c = 0;
doPart2d = 0;

%-------------------------
%         Part 1a
%-------------------------

% Use ratio of 3/2 = L/W = nx/ny
ny = 60;
nx = (1.5) * ny;

G = sparse(ny*ny, nx*nx);
Bv = zeros(nx*ny, 1); % voltage boundary

% Run Part 1a script
if doPart1a | doAll
    part_1a_code
end

%-------------------------
%         Part 1b
%-------------------------

% Use ratio of 3/2 = L/W = nx/ny
ny = 60;
nx = (1.5) * ny;

G = sparse(ny*ny, nx*nx);
Bv = zeros(nx*ny, 1); % voltage boundary

% Run Part 1b Script
if doPart1b | doAll
    part_1b_code
end
    
%-------------------------
%         Part 2a
%-------------------------

% Use ratio of 3/2 = L/W = nx/ny
ny = 60;
nx = (1.5) * ny;

G = sparse(ny*ny, nx*nx);
Bv = zeros(nx*ny, 1); % voltage boundary

boxes{1}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
boxes{1}.y = [(0.5*ny + (1/6)*ny) ny];
boxes{1}.sigma = 0.01;
boxes{2}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
boxes{2}.y = [0 (0.5*ny - (1/6)*ny)];
boxes{2}.sigma = 0.01;

sigma = zeros(ny, nx);

if doPart2a | doAll
    part_2a_code
end

%-------------------------
%         Part 2b
%-------------------------

figure
for count = 1:4
    % Change mesh size
    if count == 1
        ny = 20;
    elseif count == 2
        ny = 40;
    elseif count == 3
        ny = 80;
    else
        ny = 100;
    end
    nx = (1.5) * ny;
    
    % Change G, Bv, and sigma matrix based on mesh size
    G = sparse(ny*ny, nx*nx);
    Bv = zeros(nx*ny, 1); % voltage boundary
    sigma = zeros(ny, nx);
    
    % Place boxes based on mesh size
    boxes{1}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
    boxes{1}.y = [(0.5*ny + (1/6)*ny) ny];
    boxes{1}.sigma = 0.01;
    boxes{2}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
    boxes{2}.y = [0 (0.5*ny - (1/6)*ny)];
    boxes{2}.sigma = 0.01;
    
    % Run Part 2b code to investigate current vs. mesh size
    if doPart2b | doAll
        part_2b_code
    end
end

%-------------------------
%         Part 2c
%-------------------------

% Use ratio of 3/2 = L/W = nx/ny
ny = 60;
nx = (1.5) * ny;

figure
for count = 1:4
    % Change bottle neck size
    if count == 1
        percent_open = 0.8; % 80 percent of ny open
    elseif count == 2
        percent_open = 0.6; % 60 percent of ny open
    elseif count == 3
        percent_open = 0.4; % 40 percent of ny open
    else
        percent_open = 0.2; % 20 percent of ny open
    end
    
    % Reset G, Bv, and sigma matrix
    G = sparse(ny*ny, nx*nx);
    Bv = zeros(nx*ny, 1); % voltage boundary
    sigma = zeros(ny, nx);
    
    % Reset boxes to narrow bottleneck
    boxes{1}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
    boxes{1}.y = [(0.5*ny + (percent_open/2)*ny) ny]; 
    boxes{1}.sigma = 0.01;
    boxes{2}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
    boxes{2}.y = [0 (0.5*ny - (percent_open/2)*ny)];
    boxes{2}.sigma = 0.01;
    
    % Run Part 2b code to investigate current vs. mesh size
    if doPart2c | doAll
        part_2c_code
    end
end

%-------------------------
%         Part 2d
%-------------------------

% Use ratio of 3/2 = L/W = nx/ny
ny = 60;
nx = (1.5) * ny;

% Reset boxes to narrow bottleneck
boxes{1}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
boxes{1}.y = [(0.5*ny + (1/6)*ny) ny];
boxes{2}.x = [(0.5*nx - (1/6)*nx) (0.5*nx + (1/6)*nx)];
boxes{2}.y = [0 (0.5*ny - (1/6)*ny)];

figure
for count = 1:4
    % Change the sigma of the boxes
    if count == 1
        boxes{1}.sigma = 0.1;
        boxes{2}.sigma = 0.1;
    elseif count == 2
        boxes{1}.sigma = 10;
        boxes{2}.sigma = 10;
    elseif count == 3
        boxes{1}.sigma = 0.001;
        boxes{2}.sigma = 100;
    else
        boxes{1}.sigma = 1000;
        boxes{2}.sigma = 0.0001;
    end
    
    % Reset G, Bv, and sigma matrix
    G = sparse(ny*ny, nx*nx);
    Bv = zeros(nx*ny, 1); % voltage boundary
    sigma = zeros(ny, nx);

    % Run Part 2b code to investigate current vs. mesh size
    if doPart2d | doAll
        part_2d_code
    end
end
