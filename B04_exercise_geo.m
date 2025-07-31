clc; clear; close all;

%x1 = [50, 200]; 
%t1 = [0.08, 0.20];
x1 = [40, 140]; 
t1 = [0.086, 0.219];

x2 = [50, 150];
t2 = [0.185, 0.268];

%x2 = [150, 400];
%t2 = [0.15, 0.30];

V1 = (x1(2) - x1(1)) / (t1(2) - t1(1)); % delta (x) / delta (t)
V2 = (x2(2) - x2(1)) / (t2(2) - t2(1));

m2 = (t2(2) - t2(1)) / (x2(2) - x2(1)); % Line slope
ti = t2(1) - m2 * x2(1); % Intercept time

h = (ti * V1 * V2) / (2 * sqrt(V2^2 - V1^2)); % based on Snell's Law

fprintf('Velocity of Layer 1 (V1): %.2f m/s\n', V1);
fprintf('Velocity of Layer 2 (V2): %.2f m/s\n', V2);
fprintf('Intercept Time (ti): %.4f s\n', ti);
fprintf('Depth of Interface (h): %.2f m\n', h);

figure;

subplot(1,2,1); hold on;
plot(x1, t1, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
plot(x2, t2, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Receiver-Source Offset (m)');
ylabel('Time (s)');
title('Seismic Refraction Analysis');
legend('Layer 1', 'Layer 2');
grid on;

subplot(1,2,2); hold on;
plot([0, max(x2)], [ti, ti], 'g--', 'LineWidth', 2);
xlabel('Receiver-Source Offset (m)');
ylabel('Time (s)');
title('Intercept Time Line');
legend('Intercept Time (ti)');
grid on;
