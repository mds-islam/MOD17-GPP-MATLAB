# MOD17-GPP
MOD17 is an algorithm to simulate gross primary productivity (GPP) using light use efficiency principles. I created this script to implement the MOD17 model for a savanna ecosystem in Sub-Saharan Africa. However, the model can be implemented anywhere with correct input variables and parameter values.

This repository contains codes for the model algorithms based on the following papers:

For the main model:

Running SW, Zhao M (2019) User's Guide: Daily GPP and Annual NPP (MOD17A2H/A3H) and Year-end GapFilled (MOD17A2HGF/A3HGF) Products NASA Earth Observing System MODIS Land Algorithm (For Collection 6).

For estimating the scalars:

Lin X, Chen B, Chen J et al. (2017) Seasonal fluctuations of photosynthetic parameters for light use efficiency models and the impacts on gross primary production estimation. Agricultural and Forest Meteorology 236: 22-35

The "READ ME_Steps_to_run_Scripts.txt" file contains step-by-step instructions for running the scripts.

Also, the "Sample_data_params" directory contains some sample data to run the model, and the "Sample_output_figures" directory contains a few examples of the model outputs.

Overall, the codes here are used to run the GPP model, calibrate the model to optimize the maximum light use efficiency parameter and validate the model.

![image](https://github.com/mds-islam/MOD17-GPP-MATLAB/assets/158111120/74e59b16-4af4-4279-806d-1689bd27e038)

Fig.1 Observed vs simulated GPP with initial LUEmax value (1.206). R^2 = 0.8697, RMSE = 2.03 g C/m2/day

![image](https://github.com/mds-islam/MOD17-GPP-MATLAB/assets/158111120/0ef1b93e-5f08-4233-8f71-ecf671e2a773)

Fig.2 Observed vs simulated GPP with optimized LUEmax value (2.30). R^2 = 0.8697, RMSE = 1.16 g C/m2/day


