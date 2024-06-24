%% Load files and calibration data

% files_S = {'S_rec1_2024-05-23.txt', 'S_rec2_2024-05-31.txt', 'S_rec3_2024-06-04.txt', 'S_rec4_2024-06-07.txt'};
% files_M = {'M_rec1_2024-05-27.txt', 'M_rec2_2024-06-01.txt', 'M_rec3_2024-06-05.txt', 'M_rec4_2024-06-10.txt'};
% files_L = {'L_rec1_2024-05-28.txt', 'L_rec2_2024-06-03.txt', 'L_rec3_2024-06-06.txt', 'L_rec4_2024-06-11.txt'};

files_M_mat2 = {'Mat2_rec1_2024-06-21.txt', 'Mat2_rec2_2024-06-22.txt', 'Mat2_rec3_2024-06-23.txt', 'Mat2_rec4_2024-06-24.txt'};

samplingRate = 1000; % Hz
ecgChannel = 3;
accChannels = [4, 5, 6]; % z, y, x respectively
accChannels_arm = [7, 8, 9]; % x, y, z respectively

[Cmin, Cmax] = getCalibrationData('calibrationFile.txt', ecgChannel, accChannels);


%% Process ecg and acc

TEST = 0;
if (TEST)
    time_vector = 1:(2*10000); 
else
    time_vector = 1:(((7*60 + 59)*60)*1000-360000); 
end


% fileSets = {files_L, files_M, files_S};
fileSets = {files_M_mat2};

for setIndex = 1:length(fileSets)
    currentFiles = fileSets{setIndex}; % ej: currentFiles = fileSets{1} -> files_L ->(...,...,....,....)

    for fileIndex = 1:length(currentFiles) % fileIndex = 1:length(currentFiles) = 4
        [ecg, accX_chest, accY_chest, accZ_chest, accX_arm, accY_arm, accZ_arm] = readPluxDataWithHeader(currentFiles{fileIndex}, ecgChannel, accChannels, accChannels_arm);
        ecg = ecg(time_vector);
        accX_chest = accX_chest(time_vector);
        accY_chest = accY_chest(time_vector);
        accZ_chest = accZ_chest(time_vector);
        accX_arm = accX_arm(time_vector);
        accY_arm = accY_arm(time_vector);
        accZ_arm = accZ_arm(time_vector);

        % calibrating and filtrating accelerometer values 
        % axis number (1 for X, 2 for Y, 3 for Z)
        accX_chest_filtered = calibrateRemoveGravity(accX_chest, Cmin(1), Cmax(1));
        accY_chest_filtered = calibrateRemoveGravity(accY_chest, Cmin(2), Cmax(2));
        accZ_chest_filtered = calibrateRemoveGravity(accZ_chest, Cmin(3), Cmax(3));
        totalMovement_chest = calculateTotalMovement(accX_chest_filtered, accY_chest_filtered, accZ_chest_filtered);

        accX_arm_filtered = calibrateRemoveGravity(accX_arm, Cmin(1), Cmax(1));
        accY_arm_filtered = calibrateRemoveGravity(accY_arm, Cmin(2), Cmax(2));
        accZ_arm_filtered = calibrateRemoveGravity(accZ_arm, Cmin(3), Cmax(3));
        totalMovement_arm = calculateTotalMovement(accX_arm_filtered, accY_arm_filtered, accZ_arm_filtered);

        % processing accelerometer values
        accX_chest_quantified = quantifyMovement(accX_chest_filtered, samplingRate);
        accY_chest_quantified = quantifyMovement(accY_chest_filtered, samplingRate);
        accZ_chest_quantified = quantifyMovement(accZ_chest_filtered, samplingRate);
        totalMovement_chest_quantified = quantifyMovement(totalMovement_chest, samplingRate);

        accX_arm_quantified = quantifyMovement(accX_arm_filtered, samplingRate);
        accY_arm_quantified = quantifyMovement(accY_arm_filtered, samplingRate);
        accZ_arm_quantified = quantifyMovement(accZ_arm_filtered, samplingRate);
        totalMovement_arm_quantified = quantifyMovement(totalMovement_arm, samplingRate);

        % processing electrocardiogram values
        [kSQI_01_vector, sSQI_01_vector, pSQI_01_vector, rel_powerLine01_vector, cSQI_01_vector, basSQI_01_vector, dSQI_01_vector, geometricMean_vector, averageGeometricMean] = mSQI(ecg, samplingRate);
        
        % combine vectors into a single matrix
        combinedData = [geometricMean_vector', accX_chest_quantified, accY_chest_quantified, accZ_chest_quantified, totalMovement_chest_quantified, accX_arm_quantified, accY_arm_quantified, accZ_arm_quantified, totalMovement_arm_quantified];
        
        % write and save processed data to a file
        outputFileName = ['processedData_' currentFiles{fileIndex}];
        writematrix(['indexes', 'movement_x_chest', 'movement_y_chest', 'movement_z_chest', 'movement_total_chest', 'movement_x_arm', 'movement_y_arm', 'movement_z_arm', 'movement_total_arm'], outputFileName, 'Delimiter', 'tab');
        writematrix(combinedData, outputFileName, 'Delimiter', 'tab', 'WriteMode', 'append');

        %fprintf("Average mean of windows of %s: %f\n", currentFiles{fileIndex}, averageGeometricMean);
    end
end
