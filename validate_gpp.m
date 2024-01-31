function [RMSE] = validate_gpp(params)

%Md Saiful Islam
%Summer intern for RAMONA project, Summer 2022
%Dept. of Physical Geography and Ecosystem Science, Lund University

%input the observed data
gpp_2020 = xlsread('Dahra_GPP_2019_2021',2);
gpp_obs = abs(gpp_2020(:,1)); %returns absolute values of negative values from flux data

% Call GPP_dahra function to generate simulated GPP (using new params)
[gpp_scalar] = GPP_dahra(params);

% RMSE Calculation
N = length(gpp_obs); % Total lenght of the data of interest
N2 = ceil(N/2); % First half of the data will be used for calibration and second half (N2+1:N) will be used for validation
meanSum = 0;

% for i = 1:N %1:N2 for first half, and N2+1:N for second half
%     M_i = gpp_scalar(i);
%     O_i = gpp_obs(i);
%     MSE_i = ((M_i - O_i)^2);
%     meanSum = meanSum + MSE_i;
%     i = i + 1;
% end
% 
% %mse = meanSum/N;
% 
% RMSE = sqrt(meanSum/N); % RMSE after calibration

RMSE = sqrt(mean((gpp_obs(:)-gpp_scalar(:)).^2));

end