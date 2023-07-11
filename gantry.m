data_file = "robot_data/data_csv/gantry_data.csv";
test_data = "robot_data/data_csv/gantry_test_data.csv";
test_data_csv = readtable(test_data);
test_data_array = table2array(test_data_csv);
data_csv = readtable(data_file);
data_array = table2array(data_csv);
gantry_x = data_array(1:874,1);
gantry_y = data_array(875:1874,2);
gantry_z = data_array(1875:2874,3);

pos_x = data_array(1:874,4);
pos_y = data_array(875:1874,5);
pos_z = data_array(1875:2874,6);
train_x = [pos_x,gantry_x];
train_y = [pos_y,gantry_y];
train_z = [pos_z,gantry_z];

test_x = test_data_array(1:980,4);
test_y = test_data_array(981:1980,5);
test_z = test_data_array(1981:2980,6);

test_pos_x = test_data_array(1:980,1);
test_pos_y = test_data_array(981:1980,2);
test_pos_z = test_data_array(1981:2980,3);
% OPTG = genfisOptions("GridPartition");
% OPTG.NumMembershipFunctions = 10;
% OPTG.InputMembershipFunctionType = "gaussmf";
% 
% fis = genfis(pos_x,gantry_x,OPTG);
% 
% opt = anfisOptions("InitialFIS",fis,"EpochNumber",100);
% 
% afs = anfis(train_x,opt);
fis_x = readfis("fis/gantry_x.fis");
fis_y = readfis("fis/gantry_y.fis")
fis_z = readfis("fis/gantry_z.fis")

anfis_out_x = evalfis(fis_x,test_x);
anfis_out_y = evalfis(fis_y,test_y);
anfis_out_z = evalfis(fis_z,test_z);

% Get 900 first data to plot
anfis_x_plot = anfis_out_x(1:900,:);
anfis_y_plot = anfis_out_y(1:900,:);
anfis_z_plot = anfis_out_z(1:900,:);

err_x = test_pos_x - anfis_out_x;
err_y = test_pos_y - anfis_out_y;
err_z = test_pos_z - anfis_out_z;

% Get 900 first data to plot
err_x_plot = err_x(1:900,:);
err_y_plot = err_y(1:900,:);
err_z_plot = err_z(1:900,:);

real_x_plot = test_pos_x(1:900,:);
real_y_plot = test_pos_y(1:900,:);
real_z_plot = test_pos_z(1:900,:);

figure("Name","Result using ANFIS and result using numerical method","NumberTitle","off");
scatter3(anfis_x_plot,anfis_y_plot,anfis_z_plot,"*","blue","DisplayName","ANFIS");
xlabel('X');
ylabel('Y');
zlabel("Z");
hold on;
scatter3(real_x_plot,real_y_plot,real_z_plot,"o","red","DisplayName","Numerical");
title("Result using ANFIS and result using numerical method");
hold off;
legend;

figure("Name","Error between ANFIS and numerical method","NumberTitle","off");
scatter3(err_x_plot,err_y_plot,err_z_plot,"red",".","DisplayName","Error");
title("Error between ANFIS and numerical method");
xlabel('X');
ylabel('Y');
zlabel("Z");


