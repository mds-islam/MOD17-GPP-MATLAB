%% RUN EVERY SECTION BELOW CONSECUTIVELY %%
% Md Saiful Islam
% Summer intern for RAMONA project, Summer 2022
%Dept. of Physical Geography and Ecosystem Science, Lund University

%% 1. Set up Intial Parameter

params = [1.206]; % LUEmax value for Savanna ecosystem according to MOD17
%% 2. Run the Model

[gpp_scalar] = GPP_dahra(params);

%% 3. Calibration
% Run model with initial parameters & calculate RMSE and subset cal data

[RMSE] = calibrate_gpp(params);
RMSE_BeforeCal = RMSE;

% Scatter Plot observed vs modelled GPP with R^2 values
%input the observed data
gpp_2020 = xlsread('Dahra_GPP_2019_2021',2);
gpp_obs = abs(gpp_2020(:,1)); %returns absolute values of negative values from flux data

figure
scatter(gpp_obs,gpp_scalar);
xlabel('Observed GPP (g C/m^2/day)');
ylabel('Modelled GPP (g C/m^2/day)');
title('GPP Before Calibration');
hold on
plot(0:13,0:13,'-');
%% 4. fminsearch (Finding optimum parameter value for LUEmax in Savanna)
% Run fminsearch to find best parameter
result = fminsearch(@calibrate_gpp, [params]);

% Set up new parameters
params = result; % The optimum parameter from fminsearch will be used for validation. The model will run again using this new LUEmax value.
%% Run the Model AGAIN with new parameter value

[gpp_scalar] = GPP_dahra(params);
%% 5. Run validation
% Run model with new parameters and calculate RMSE using the second half data
[RMSE] = validate_gpp(params);
RMSE_AfterCal = RMSE;

% Scatter Plot after calibration
figure
scatter(gpp_obs,gpp_scalar);
xlabel('Observed GPP (g C/m^2/day)');
ylabel('Modelled GPP (g C/m^2/day)');
title('GPP After Calibration');
hold on
plot(0:13,0:13,'-');

%% 6. Sensitivity of GPP to LUEmax
% Load LUE values of Savanna collected from literature for testing
LUE_Savanna_Literature = xlsread('LUE_Savanna.xlsx'); %import data from excel
LUE_Savanna = LUE_Savanna_Literature(:,1);
nsample = length(LUE_Savanna);
params = LUE_Savanna;
sim_gpp = zeros(nsample,366);

for v = 1:nsample
    [gpp_scalar] = GPP_dahra(params(v));
    sim_gpp(v, :) = gpp_scalar;
end
%% 7. Calculate Statistics
% Annual GPP in 2022 for different parameter values
sum_sim_gpp = sum(sim_gpp, 2);

% RMSE for different parameter values
sim_rmse = zeros(nsample,1);
for a = 1:nsample
    [RMSE] = calibrate_gpp(params(a));
    sim_rmse(a, :) = RMSE;
end