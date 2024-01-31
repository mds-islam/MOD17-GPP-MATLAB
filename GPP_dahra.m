function [gpp_scalar] = GPP_dahra(params)
%Md Saiful Islam
%Summer intern for RAMONA project, Summer 2022
%Dept. of Physical Geography and Ecosystem Science, Lund University
%% Input
% Import drivers data from spreadsheet (data already converted from csv to
% excel format
drivers_2020 = xlsread('Drivers_2020_Excl.xlsx'); %import data from excel
%% Data preparation
%Convert array into table and assign column name
% table_2020 = array2table(drivers_2020,'VariableNames',{'PAR','FAPAR','T_MIN','VPD','RH','TA'});

%split each colum from the table to make individual variable vector
par = drivers_2020(:,1);
fapar = drivers_2020(:,2);
t_min = drivers_2020(:,3);
vpd = drivers_2020(:,4);
rh = drivers_2020(:,5);
t_avg = drivers_2020(:,6);

%% Set up parameters (initial values before calibration)

%LUEmax_grass = 0.5; %max LUE for grassland
LUEmax_savanna = params; %1.206; %initial LUEmax value for savanna according to MOD17 user guide
%LUEmax_crop = 0.5; %max LUE for cropland
VPDmin = 650; %min(vpd);  %The daylight average vapor pressure deficit at which LUE is 0 (at any TMIN)
VPDmax = 3100; %max(vpd); %The daylight average vapor pressure deficit at which LUE = LUEmax (for optimal TMIN)
T_MINmin = -8.00; %min(t_min);
T_MINmax = 11.39; %max(t_min);

%% Basic GPP model (without scalar)
%compute GPP from drivers data provided for Dahra site in Senegal
for d = 1:length(par) %model runs from first observation of PAR to the end
    gpp(d) = par(d) * fapar(d) * LUEmax_savanna;
    
    gpp_basic(d) = gpp(d);
    gpp_basic = transpose(gpp_basic); %GPP without considering scalar.
  
end

%% GPP model (with VPD and Tmin scalar)
for d = 1:length(par) %model runs from first observation of PAR to the end
    
    % VPD Scalar according to Lin et al. 2017
    
    if vpd(d) >= VPDmax
        fVPD(d) = 0; %fVPD is scalar for VPD
    elseif VPDmin < vpd(d) < VPDmax
        fVPD(d) = (VPDmax - vpd(d))/(VPDmax - VPDmin);
    else
        fVPD(d) = 1;
    end

    % VPD Scalar according to Running and Zhao, 2015 (MOD17)
    
%     fVPD(d) = 1 - ((vpd(d) - VPDmin)/(VPDmax - VPDmin)); 
    
    % Tmin Scalar according to Lin et al. 2017
    
    if t_min(d) <= T_MINmin
        fTmin(d) = 0;
    elseif T_MINmin < t_min(d) < T_MINmax
        fTmin(d) = (t_min(d) - T_MINmin)/(T_MINmax - T_MINmin);
    else
        fTmin(d) = 1;
    end
    
    % Tmin scalar according to Running and Zhao, 2015 (MOD17)
    
%     fTmin(d) = (t_min(d) - T_MINmin)/(T_MINmax - T_MINmin);
    
    % Calculating LUE - a product of LUEmax and scalars

    LUE(d) = LUEmax_savanna * fVPD(d) * fTmin(d); % LUE is a product of LUEmax and scalars (VPD and Tmin in this case)
    
    % Simulating GPP
    
    gpp_2(d) = par(d) * fapar(d) * LUE(d); % GPP based on LUE considering scalars
    
    gpp_scalar(d) = gpp_2(d);
    gpp_scalar = transpose(gpp_scalar);%GPP considering VPD and Tmin scalar to restrict LUEmax.
  
end