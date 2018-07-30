-----------------------------------------------------------------------------------------

MLE_short

coded in MATLAB R2012a

Bo Shuang
Landes Research Group
Rice University
Department of Chemistry

March 2013

for details about MLE (1) and MLE (2), see:
Shuang, B.; Byers, C.P.; Kisley, L.; Wang, L.Y.; Zhao, J.; Morimura, H.; Link, S.; Landes, C. F. "Improved analysis for determining diffusion coefficients from short, single-molecule trajectories with photoblinking" Langmuir 2013, 29(1), 228-234.

-----------------------------------------------------------------------------------------
Instructions for installation:

If you are using the MATLAB source, extract to any directory you like.  Before its first use, add the directory to the MATLAB path.  MLE_short will add its directory to the path after its first launch. The main function is MLE_short.m


----------------------------------------------------------------------------------------
Instructions for use:

To run, simply install and type 'MLE_short' at the MATLAB prompt.

Prepare your trajectory in matlab format (.mat). Your trajectories should be a three dimensional matrix: first is time, second is x and y position, and third is the number of trajectory.

MLE_short will calculate diffusion coefficient for each trajectory and save the result in the same folde. The name will be 'yourfile_difcoe.mat'. Also, a histogram of the diffusion coefficient will be generated.


-------------------------------------------------------------------------------------------
