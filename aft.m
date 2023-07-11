x=-10:0.5:10;
y=-10:0.5:10;
[X,Y]= meshgrid(x,y);
[row,col]=size(X);

r= sqrt(X.^2+Y.^2);
Z=sin(r+eps)./(r+eps);

figure(1);
surf(Z);

L1 = reshape(X,[row*col,1]);
L2 = reshape(Y,[row*col,1]);
L3 = reshape(Z,[row*col,1]);

data = [L1,L2,L3];

OPTG = genfisOptions("GridPartition");
OPTG.NumMembershipFunctions = 6;
OPTG.InputMembershipFunctionType = "gaussmf";

fis = genfis(data(:,1:2),data(:,3),OPTG);

opt = anfisOptions("InitialFIS",fis,"EpochNumber",100);

afs = anfis(data,opt);

anfis_out = evalfis(afs,data(:,1:2));
O=reshape(anfis_out,[row,col]);

figure(2);
surf(O);

error = Z-O;
figure(3);
surf(error);
