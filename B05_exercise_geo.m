clc; clear; close all;

model.x = 0:1:1000;
model.z = 0:1:500;
Nx = numel(model.x); % 1001 points
Nz = numel(model.z); % 501 points
model.vel = zeros(Nz, Nx); % velocity matrix

for kx = 1:Nx % here, we have refraction
    for kz = 1:Nz
        if kz < 150
            model.vel(kz, kx) = 800; % first layer
        elseif kz < 350
            model.vel(kz, kx) = 1000 + 2 * (kz - 150); % Gradual Change of Speed - In second layer velocity change from 1000 to 1300
        else
            model.vel(kz, kx) = 2200; % Third layer with high-speed
        end
    end
end

% Creating a high-speed obstacle in the environment
model.vel(250:300, 400:600) = 4000;  % Obstacle with speed value 3500 - leads reflection and scattering

source.x = 500;  
source.z = 100;
source.f0 = 10;
source.t0 = 0.05;
source.amp = 1;
source.type = 1;

model.recx = 100:50:900;
model.recz = ones(size(model.recx)) * 450;
model.dtrec = 0.002;

simul.borderAlg = 1;
simul.timeMax = 0.6;
simul.printRatio = 10;
simul.higVal = 0.3;
simul.lowVal = 0.02;
simul.bkgVel = 1; 
simul.cmap = 'gray';

recfield = acu2Dpro(model, source, simul);

figure;
scal = 1; 
pltflg = 0; 
scfact = 1;  
colour = '';  
clip = 0.9;  

seisplot2(recfield.data, recfield.time, [], scal, pltflg, scfact, colour, clip);
xlabel('Receiver Number');
ylabel('Time (s)');
title('Seismic Wave Propagation with Scattering');

