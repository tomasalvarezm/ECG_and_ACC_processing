% This function combines data from two files recorded by Bitalino/Plux devices,
% extracts the specified ECG channel and accelerometer channels, and converts 
% the ECG data to millivolts. The function returns the ECG data and the accelerometer 
% data (X, Y, Z axes) as separate output variables.

function [ECG_mv, Acc_X, Acc_Y, Acc_Z] = CombinePluxDataWithHeader(fileName1, fileName2, ecgChannel, accChannels)
    % Read data from the first file
    ecg1 = importdata(fileName1);
    data1_ecg = ecg1.data(:, ecgChannel);
    data1_acc = ecg1.data(:, accChannels);
    
    % Read data from the second file
    ecg2 = importdata(fileName2);
    data2_ecg = ecg2.data(:, ecgChannel);
    data2_acc = ecg2.data(:, accChannels);
    
    % Combine data from both files
    combinedData_ecg = [data1_ecg; data2_ecg];
    combinedData_accel = [data1_acc; data2_acc];
    
    % Convert ECG data to millivolts
    %https://support.pluxbiosignals.com/knowledge-base/transfer-functions-converting-digital-sensor-data-into-physical-units/
    combinedData_ecg_v = (((combinedData_ecg/2^16)-1/2)*3)/1019;
    ECG_mv = combinedData_ecg_v * 1000;
    
    % Convert accelerometer data to millivolts
    %combinedData_accel_v = (((combinedData_accel/2^16)-1/2)*3)/1019;
    %combinedData_accel_mv = combinedData_accel_v * 1000;
    
    % Separate accelerometer axes
    Acc_X = combinedData_accel(:, 1);
    Acc_Y = combinedData_accel(:, 2);
    Acc_Z = combinedData_accel(:, 3);
    
end
