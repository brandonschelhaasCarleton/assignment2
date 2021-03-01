V0 = 1;

% Analytical Solution
V_an = zeros(ny, nx);
a = ny; % Set according to Griffiths Example 3.4
b = nx/2; % Set according to Griffiths Example 3.4
x = linspace(-b, b, nx); % Map 0-2b to -b-b
y = linspace(0, a, ny);
mult = 4*V0/pi; % multiplier

numTerms = 150;
figure
for k = 50:numTerms
    for col = 1:nx
        for row = 1:ny
            Vsum = 0;
            for i = 1:2:(2*k - 1) % Sum odd components up to k
                Vtemp1 = cosh((i*pi*x(col))/(a));
                Vtemp2 = sin((i*pi*y(row))/(a));
                Vtemp3 = cosh((i*pi*b)/(a));
                Vtemp = (1/i)*(Vtemp1)*(Vtemp2)/(Vtemp3);
                Vsum = Vsum + Vtemp;
            end
            V_an(row, col) = mult*Vsum; % Analytical = multipler * sum
        end
    end
    
    % Plot analytical solution
    plotAsMovie = 0;
    if plotAsMovie
        p = surf(V_an);
        set(p,'LineStyle','none')
        title(['Analytical Solution with # of Sums = ', num2str(k)]);
        xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');
    else
        if k == 75
            subplot(2,2,1);
            p = surf(V_an);
            set(p,'LineStyle','none')
            title(['Analytical Solution with # of Sums = ', num2str(k)]);
            xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');
        elseif k == 100
            subplot(2,2,2);
            p = surf(V_an);
            set(p,'LineStyle','none')
            title(['Analytical Solution with # of Sums = ', num2str(k)]);
            xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');
        elseif k == 125
            subplot(2,2,3);
            p = surf(V_an);
            set(p,'LineStyle','none')
            title(['Analytical Solution with # of Sums = ', num2str(k)]);
            xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');
        elseif k == 150
            subplot(2,2,4);
            p = surf(V_an);
            set(p,'LineStyle','none')
            title(['Analytical Solution with # of Sums = ', num2str(k)]);
            xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');
        end
    end

    pause(0.001);
end

% FDM Solution

% Boundary Voltage Conditions
leftBC = V0;
rightBC = V0;
topBC = 0;
bottomBC = 0;

% Setup G-matrix from FDM Laplace Equation and Boundary voltage - Part 1a has details
for col = 1:nx
    for row = 1:ny
        n = row + (col-1)*ny;
        nxm = row + (col-2)*ny;
        nxp = row + (col)*ny;
        nym = (row-1) + (col-1)*ny;
        nyp = (row+1) + (col-1)*ny;
        
        if col == 1
            G(n,n) = 1;
            Bv(n) = leftBC;
        elseif col == nx
            G(n,n) = 1;
            Bv(n) = rightBC;
        elseif row == 1
            G(n,n) = 1;
            Bv(n) = bottomBC;
        elseif row == ny
            G(n,n) = 1;
            Bv(n) = topBC;
        else
            G(n,n) = -4;
            G(n,nxp) = 1;
            G(n,nxm) = 1;
            G(n,nyp) = 1;
            G(n,nym) = 1;
        end
    end
end

% Calculate voltage distribution
V = G\Bv; %GV = F ... GV = Bv

volt_2d = zeros(nx, ny);
for col = 1:nx
    for row = 1:ny
        n = row + (col-1)*ny;
        volt_2d(col, row) = V(n);
    end
end

% Plot voltage distribution
figure
p = surf(volt_2d');
set(p,'LineStyle','none')
title('Voltage Distribution of Saddle');
xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');

% Comparison between analytical and FDM
V_error = zeros(ny, nx);
V_error = abs(V_an - volt_2d');

% Plot the error between analytical and FDM
figure
p = surf(V_error);
set(p,'LineStyle','none')
title('Error between Analytical and FDM');
xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');
