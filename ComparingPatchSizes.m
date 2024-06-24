%% Compare mean and median difference

processed_files_S = {'processedData_S_rec1_2024-05-23.txt', 'processedData_S_rec2_2024-05-31.txt', 'processedData_S_rec3_2024-06-04.txt', 'processedData_S_rec4_2024-06-07.txt'};
processed_files_M = {'processedData_M_rec1_2024-05-27.txt', 'processedData_M_rec2_2024-06-01.txt', 'processedData_M_rec3_2024-06-05.txt', 'processedData_M_rec4_2024-06-10.txt'};
processed_files_L = {'processedData_L_rec1_2024-05-28.txt', 'processedData_L_rec2_2024-06-03.txt', 'processedData_L_rec3_2024-06-06.txt', 'processedData_L_rec4_2024-06-11.txt'};

processed_fileSets = {processed_files_L, processed_files_M, processed_files_S};

indexes = cell(1, length(processed_fileSets)); % indexes = cell(1, length(fileSets)); -> 1x3 cell array
movement_x = cell(1, length(processed_fileSets));
movement_y = cell(1, length(processed_fileSets));
movement_z = cell(1, length(processed_fileSets));
movement_total = cell(1, length(processed_fileSets));

for setIndex = 1:length(indexes)
    currentFiles = processed_fileSets{setIndex}; % ej: currentFiles = fileSets{1} -> files_L ->(...,...,....,....)
    
    indexes{setIndex} = cell(1, length(currentFiles)); % indexes{1} = 1x4 cell array
    movement_x{setIndex} = cell(1, length(currentFiles));
    movement_y{setIndex} = cell(1, length(currentFiles));
    movement_z{setIndex} = cell(1, length(currentFiles));
    movement_total{setIndex} = cell(1, length(currentFiles));

    for fileIndex = 1:length(currentFiles) % fileIndex = 1:length(currentFiles) = 4

        data = importdata(currentFiles{fileIndex});

        indexes{setIndex}{fileIndex} = data.data(:, 1);
        movement_x{setIndex}{fileIndex} = data.data(:, 2);
        movement_y{setIndex}{fileIndex} = data.data(:, 3);
        movement_z{setIndex}{fileIndex} = data.data(:, 4);
        movement_total{setIndex}{fileIndex} = data.data(:, 5);

        plot_movement_vs_ecg(indexes{setIndex}{fileIndex}, movement_x{setIndex}{fileIndex}, movement_y{setIndex}{fileIndex}, ...
            movement_z{setIndex}{fileIndex}, movement_total{setIndex}{fileIndex}, currentFiles{fileIndex});
    end
end

% ECG quality indexes
indexes_L = indexes{1};
indexes_M = indexes{2};
indexes_S = indexes{3};

% quantified movement
movement_x_L = movement_x{1};
movement_y_L = movement_y{1};
movement_z_L = movement_z{1};
movement_total_L = movement_total{1};

movement_x_M = movement_x{2};
movement_y_M = movement_y{2};
movement_z_M = movement_z{2};
movement_total_M = movement_total{2};

movement_x_S = movement_x{3};
movement_y_S = movement_y{3};
movement_z_S = movement_z{3};
movement_total_S = movement_total{3};

% Comparison...
% data for the Comparison Within Each Register

% data of Shirt L that will be used for the CI
indexes_L_R2R3R4 =[indexes_L{2};indexes_L{3};indexes_L{4}]; % indexes_L_R2R3R4 -> R2:register2, R3:register3, R4:register of Shirt L
indexes_L_R1R3R4 =[indexes_L{1};indexes_L{3};indexes_L{4}];
indexes_L_R1R2R4 =[indexes_L{1};indexes_L{2};indexes_L{4}];
indexes_L_R1R2R3 =[indexes_L{1};indexes_L{2};indexes_L{3}];

xmov_L_R2R3R4 =[movement_x_L{2};movement_x_L{3};movement_x_L{4}]; 
xmov_L_R1R3R4 =[movement_x_L{1};movement_x_L{3};movement_x_L{4}];
xmov_L_R1R2R4 =[movement_x_L{1};movement_x_L{2};movement_x_L{4}];
xmov_L_R1R2R3 =[movement_x_L{1};movement_x_L{2};movement_x_L{3}];

ymov_L_R2R3R4 =[movement_y_L{2};movement_y_L{3};movement_y_L{4}]; 
ymov_L_R1R3R4 =[movement_y_L{1};movement_y_L{3};movement_y_L{4}];
ymov_L_R1R2R4 =[movement_y_L{1};movement_y_L{2};movement_y_L{4}];
ymov_L_R1R2R3 =[movement_y_L{1};movement_y_L{2};movement_y_L{3}];

zmov_L_R2R3R4 =[movement_z_L{2};movement_z_L{3};movement_z_L{4}]; 
zmov_L_R1R3R4 =[movement_z_L{1};movement_z_L{3};movement_z_L{4}];
zmov_L_R1R2R4 =[movement_z_L{1};movement_z_L{2};movement_z_L{4}];
zmov_L_R1R2R3 =[movement_z_L{1};movement_z_L{2};movement_z_L{3}];

tmov_L_R2R3R4 =[movement_total_L{2};movement_total_L{3};movement_total_L{4}]; 
tmov_L_R1R3R4 =[movement_total_L{1};movement_total_L{3};movement_total_L{4}];
tmov_L_R1R2R4 =[movement_total_L{1};movement_total_L{2};movement_total_L{4}];
tmov_L_R1R2R3 =[movement_total_L{1};movement_total_L{2};movement_total_L{3}];

% data of Shirt M that will be used for the CI
indexes_M_R2R3R4 =[indexes_M{2};indexes_M{3};indexes_M{4}]; % indexes_M_R2R3R4 -> R2:register2, R3:register3, R4:register of Shirt M
indexes_M_R1R3R4 =[indexes_M{1};indexes_M{3};indexes_M{4}];
indexes_M_R1R2R4 =[indexes_M{1};indexes_M{2};indexes_M{4}];
indexes_M_R1R2R3 =[indexes_M{1};indexes_M{2};indexes_M{3}];

xmov_M_R2R3R4 =[movement_x_M{2};movement_x_M{3};movement_x_M{4}]; 
xmov_M_R1R3R4 =[movement_x_M{1};movement_x_M{3};movement_x_M{4}];
xmov_M_R1R2R4 =[movement_x_M{1};movement_x_M{2};movement_x_M{4}];
xmov_M_R1R2R3 =[movement_x_M{1};movement_x_M{2};movement_x_M{3}];

ymov_M_R2R3R4 =[movement_y_M{2};movement_y_M{3};movement_y_M{4}]; 
ymov_M_R1R3R4 =[movement_y_M{1};movement_y_M{3};movement_y_M{4}];
ymov_M_R1R2R4 =[movement_y_M{1};movement_y_M{2};movement_y_M{4}];
ymov_M_R1R2R3 =[movement_y_M{1};movement_y_M{2};movement_y_M{3}];

zmov_M_R2R3R4 =[movement_z_M{2};movement_z_M{3};movement_z_M{4}]; 
zmov_M_R1R3R4 =[movement_z_M{1};movement_z_M{3};movement_z_M{4}];
zmov_M_R1R2R4 =[movement_z_M{1};movement_z_M{2};movement_z_M{4}];
zmov_M_R1R2R3 =[movement_z_M{1};movement_z_M{2};movement_z_M{3}];

tmov_M_R2R3R4 =[movement_total_M{2};movement_total_M{3};movement_total_M{4}]; 
tmov_M_R1R3R4 =[movement_total_M{1};movement_total_M{3};movement_total_M{4}];
tmov_M_R1R2R4 =[movement_total_M{1};movement_total_M{2};movement_total_M{4}];
tmov_M_R1R2R3 =[movement_total_M{1};movement_total_M{2};movement_total_M{3}];

% data of Shirt S that will be used for the CI
indexes_S_R2R3R4 =[indexes_S{2};indexes_S{3};indexes_S{4}]; % indexes_S_R2R3R4 -> R2:register2, R3:register3, R4:register of Shirt S
indexes_S_R1R3R4 =[indexes_S{1};indexes_S{3};indexes_S{4}];
indexes_S_R1R2R4 =[indexes_S{1};indexes_S{2};indexes_S{4}];
indexes_S_R1R2R3 =[indexes_S{1};indexes_S{2};indexes_S{3}];

xmov_S_R2R3R4 =[movement_x_S{2};movement_x_S{3};movement_x_S{4}]; 
xmov_S_R1R3R4 =[movement_x_S{1};movement_x_S{3};movement_x_S{4}];
xmov_S_R1R2R4 =[movement_x_S{1};movement_x_S{2};movement_x_S{4}];
xmov_S_R1R2R3 =[movement_x_S{1};movement_x_S{2};movement_x_S{3}];

ymov_S_R2R3R4 =[movement_y_S{2};movement_y_S{3};movement_y_S{4}]; 
ymov_S_R1R3R4 =[movement_y_S{1};movement_y_S{3};movement_y_S{4}];
ymov_S_R1R2R4 =[movement_y_S{1};movement_y_S{2};movement_y_S{4}];
ymov_S_R1R2R3 =[movement_y_S{1};movement_y_S{2};movement_y_S{3}];

zmov_S_R2R3R4 =[movement_z_S{2};movement_z_S{3};movement_z_S{4}]; 
zmov_S_R1R3R4 =[movement_z_S{1};movement_z_S{3};movement_z_S{4}];
zmov_S_R1R2R4 =[movement_z_S{1};movement_z_S{2};movement_z_S{4}];
zmov_S_R1R2R3 =[movement_z_S{1};movement_z_S{2};movement_z_S{3}];

tmov_S_R2R3R4 =[movement_total_S{2};movement_total_S{3};movement_total_S{4}]; 
tmov_S_R1R3R4 =[movement_total_S{1};movement_total_S{3};movement_total_S{4}];
tmov_S_R1R2R4 =[movement_total_S{1};movement_total_S{2};movement_total_S{4}];
tmov_S_R1R2R3 =[movement_total_S{1};movement_total_S{2};movement_total_S{3}];

% Number of iteracions in bootstrap
numBootstraps = 1000;

% Significance level for confidence interval
ALPHA = 0.01;

% confidence interval 
% within recordings of shirt L
% R1 vs {R2, R3, R4}
CI_indexes_mean_L_R1vsR2R3R4 = statDifferenceCI(indexes_L{1}, indexes_L_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_L_R1vsR2R3R4 = statDifferenceCI(indexes_L{1}, indexes_L_R2R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_L_R1vsR2R3R4 = statDifferenceCI(movement_x_L{1}, xmov_L_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_L_R1vsR2R3R4 = statDifferenceCI(movement_x_L{1}, xmov_L_R2R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_L_R1vsR2R3R4 = statDifferenceCI(movement_y_L{1}, ymov_L_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_L_R1vsR2R3R4 = statDifferenceCI(movement_y_L{1}, ymov_L_R2R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_L_R1vsR2R3R4 = statDifferenceCI(movement_z_L{1}, zmov_L_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_L_R1vsR2R3R4 = statDifferenceCI(movement_z_L{1}, zmov_L_R2R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_L_R1vsR2R3R4 = statDifferenceCI(movement_total_L{1}, tmov_L_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_L_R1vsR2R3R4 = statDifferenceCI(movement_total_L{1}, tmov_L_R2R3R4, numBootstraps, ALPHA, 'median');

% R2 vs {R1, R3, R4}
CI_indexes_mean_L_R2vsR1R3R4 = statDifferenceCI(indexes_L{2}, indexes_L_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_L_R2vsR1R3R4 = statDifferenceCI(indexes_L{2}, indexes_L_R1R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_L_R2vsR1R3R4 = statDifferenceCI(movement_x_L{2}, xmov_L_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_L_R2vsR1R3R4 = statDifferenceCI(movement_x_L{2}, xmov_L_R1R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_L_R2vsR1R3R4 = statDifferenceCI(movement_y_L{2}, ymov_L_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_L_R2vsR1R3R4 = statDifferenceCI(movement_y_L{2}, ymov_L_R1R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_L_R2vsR1R3R4 = statDifferenceCI(movement_z_L{2}, zmov_L_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_L_R2vsR1R3R4 = statDifferenceCI(movement_z_L{2}, zmov_L_R1R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_L_R2vsR1R3R4 = statDifferenceCI(movement_total_L{2}, tmov_L_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_L_R2vsR1R3R4 = statDifferenceCI(movement_total_L{2}, tmov_L_R1R3R4, numBootstraps, ALPHA, 'median');

% R3 vs {R1, R2, R4}
CI_indexes_mean_L_R3vsR1R2R4 = statDifferenceCI(indexes_L{3}, indexes_L_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_L_R3vsR1R2R4 = statDifferenceCI(indexes_L{3}, indexes_L_R1R2R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_L_R3vsR1R2R4 = statDifferenceCI(movement_x_L{3}, xmov_L_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_L_R3vsR1R2R4 = statDifferenceCI(movement_x_L{3}, xmov_L_R1R2R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_L_R3vsR1R2R4 = statDifferenceCI(movement_y_L{3}, ymov_L_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_L_R3vsR1R2R4 = statDifferenceCI(movement_y_L{3}, ymov_L_R1R2R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_L_R3vsR1R2R4 = statDifferenceCI(movement_z_L{3}, zmov_L_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_L_R3vsR1R2R4 = statDifferenceCI(movement_z_L{3}, zmov_L_R1R2R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_L_R3vsR1R2R4 = statDifferenceCI(movement_total_L{3}, tmov_L_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_L_R3vsR1R2R4 = statDifferenceCI(movement_total_L{3}, tmov_L_R1R2R4, numBootstraps, ALPHA, 'median');

% R4 vs {R1, R2, R3}
CI_indexes_mean_L_R4vsR1R2R3 = statDifferenceCI(indexes_L{4}, indexes_L_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_indexes_median_L_R4vsR1R2R3 = statDifferenceCI(indexes_L{4}, indexes_L_R1R2R3, numBootstraps, ALPHA, 'median');

CI_xmov_mean_L_R4vsR1R2R3 = statDifferenceCI(movement_x_L{4}, xmov_L_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_xmov_median_L_R4vsR1R2R3 = statDifferenceCI(movement_x_L{4}, xmov_L_R1R2R3, numBootstraps, ALPHA, 'median');

CI_ymov_mean_L_R4vsR1R2R3 = statDifferenceCI(movement_y_L{4}, ymov_L_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_ymov_median_L_R4vsR1R2R3 = statDifferenceCI(movement_y_L{4}, ymov_L_R1R2R3, numBootstraps, ALPHA, 'median');

CI_zmov_mean_L_R4vsR1R2R3 = statDifferenceCI(movement_z_L{4}, zmov_L_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_zmov_median_L_R4vsR1R2R3 = statDifferenceCI(movement_z_L{4}, zmov_L_R1R2R3, numBootstraps, ALPHA, 'median');

CI_tmov_mean_L_R4vsR1R2R3 = statDifferenceCI(movement_total_L{4}, tmov_L_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_tmov_median_L_R4vsR1R2R3 = statDifferenceCI(movement_total_L{4}, tmov_L_R1R2R3, numBootstraps, ALPHA, 'median');

% within recordings of shirt M
% R1 vs {R2, R3, R4}
CI_indexes_mean_M_R1vsR2R3R4 = statDifferenceCI(indexes_M{1}, indexes_M_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_M_R1vsR2R3R4 = statDifferenceCI(indexes_M{1}, indexes_M_R2R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_M_R1vsR2R3R4 = statDifferenceCI(movement_x_M{1}, xmov_M_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_M_R1vsR2R3R4 = statDifferenceCI(movement_x_M{1}, xmov_M_R2R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_M_R1vsR2R3R4 = statDifferenceCI(movement_y_M{1}, ymov_M_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_M_R1vsR2R3R4 = statDifferenceCI(movement_y_M{1}, ymov_M_R2R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_M_R1vsR2R3R4 = statDifferenceCI(movement_z_M{1}, zmov_M_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_M_R1vsR2R3R4 = statDifferenceCI(movement_z_M{1}, zmov_M_R2R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_M_R1vsR2R3R4 = statDifferenceCI(movement_total_M{1}, tmov_M_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_M_R1vsR2R3R4 = statDifferenceCI(movement_total_M{1}, tmov_M_R2R3R4, numBootstraps, ALPHA, 'median');

% R2 vs {R1, R3, R4}
CI_indexes_mean_M_R2vsR1R3R4 = statDifferenceCI(indexes_M{2}, indexes_M_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_M_R2vsR1R3R4 = statDifferenceCI(indexes_M{2}, indexes_M_R1R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_M_R2vsR1R3R4 = statDifferenceCI(movement_x_M{2}, xmov_M_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_M_R2vsR1R3R4 = statDifferenceCI(movement_x_M{2}, xmov_M_R1R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_M_R2vsR1R3R4 = statDifferenceCI(movement_y_M{2}, ymov_M_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_M_R2vsR1R3R4 = statDifferenceCI(movement_y_M{2}, ymov_M_R1R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_M_R2vsR1R3R4 = statDifferenceCI(movement_z_M{2}, zmov_M_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_M_R2vsR1R3R4 = statDifferenceCI(movement_z_M{2}, zmov_M_R1R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_M_R2vsR1R3R4 = statDifferenceCI(movement_total_M{2}, tmov_M_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_M_R2vsR1R3R4 = statDifferenceCI(movement_total_M{2}, tmov_M_R1R3R4, numBootstraps, ALPHA, 'median');

% R3 vs {R1, R2, R4}
CI_indexes_mean_M_R3vsR1R2R4 = statDifferenceCI(indexes_M{3}, indexes_M_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_M_R3vsR1R2R4 = statDifferenceCI(indexes_M{3}, indexes_M_R1R2R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_M_R3vsR1R2R4 = statDifferenceCI(movement_x_M{3}, xmov_M_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_M_R3vsR1R2R4 = statDifferenceCI(movement_x_M{3}, xmov_M_R1R2R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_M_R3vsR1R2R4 = statDifferenceCI(movement_y_M{3}, ymov_M_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_M_R3vsR1R2R4 = statDifferenceCI(movement_y_M{3}, ymov_M_R1R2R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_M_R3vsR1R2R4 = statDifferenceCI(movement_z_M{3}, zmov_M_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_M_R3vsR1R2R4 = statDifferenceCI(movement_z_M{3}, zmov_M_R1R2R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_M_R3vsR1R2R4 = statDifferenceCI(movement_total_M{3}, tmov_M_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_M_R3vsR1R2R4 = statDifferenceCI(movement_total_M{3}, tmov_M_R1R2R4, numBootstraps, ALPHA, 'median');

% R4 vs {R1, R2, R3}
CI_indexes_mean_M_R4vsR1R2R3 = statDifferenceCI(indexes_M{4}, indexes_M_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_indexes_median_M_R4vsR1R2R3 = statDifferenceCI(indexes_M{4}, indexes_M_R1R2R3, numBootstraps, ALPHA, 'median');

CI_xmov_mean_M_R4vsR1R2R3 = statDifferenceCI(movement_x_M{4}, xmov_M_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_xmov_median_M_R4vsR1R2R3 = statDifferenceCI(movement_x_M{4}, xmov_M_R1R2R3, numBootstraps, ALPHA, 'median');

CI_ymov_mean_M_R4vsR1R2R3 = statDifferenceCI(movement_y_M{4}, ymov_M_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_ymov_median_M_R4vsR1R2R3 = statDifferenceCI(movement_y_M{4}, ymov_M_R1R2R3, numBootstraps, ALPHA, 'median');

CI_zmov_mean_M_R4vsR1R2R3 = statDifferenceCI(movement_z_M{4}, zmov_M_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_zmov_median_M_R4vsR1R2R3 = statDifferenceCI(movement_z_M{4}, zmov_M_R1R2R3, numBootstraps, ALPHA, 'median');

CI_tmov_mean_M_R4vsR1R2R3 = statDifferenceCI(movement_total_M{4}, tmov_M_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_tmov_median_M_R4vsR1R2R3 = statDifferenceCI(movement_total_M{4}, tmov_M_R1R2R3, numBootstraps, ALPHA, 'median');

% within recordings of shirt S
% R1 vs {R2, R3, R4}
CI_indexes_mean_S_R1vsR2R3R4 = statDifferenceCI(indexes_S{1}, indexes_S_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_S_R1vsR2R3R4 = statDifferenceCI(indexes_S{1}, indexes_S_R2R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_S_R1vsR2R3R4 = statDifferenceCI(movement_x_S{1}, xmov_S_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_S_R1vsR2R3R4 = statDifferenceCI(movement_x_S{1}, xmov_S_R2R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_S_R1vsR2R3R4 = statDifferenceCI(movement_y_S{1}, ymov_S_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_S_R1vsR2R3R4 = statDifferenceCI(movement_y_S{1}, ymov_S_R2R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_S_R1vsR2R3R4 = statDifferenceCI(movement_z_S{1}, zmov_S_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_S_R1vsR2R3R4 = statDifferenceCI(movement_z_S{1}, zmov_S_R2R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_S_R1vsR2R3R4 = statDifferenceCI(movement_total_S{1}, tmov_S_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_S_R1vsR2R3R4 = statDifferenceCI(movement_total_S{1}, tmov_S_R2R3R4, numBootstraps, ALPHA, 'median');

% R2 vs {R1, R3, R4}
CI_indexes_mean_S_R2vsR1R3R4 = statDifferenceCI(indexes_S{2}, indexes_S_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_S_R2vsR1R3R4 = statDifferenceCI(indexes_S{2}, indexes_S_R1R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_S_R2vsR1R3R4 = statDifferenceCI(movement_x_S{2}, xmov_S_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_S_R2vsR1R3R4 = statDifferenceCI(movement_x_S{2}, xmov_S_R1R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_S_R2vsR1R3R4 = statDifferenceCI(movement_y_S{2}, ymov_S_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_S_R2vsR1R3R4 = statDifferenceCI(movement_y_S{2}, ymov_S_R1R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_S_R2vsR1R3R4 = statDifferenceCI(movement_z_S{2}, zmov_S_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_S_R2vsR1R3R4 = statDifferenceCI(movement_z_S{2}, zmov_S_R1R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_S_R2vsR1R3R4 = statDifferenceCI(movement_total_S{2}, tmov_S_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_S_R2vsR1R3R4 = statDifferenceCI(movement_total_S{2}, tmov_S_R1R3R4, numBootstraps, ALPHA, 'median');

% R3 vs {R1, R2, R4}
CI_indexes_mean_S_R3vsR1R2R4 = statDifferenceCI(indexes_S{3}, indexes_S_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_S_R3vsR1R2R4 = statDifferenceCI(indexes_S{3}, indexes_S_R1R2R4, numBootstraps, ALPHA, 'median');

CI_xmov_mean_S_R3vsR1R2R4 = statDifferenceCI(movement_x_S{3}, xmov_S_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_xmov_median_S_R3vsR1R2R4 = statDifferenceCI(movement_x_S{3}, xmov_S_R1R2R4, numBootstraps, ALPHA, 'median');

CI_ymov_mean_S_R3vsR1R2R4 = statDifferenceCI(movement_y_S{3}, ymov_S_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_ymov_median_S_R3vsR1R2R4 = statDifferenceCI(movement_y_S{3}, ymov_S_R1R2R4, numBootstraps, ALPHA, 'median');

CI_zmov_mean_S_R3vsR1R2R4 = statDifferenceCI(movement_z_S{3}, zmov_S_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_zmov_median_S_R3vsR1R2R4 = statDifferenceCI(movement_z_S{3}, zmov_S_R1R2R4, numBootstraps, ALPHA, 'median');

CI_tmov_mean_S_R3vsR1R2R4 = statDifferenceCI(movement_total_S{3}, tmov_S_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_tmov_median_S_R3vsR1R2R4 = statDifferenceCI(movement_total_S{3}, tmov_S_R1R2R4, numBootstraps, ALPHA, 'median');

% R4 vs {R1, R2, R3}
CI_indexes_mean_S_R4vsR1R2R3 = statDifferenceCI(indexes_S{4}, indexes_S_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_indexes_median_S_R4vsR1R2R3 = statDifferenceCI(indexes_S{4}, indexes_S_R1R2R3, numBootstraps, ALPHA, 'median');

CI_xmov_mean_S_R4vsR1R2R3 = statDifferenceCI(movement_x_S{4}, xmov_S_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_xmov_median_S_R4vsR1R2R3 = statDifferenceCI(movement_x_S{4}, xmov_S_R1R2R3, numBootstraps, ALPHA, 'median');

CI_ymov_mean_S_R4vsR1R2R3 = statDifferenceCI(movement_y_S{4}, ymov_S_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_ymov_median_S_R4vsR1R2R3 = statDifferenceCI(movement_y_S{4}, ymov_S_R1R2R3, numBootstraps, ALPHA, 'median');

CI_zmov_mean_S_R4vsR1R2R3 = statDifferenceCI(movement_z_S{4}, zmov_S_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_zmov_median_S_R4vsR1R2R3 = statDifferenceCI(movement_z_S{4}, zmov_S_R1R2R3, numBootstraps, ALPHA, 'median');

CI_tmov_mean_S_R4vsR1R2R3 = statDifferenceCI(movement_total_S{4}, tmov_S_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_tmov_median_S_R4vsR1R2R3 = statDifferenceCI(movement_total_S{4}, tmov_S_R1R2R3, numBootstraps, ALPHA, 'median');

% between each shirt
mean_indexes_L_vs_M = statDifferenceCI([indexes_L{1};indexes_L{2};indexes_L{3};indexes_L{4}], [indexes_M{1};indexes_M{2};indexes_M{3};indexes_M{4}], numBootstraps, ALPHA, 'mean');
median_indexes_L_vs_M = statDifferenceCI([indexes_L{1};indexes_L{2};indexes_L{3};indexes_L{4}], [indexes_M{1};indexes_M{2};indexes_M{3};indexes_M{4}], numBootstraps, ALPHA, 'median');

mean_indexes_L_vs_S = statDifferenceCI([indexes_L{1};indexes_L{2};indexes_L{3};indexes_L{4}], [indexes_S{1};indexes_S{2};indexes_S{3};indexes_S{4}], numBootstraps, ALPHA, 'mean');
median_indexes_L_vs_S = statDifferenceCI([indexes_L{1};indexes_L{2};indexes_L{3};indexes_L{4}], [indexes_S{1};indexes_S{2};indexes_S{3};indexes_S{4}], numBootstraps, ALPHA, 'median');

mean_indexes_M_vs_S = statDifferenceCI([indexes_M{1};indexes_M{2};indexes_M{3};indexes_M{4}], [indexes_S{1};indexes_S{2};indexes_S{3};indexes_S{4}], numBootstraps, ALPHA, 'mean');
median_indexes_M_vs_S = statDifferenceCI([indexes_M{1};indexes_M{2};indexes_M{3};indexes_M{4}], [indexes_S{1};indexes_S{2};indexes_S{3};indexes_S{4}], numBootstraps, ALPHA, 'median');


mean_xmov_L_vs_M = statDifferenceCI([movement_x_L{1};movement_x_L{2};movement_x_L{3};movement_x_L{4}], [movement_x_M{1};movement_x_M{2};movement_x_M{3};movement_x_M{4}], numBootstraps, ALPHA, 'mean');
median_xmov_L_vs_M = statDifferenceCI([movement_x_L{1};movement_x_L{2};movement_x_L{3};movement_x_L{4}], [movement_x_M{1};movement_x_M{2};movement_x_M{3};movement_x_M{4}], numBootstraps, ALPHA, 'median');

mean_xmov_L_vs_S = statDifferenceCI([movement_x_L{1};movement_x_L{2};movement_x_L{3};movement_x_L{4}], [movement_x_S{1};movement_x_S{2};movement_x_S{3};movement_x_S{4}], numBootstraps, ALPHA, 'mean');
median_xmov_L_vs_S = statDifferenceCI([movement_x_L{1};movement_x_L{2};movement_x_L{3};movement_x_L{4}], [movement_x_S{1};movement_x_S{2};movement_x_S{3};movement_x_S{4}], numBootstraps, ALPHA, 'median');

mean_xmov_M_vs_S = statDifferenceCI([movement_x_M{1};movement_x_M{2};movement_x_M{3};movement_x_M{4}], [movement_x_S{1};movement_x_S{2};movement_x_S{3};movement_x_S{4}], numBootstraps, ALPHA, 'mean');
median_xmov_M_vs_S = statDifferenceCI([movement_x_M{1};movement_x_M{2};movement_x_M{3};movement_x_M{4}], [movement_x_S{1};movement_x_S{2};movement_x_S{3};movement_x_S{4}], numBootstraps, ALPHA, 'median');


mean_ymov_L_vs_M = statDifferenceCI([movement_y_L{1};movement_y_L{2};movement_y_L{3};movement_y_L{4}], [movement_y_M{1};movement_y_M{2};movement_y_M{3};movement_y_M{4}], numBootstraps, ALPHA, 'mean');
median_ymov_L_vs_M = statDifferenceCI([movement_y_L{1};movement_y_L{2};movement_y_L{3};movement_y_L{4}], [movement_y_M{1};movement_y_M{2};movement_y_M{3};movement_y_M{4}], numBootstraps, ALPHA, 'median');

mean_ymov_L_vs_S = statDifferenceCI([movement_y_L{1};movement_y_L{2};movement_y_L{3};movement_y_L{4}], [movement_y_S{1};movement_y_S{2};movement_y_S{3};movement_y_S{4}], numBootstraps, ALPHA, 'mean');
median_ymov_L_vs_S = statDifferenceCI([movement_y_L{1};movement_y_L{2};movement_y_L{3};movement_y_L{4}], [movement_y_S{1};movement_y_S{2};movement_y_S{3};movement_y_S{4}], numBootstraps, ALPHA, 'median');

mean_ymov_M_vs_S = statDifferenceCI([movement_y_M{1};movement_y_M{2};movement_y_M{3};movement_y_M{4}], [movement_y_S{1};movement_y_S{2};movement_y_S{3};movement_y_S{4}], numBootstraps, ALPHA, 'mean');
median_ymov_M_vs_S = statDifferenceCI([movement_y_M{1};movement_y_M{2};movement_y_M{3};movement_y_M{4}], [movement_y_S{1};movement_y_S{2};movement_y_S{3};movement_y_S{4}], numBootstraps, ALPHA, 'median');


mean_zmov_L_vs_M = statDifferenceCI([movement_z_L{1};movement_z_L{2};movement_z_L{3};movement_z_L{4}], [movement_z_M{1};movement_z_M{2};movement_z_M{3};movement_z_M{4}], numBootstraps, ALPHA, 'mean');
median_zmov_L_vs_M = statDifferenceCI([movement_z_L{1};movement_z_L{2};movement_z_L{3};movement_z_L{4}], [movement_z_M{1};movement_z_M{2};movement_z_M{3};movement_z_M{4}], numBootstraps, ALPHA, 'median');

mean_zmov_L_vs_S = statDifferenceCI([movement_z_L{1};movement_z_L{2};movement_z_L{3};movement_z_L{4}], [movement_z_S{1};movement_z_S{2};movement_z_S{3};movement_z_S{4}], numBootstraps, ALPHA, 'mean');
median_zmov_L_vs_S = statDifferenceCI([movement_z_L{1};movement_z_L{2};movement_z_L{3};movement_z_L{4}], [movement_z_S{1};movement_z_S{2};movement_z_S{3};movement_z_S{4}], numBootstraps, ALPHA, 'median');

mean_zmov_M_vs_S = statDifferenceCI([movement_z_M{1};movement_z_M{2};movement_z_M{3};movement_z_M{4}], [movement_z_S{1};movement_z_S{2};movement_z_S{3};movement_z_S{4}], numBootstraps, ALPHA, 'mean');
median_zmov_M_vs_S = statDifferenceCI([movement_z_M{1};movement_z_M{2};movement_z_M{3};movement_z_M{4}], [movement_z_S{1};movement_z_S{2};movement_z_S{3};movement_z_S{4}], numBootstraps, ALPHA, 'median');


mean_tmov_L_vs_M = statDifferenceCI([movement_total_L{1};movement_total_L{2};movement_total_L{3};movement_total_L{4}], [movement_total_M{1};movement_total_M{2};movement_total_M{3};movement_total_M{4}], numBootstraps, ALPHA, 'mean');
median_tmov_L_vs_M = statDifferenceCI([movement_total_L{1};movement_total_L{2};movement_total_L{3};movement_total_L{4}], [movement_total_M{1};movement_total_M{2};movement_total_M{3};movement_total_M{4}], numBootstraps, ALPHA, 'median');

mean_tmov_L_vs_S = statDifferenceCI([movement_total_L{1};movement_total_L{2};movement_total_L{3};movement_total_L{4}], [movement_total_S{1};movement_total_S{2};movement_total_S{3};movement_total_S{4}], numBootstraps, ALPHA, 'mean');
median_tmov_L_vs_S = statDifferenceCI([movement_total_L{1};movement_total_L{2};movement_total_L{3};movement_total_L{4}], [movement_total_S{1};movement_total_S{2};movement_total_S{3};movement_total_S{4}], numBootstraps, ALPHA, 'median');

mean_tmov_M_vs_S = statDifferenceCI([movement_total_M{1};movement_total_M{2};movement_total_M{3};movement_total_M{4}], [movement_total_S{1};movement_total_S{2};movement_total_S{3};movement_total_S{4}], numBootstraps, ALPHA, 'mean');
median_tmov_M_vs_S = statDifferenceCI([movement_total_M{1};movement_total_M{2};movement_total_M{3};movement_total_M{4}], [movement_total_S{1};movement_total_S{2};movement_total_S{3};movement_total_S{4}], numBootstraps, ALPHA, 'median');

% mean of each recording 
mean_indexes_L = cellfun(@mean, indexes_L);
mean_indexes_M = cellfun(@mean, indexes_M);
mean_indexes_S = cellfun(@mean, indexes_S);

mean_movement_x_L = cellfun(@mean, movement_x_L);
mean_movement_x_M = cellfun(@mean, movement_x_M);
mean_movement_x_S = cellfun(@mean, movement_x_S);

mean_movement_y_L = cellfun(@mean, movement_y_L);
mean_movement_y_M = cellfun(@mean, movement_y_M);
mean_movement_y_S = cellfun(@mean, movement_y_S);

mean_movement_z_L = cellfun(@mean, movement_z_L);
mean_movement_z_M = cellfun(@mean, movement_z_M);
mean_movement_z_S = cellfun(@mean, movement_z_S);

mean_movement_total_L = cellfun(@mean, movement_total_L);
mean_movement_total_M = cellfun(@mean, movement_total_M);
mean_movement_total_S = cellfun(@mean, movement_total_S);

% standard deviation of each recording
std_indexes_L = cellfun(@std, indexes_L);
std_indexes_M = cellfun(@std, indexes_M);
std_indexes_S = cellfun(@std, indexes_S);

std_movement_x_L = cellfun(@std, movement_x_L);
std_movement_x_M = cellfun(@std, movement_x_M);
std_movement_x_S = cellfun(@std, movement_x_S);

std_movement_y_L = cellfun(@std, movement_y_L);
std_movement_y_M = cellfun(@std, movement_y_M);
std_movement_y_S = cellfun(@std, movement_y_S);

std_movement_z_L = cellfun(@std, movement_z_L);
std_movement_z_M = cellfun(@std, movement_z_M);
std_movement_z_S = cellfun(@std, movement_z_S);

std_movement_total_L = cellfun(@std, movement_total_L);
std_movement_total_M = cellfun(@std, movement_total_M);
std_movement_total_S = cellfun(@std, movement_total_S);



