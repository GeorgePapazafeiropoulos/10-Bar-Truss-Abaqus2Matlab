function f = Truss10objfun(x)
%
% Objective function for the 10-bar truss optimization problem.
% 
% Syntax
%     #f# = Truss10objfun(#x#);
%
% Description
%     This function calculates the total wieght of the 10-bar truss. This
%     weight is to be minimizaed by the optimization algorithm.
%     
% Input parameters
%     #x# ([10 x 1]) is the vector containing the 10 design variables of
%         the 10-bar truss model.
% 
% Output parameters
%     #f# ([1 x 1]) is the weight of the truss based on the values of the
%         design variables as specified in #x#.
%
% _________________________________________________________________________
% Abaqus2Matlab - www.abaqus2matlab.com
% Copyright (c) 2019 by George Papazafeiropoulos
%
% If using this toolbox for research or industrial purposes, please cite:
% G. Papazafeiropoulos, M. Muniz-Calvente, E. Martinez-Paneda.
% Abaqus2Matlab: a suitable tool for finite element post-processing.
% Advances in Engineering Software. Vol 105. March 2017. Pages 9-16. (2017) 
% DOI:10.1016/j.advengsoft.2017.01.006
%


u=360;
f = 0.1*x'*u*[1;1;1;1;1;1;sqrt(2);sqrt(2);sqrt(2);sqrt(2)];
end
