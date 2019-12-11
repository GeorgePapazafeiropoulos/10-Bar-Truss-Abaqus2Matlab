%% Matlab_Abaqus_10_Bar_Truss
% Find the cross-sections of the members of the 10-bar truss so that its
% weight is minimized and the constraints are satisfied. For more
% information please see the <Documentation.html Documentation of
% Matlab_Abaqus_10_Bar_Truss package>.

%%
% Initialize variables
format long
global m j f
f=1;
m = zeros( 1, 0 );
j=1;
%%
% Make a starting guess for the solution.
x0 = [30.9810; 0.1; 23.1714; 15.6935; 0.1; 0.5848; 7.4298; 20.6310; 21.3287; 0.1];
%%
% Set the lower and upper limit of the cross section areas of the ten
% members of the truss.
AreaMin=0.1;
AreaMax=35;
lb=AreaMin*ones(1,10);
ub=AreaMax*ones(1,10);
%%
% Initialize timer.
tic
%%
% Perform the optimization of the truss (constrained optimization with
% fmincon).
[X,fval,exitflag,output,lambda] = fmincon(@Truss10objfun,x0,[],[],[],[], lb ,ub,'Truss10confun')
%%
% Report elapsed time.
toc

%%
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
