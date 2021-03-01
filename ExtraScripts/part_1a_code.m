% Boundary Voltage Conditions
leftBC = 1;
rightBC = 0;

% Setup G-matrix and Boundary voltages
for col = 1:nx
    for row = 1:ny
        n = row + (col-1)*ny;
        nxm = row + (col-2)*ny;
        nxp = row + (col)*ny;
        nym = (row-1) + (col-1)*ny;
        nyp = (row+1) + (col-1)*ny;
        
        if col == 1
            % V(n) = Boundary Voltage = 1V
            G(n,n) = 1;
            Bv(n) = leftBC;
        elseif col == nx
            % V(n) = Boundary Voltage = 1V
            G(n,n) = 1;
            Bv(n) = rightBC;
        elseif row == 1
            %dV/dy = 0;
            % ((1)V(y) + (-1)V(y-1))/dy = 0 (= B) --- dy goes away because dy = 1
            G(n,n) = 1; 
            G(n,nyp) = -1;
            % Bv already set to 0
        elseif row == ny
            %dV/dy = 0;
            % ((1)V(y) + (-1)V(y-1))/dy = 0 (= B) --- dy goes away because dy = 1
            G(n,n) = 1;
            G(n,nym) = -1;
            % Bv already set to 0
        else
            % V(n_x+1) + V(n_x-1) + V(n_y+1) + V(n_y-1) - 4V(n) = 0 (= B)
            G(n,n) = -4; % Central point, -4 is coefficient with delX = delY = 1
            G(n,nxp) = 1; % col + 1, 1 is coefficient with delX = delY = 1
            G(n,nxm) = 1; % col - 1, 1 is coefficient with delX = delY = 1
            G(n,nyp) = 1; % row + 1, 1 is coefficient with delX = delY = 1
            G(n,nym) = 1; % row - 1, 1 is coefficient with delX = delY = 1
            % Bv already set to 0
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
title('Voltage Distribution for Simple Case');
xlabel('x [units]'); ylabel('y [units]'); zlabel('Voltage [V]');
colorbar;