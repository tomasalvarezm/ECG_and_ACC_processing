%% Load files and calibration data

files_S = {'S_rec1_2024-05-23.txt', 'S_rec2_2024-05-31.txt', 'S_rec3_2024-06-04.txt'};
files_M = {'M_rec1_2024-05-27.txt', 'M_rec2_2024-06-01.txt', 'M_rec3_2024-06-05.txt'};
files_L = {'L_rec1_2024-05-28.txt', 'L_rec2_2024-06-03.txt', 'L_rec3_2024-06-06.txt'};

%files_S = {'S_rec1_2024-05-23.txt'};
%files_M = {'M_rec1_2024-05-27.txt'};
%files_L = {'L_rec1_2024-05-28.txt'};

samplingRate = 1000; % Hz
ecgChannel = 3;
accChannels = [4, 5, 6]; % z, y, x respectively

[Cmin, Cmax] = getCalibrationData('calibrationFile.txt', ecgChannel, accChannels);


%% Process ecg and acc

TEST = 0;

if (TEST)
    time_vector = 1:(2*10000); 
else
    time_vector = 1:(((7*60 + 59)*60)*1000-360000); 
end


fileSets = {files_L, files_M, files_S};

indexes = cell(1, length(fileSets)); % indexes = cell(1, length(fileSets)); -> vector de 3 pos
movement_x = cell(1, length(fileSets));
movement_y = cell(1, length(fileSets));
movement_z = cell(1, length(fileSets));
movement_total = cell(1, length(fileSets));

for setIndex = 1:length(indexes)
    currentFiles = fileSets{setIndex}; % ej: currentFiles = fileSets{1} -> files_L ->(...,...,....,....)
    
    indexes{setIndex} = cell(1, length(currentFiles)); % indexes{1} = a un vector con 4 pos
    movement_x{setIndex} = cell(1, length(currentFiles));
    movement_y{setIndex} = cell(1, length(currentFiles));
    movement_z{setIndex} = cell(1, length(currentFiles));
    movement_total{setIndex} = cell(1, length(currentFiles));

    for fileIndex = 1:length(currentFiles) % fileIndex = 1:length(currentFiles) = 4
        [ecg, accX, accY, accZ] = readPluxDataWithHeader(currentFiles{fileIndex}, ecgChannel, accChannels);
        ecg = ecg(time_vector);
        accX = accX(time_vector);
        accY = accY(time_vector);
        accZ = accZ(time_vector);

        % calibrating and filtrating accelerometer values
        % axis number (1 for X, 2 for Y, 3 for Z)
        accX_filtered = calibrateRemoveGravity(accX, Cmin(1), Cmax(1));
        accY_filtered = calibrateRemoveGravity(accY, Cmin(2), Cmax(2));
        accZ_filtered = calibrateRemoveGravity(accZ, Cmin(3), Cmax(3));

        totalMovement = calculateTotalMovement(accX_filtered, accY_filtered, accZ_filtered);

        % processing accelerometer values
        accX_quantified = quantifyMovement(accX_filtered, samplingRate);
        accY_quantified = quantifyMovement(accY_filtered, samplingRate);
        accZ_quantified = quantifyMovement(accZ_filtered, samplingRate);
        totalMovement_quantified = quantifyMovement(totalMovement, samplingRate);

        % processing electrocardiogram values
        [kSQI_01_vector, sSQI_01_vector, pSQI_01_vector, rel_powerLine01_vector, cSQI_01_vector, basSQI_01_vector, dSQI_01_vector, geometricMean_vector, averageGeometricMean] = mSQI(ecg, samplingRate);
        
        % storing processed values 
        indexes{setIndex}{fileIndex} = geometricMean_vector;
        movement_x{setIndex}{fileIndex} = accX_quantified;
        movement_y{setIndex}{fileIndex} = accY_quantified;
        movement_z{setIndex}{fileIndex} = accZ_quantified;
        movement_total{setIndex}{fileIndex} = totalMovement_quantified;
        
        % combine vectors into a single matrix
        combinedData = [geometricMean_vector', accX_quantified', accY_quantified', accZ_quantified', totalMovement_quantified'];
        
        % write and save processed data to a file
        outputFileName = ['processedData_' currentFiles{fileIndex}];
        writematrix(['indexes', 'movement_x', 'movement_y', 'movement_z', 'movement_total'], outputFileName, 'Delimiter', 'tab');
        writematrix(combinedData, outputFileName, 'Delimiter', 'tab', 'WriteMode', 'append');

        fprintf("Average mean of windows of %s: %f\n", currentFiles{fileIndex}, averageGeometricMean);
    end
end

%% Compare mean and median difference

%indexes_shirt_L = indexes{1};
%indexes_shirt_M = indexes{2};
%indexes_shirt_S = indexes{3};