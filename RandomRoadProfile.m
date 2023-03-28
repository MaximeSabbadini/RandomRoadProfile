close all;
clear variables;
clc;

%% Parameters for the road profile

N = 500; % Number of samples

v = 80/3.6; % Speed
t = linspace(0, 250/(v), N); % Time vector

s = v*t; % Space coordinate (m)

Om_min = 2*pi/100; % Min frequency
Om_max =2*pi*10; % Max frequency

dOm = (Om_max-Om_min)/(N-1); % Space between frequency samples
Om = Om_min:dOm:Om_max; % Frequency vector
Om_0 = 1; % Ref wavenumber

w = 2; % Waviness
Phi_0 = 10e-6; % Depends on the class of the road

Phi = Phi_0.*(Om./Om_0).^(-w); 

rng("default");
Psi = 2*pi*rand(size(Om)); % Phase angles

Amps = sqrt(2*Phi*dOm); % Amplitudes

%% Giving the parameters into a structure
p.Amp = Amps;
p.v = v;
p.Om = Om;
p.Psi = Psi;

zr = zeros(size(t)); % Road elevation vector

%% Compute the road elevation for each time step

for i=1:length(t)
    zr(i) = fun_02_qcm_road(t(i), p);
end


%% Plot the results

figure(1)
plot(s, zr, 'k-', 'LineWidth', 2);
title('Random Road Profile')
xlabel('Distance (m)')
ylabel('Road Elevation (m)')
ylim([-0.1 0.1])
grid on;
