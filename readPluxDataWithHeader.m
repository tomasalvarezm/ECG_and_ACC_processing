% This function reads data from a file recorded by Bitalino/Plux devices,
% extracts the specified ECG channel and accelerometer channels, and converts 
% the ECG data to millivolts. The function returns the ECG data and the accelerometer 
% data (X, Y, Z axes) as separate output variables.

function [ECG_mv, accX, accY, accZ, accX_2, accY_2, accZ_2] = readPluxDataWithHeader(fileName, ecgChannel, accChannels, accChannels_2)
    % Read data from the first file
    ecg = importdata(fileName);
    data_ecg = ecg.data(:, ecgChannel);
    data_acc = ecg.data(:, accChannels);
    data_acc_2 = ecg.data(:, accChannels_2);
    
    % Convert ECG data to millivolts
    %https://support.pluxbiosignals.com/knowledge-base/transfer-functions-converting-digital-sensor-data-into-physical-units/
    ECG_v = (((data_ecg/2^16)-1/2)*3)/1019;
    ECG_mv = ECG_v * 1000;
    
    % Separate accelerometer axes
    accX = data_acc(:, 3);
    accY = data_acc(:, 2);
    accZ = data_acc(:, 1);

    accX_2 = data_acc_2(:, 1);
    accY_2 = data_acc_2(:, 2);
    accZ_2 = data_acc_2(:, 3);
    
end
