data_file = "robot_data/data_csv/arm_data.csv";
test_data = "robot_data/data_csv/arm_test_data.csv";
test_data_csv = readtable(test_data);
test_data_array = table2array(test_data_csv);
data_csv = readtable(data_file);
data_array = table2array(data_csv);

arm_x = data_array(:,7);
arm_y = data_array(:,8);
arm_z = data_array(:,9);

j1 = data_array(:,1);
j2 = data_array(:,2);
j3 = data_array(:,3);
j4 = data_array(:,4);
j5 = data_array(:,5);
j6 = data_array(:,6);

data_in = [arm_x,arm_y,arm_z];

j1_train = [data_in, j1];
j2_train = [data_in, j2];
j3_train = [data_in, j3];
j4_train = [data_in, j4];
j5_train = [data_in, j5];
j6_train = [data_in, j6];

j1_fis = readfis("fis/j1.fis");
j2_fis = readfis("fis/j2.fis");
j3_fis = readfis("fis/j3.fis");
j4_fis = readfis("fis/j4.fis");
j5_fis = readfis("fis/j5.fis");
j6_fis = readfis("fis/j6.fis");

j1_out = evalfis(j1_fis,data_in);
j2_out = evalfis(j1_fis,data_in);
j3_out = evalfis(j1_fis,data_in);
j4_out = evalfis(j1_fis,data_in);
j5_out = evalfis(j1_fis,data_in);
j6_out = evalfis(j1_fis,data_in);

