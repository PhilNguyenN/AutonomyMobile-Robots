clc; 

%D = dlmread('LandTamerLawn_filtered.data');
D = dlmread('LandTamerLawn_raw.data');
%D = dlmread('LandTamerGravel1_filtered.data');
%D = dlmread('LandTamerGravel1_raw.data');
%D = dlmread('LandTamerGravel2_filtered.data');
%D = dlmread('LandTamerGravel2_raw.data');

command_data =[];
sensor_data = [];

for i = 1:1:size(D,1)
    if isnan(D(i,2))
        sensor_data = cat(2,sensor_data,[D(i,1) D(i,4) D(i,5) D(i,9)]'); % the cat function (2) tells it to add B as additional columns of A.
    else
        command_data = cat(2,command_data,[D(i,1) D(i,2) D(i,3)]');
    end
end



