clear all; 
clc;

% Model parameters
model.x   = 0:1:1000;   % Horizontal axis (sampling every 1m)
model.z   = 0:1:500;    % Vertical axis (sampling every 1m)

Nx = numel(model.x); % 1001 points
Nz = numel(model.z); % 501 points

% Velocity Model with Reflectors (Acoustic Lens)
model.vel = 2000 * ones(Nz, Nx); % Uniform medium with velocity 2000 m/s
z_transition = 250;
model.vel(z_transition:end, :) = 3000; % velocity in second layer

% Introduce a curved reflector to focus waves (acoustic lens)
for kx = 1:Nx
    x = model.x(kx);
    for kz = 1:Nz
        z = model.z(kz);
        if z < 250
            model.vel(kz, kx) = 2000;
        else
            model.vel(kz, kx) = 3000;
        end
        % Define a parabolic reflector (acoustic reflector) centered at x =
        % 500m and z = 250m
        if abs(z - (200 - 0.001 * (x - 500)^2)) < 3 % parabolic equation
            model.vel(kz, kx) = 6000; % High velocity for reflectors
        end
    end
end

% Source parameters (Beamforming using Delays)
source.x = 250:10:750; % Array of sources from x = 250m to 750m
Nsources = numel(source.x); % 51 sources
source.z = ones(1, Nsources) * 50;
source.f0 = ones(1, Nsources) * 35;

% Beamforming delay: sources emit at different times to focus waves at x = 500, z = 350
focus_x = 500;
focus_z = 350;
for i = 1:Nsources
    dx = source.x(i) - focus_x;
    dz = source.z(i) - focus_z;
    distance = sqrt(dx^2 + dz^2); % calculate distance between each source to focus point
    source.t0(i) = distance / 2000; % Time delay for beamforming
end
source.amp = tukeywin(Nsources, 0.5); % Smooth edges to reduce artifacts
source.type = ones(1, Nsources) * 1;  % 1: Ricker wavelet

% Receiver placement
model.recx = [200 500 800]; % Receivers positioned before, at, and after focus point
model.recz = [350 350 350]; % All receivers placed at depth 350m
model.dtrec = 0.002; % Higher time resolution

% Simulation parameters
simul.borderAlg = 1; % Enable absorbing boundaries
simul.timeMax = 0.5; % Simulation time in seconds
simul.printRatio = 5; % Snapshot visualization every 5 time steps
simul.higVal = 0.5;
simul.lowVal = 0.1;
simul.bkgVel = 1;
simul.cmap = 'gray';

% Run simulation
recfield = acu2Dpro(model, source, simul);
%[recfield, wavefield] = acu2Dpro(model, source, simul);

% Plot seismic traces
figure;
time = recfield.time;
traces = recfield.data;
plot(time, traces, 'LineWidth', 1.5);
xlabel('Time (s)', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Amplitude', 'FontSize', 10, 'FontWeight', 'bold');
title('Seismic Traces - Beamforming & Focusing', 'FontSize', 12, 'FontWeight', 'bold');
legend({'Receiver Left', 'Receiver Center', 'Receiver Right'}, 'FontSize', 10);
%legend({'Receiver 1', 'Receiver 2', 'Receiver 3', 'Receiver 4', 'Receiver 5'}, 'FontSize', 10);
grid on;
axis tight;
set(gca, 'FontSize', 10);

% Seismic traces per receiver in subplots
figure;
for i = 1:length(model.recx)
    subplot(length(model.recx), 1, i);
    plot(time, traces(:,i), 'LineWidth', 1.5);
    xlabel('Time (s)', 'FontSize', 10, 'FontWeight', 'bold');
    ylabel('Amplitude', 'FontSize', 10, 'FontWeight', 'bold');
    title(['Seismic Trace - Receiver ', num2str(i)], 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
end

% 2D Visualization of Velocity Model
figure;
imagesc(model.x, model.z, model.vel);
colormap(turbo);
colorbar;
xlabel('X Position (m)', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Z Depth (m)', 'FontSize', 10, 'FontWeight', 'bold');
title('Velocity Model with Acoustic Lens', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'YDir', 'normal', 'FontSize', 10);

