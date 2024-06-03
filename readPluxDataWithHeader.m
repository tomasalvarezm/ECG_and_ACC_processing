% This function reads data from a file recorded by Bitalino/Plux devices,
% extracts the specified ECG channel and accelerometer channels, and converts 
% the ECG data to millivolts. The function returns the ECG data and the accelerometer 
% data (X, Y, Z axes) as separate output variables.

function [ECG_mv, accX, accY, accZ] = readPluxDataWithHeader(fileName, ecgChannel, accChannels)
    % Read data from the first file
    ecg = importdata(fileName);
    data_ecg = ecg.data(:, ecgChannel);
    data_acc = ecg.data(:, accChannels);
    
    % Convert ECG data to millivolts
    %https://support.pluxbiosignals.com/knowledge-base/transfer-functions-converting-digital-sensor-data-into-physical-units/
    ECG_v = (((data_ecg/2^16)-1/2)*3)/1019;
    ECG_mv = ECG_v * 1000;
    
    % Separate accelerometer axes
    accX = data_acc(:, 1);
    accY = data_acc(:, 2);
    accZ = data_acc(:, 3);
    
end