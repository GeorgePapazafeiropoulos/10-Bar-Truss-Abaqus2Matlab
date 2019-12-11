function [c,ceq] = Truss10confun(x)
%
% Constraint function for the 10-bar truss optimization problem.
% 
% Syntax
%     [#c#,#ceq#] = Truss10confun(#x#);
%
% Description
%     This function calculates the inequalities and equalities which define
%     the constraints imposed on the fmincon optimization function
%     (built-in in MATLAB). If #c# is lower than zero then the constraints
%     regarding inequalities are considered to be satified. If #ceq# is
%     equal to zero, then the constraints regarding equalities are
%     considered to be satisfied.
%     
% Input parameters
%     #x# ([10 x 1]) is the vector containing the 10 design variables of
%         the 10-bar truss model.
% 
% Output parameters
%     #c# ([#n# x 1]) is the left hand sides of the #n# inequalities of the
%         form: #y#<=0, based on the values of the design variables as
%         specified in #x#.
%     #ceq# ([#m# x 1]) is the errors of the #m# equalities included in the
%         constraints, based on the values of the design variables as
%         specified in #x#. For the 10-bar truss optimization problem,
%         there are not any equality constraints, thus #ceq#=[].
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



global m j f
% set the stress and displacement limits of the 10-bar truss (maximum
% stress, minimum stress, maximum absolute value of horizontal displacment,
% maximum absolute value of the vertical displacement).
maxstress=25*ones(10,1);
minstress=-25*ones(10,1);
Dmaxhor=2;
Dmaxver=2;
% Construct the Abaqus input file Truss10ABAQUS.inp
Truss10InpFileConstr(x)
% Run the input file Truss10ABAQUS.inp with Abaqus
%!abaqus job=Truss10ABAQUS
runAbaqusAnalysis('Truss10ABAQUS',60,3)
% Assign all lines of the Truss10ABAQUS.fil file in an one-row string
% (after Abaqus analysis terminates)
Rec = Fil2str('Truss10ABAQUS.fil');
% Obtain the element axial forces
out = Rec13(Rec);
EleForces=out(1:3:end,1);
% Obtain the nodal displacements
out2 = Rec101(Rec);
NodalDisplacements=out2(:,2:3);
% Delete the files of last Abaqus run to avoid Abaqus abort when it
% tries to rewrite them
java.io.File('Truss10ABAQUS.inp').delete();
java.io.File('Truss10ABAQUS.fil').delete();
java.io.File('Truss10ABAQUS.prt').delete();
java.io.File('Truss10ABAQUS.com').delete();
java.io.File('Truss10ABAQUS.sim').delete();
% Calculate the element stresses
EleStresses=EleForces./x;
% Calculate the maximum nodal displacements
maxNodDisplX1=max(abs(NodalDisplacements(:,1)));
maxNodDisplY1=max(abs(NodalDisplacements(:,2)));
% Assemble the constraints
c = [EleStresses-maxstress; maxNodDisplY1-Dmaxver; maxNodDisplX1-Dmaxhor; -EleStresses+minstress; -maxNodDisplY1-Dmaxver; -maxNodDisplX1-Dmaxhor];
ceq = [];

% Save all variables, clear and reload to save memory
evalin('base','save(''Abaqus2MatlabVars'')');
evalin('base','clear java');
evalin('base','load(''Abaqus2MatlabVars'')');

% Plot of free memory
n = java.lang.Runtime.getRuntime.freeMemory;
m=[m,n];
figure( f );
fig = gcf; % current figure handle
fig.Name='Runtime Free Memory';
fig.NumberTitle='off';
plot( m );
drawnow;
j=j+1;

 
end