%% Compare mean and median difference

processed_files_M_mat1 = {'processedData_M_rec1_2024-05-27.txt', 'processedData_M_rec2_2024-06-01.txt', 'processedData_M_rec3_2024-06-05.txt', 'processedData_M_rec4_2024-06-10.txt'};
processed_files_M_mat2 = {'processedData_Mat2_rec1_2024-06-21.txt', 'processedData_Mat2_rec2_2024-06-22.txt', 'processedData_Mat2_rec3_2024-06-23.txt', 'processedData_Mat2_rec4_2024-06-24.txt'};

processed_fileSets = {processed_files_M_mat1, processed_files_M_mat2};

indexes = cell(1, length(processed_fileSets)); 
movement_x_chest = cell(1, length(processed_fileSets));
movement_y_chest = cell(1, length(processed_fileSets));
movement_z_chest = cell(1, length(processed_fileSets));
movement_total_chest = cell(1, length(processed_fileSets));

movement_x_arm = cell(1, length(processed_fileSets));
movement_y_arm = cell(1, length(processed_fileSets));
movement_z_arm = cell(1, length(processed_fileSets));
movement_total_arm = cell(1, length(processed_fileSets));

for setIndex = 1:length(indexes)
    currentFiles = processed_fileSets{setIndex}; 
    
    indexes{setIndex} = cell(1, length(currentFiles));
    movement_x_chest{setIndex} = cell(1, length(currentFiles));
    movement_y_chest{setIndex} = cell(1, length(currentFiles));
    movement_z_chest{setIndex} = cell(1, length(currentFiles));
    movement_total_chest{setIndex} = cell(1, length(currentFiles));
    
    movement_x_arm{setIndex} = cell(1, length(currentFiles));
    movement_y_arm{setIndex} = cell(1, length(currentFiles));
    movement_z_arm{setIndex} = cell(1, length(currentFiles));
    movement_total_arm{setIndex} = cell(1, length(currentFiles));

    for fileIndex = 1:length(currentFiles)
        data = importdata(currentFiles{fileIndex});
        
        numColumns = size(data.data, 2);
        
        if numColumns == 5
            indexes{setIndex}{fileIndex} = data.data(:, 1);
            movement_x_chest{setIndex}{fileIndex} = sqrt(data.data(:, 2))/10000;
            movement_y_chest{setIndex}{fileIndex} = sqrt(data.data(:, 3))/10000;
            movement_z_chest{setIndex}{fileIndex} = sqrt(data.data(:, 4))/10000;
            movement_total_chest{setIndex}{fileIndex} = sqrt(data.data(:, 5))/10000;

            plot_movement_vs_ecg(indexes{setIndex}{fileIndex}, movement_x_chest{setIndex}{fileIndex}, movement_y_chest{setIndex}{fileIndex}, ...
                movement_z_chest{setIndex}{fileIndex}, movement_total_chest{setIndex}{fileIndex}, currentFiles{fileIndex});
        
        elseif numColumns == 9
            indexes{setIndex}{fileIndex} = data.data(:, 1);
            movement_x_chest{setIndex}{fileIndex} = data.data(:, 4);
            movement_y_chest{setIndex}{fileIndex} = data.data(:, 3);
            movement_z_chest{setIndex}{fileIndex} = data.data(:, 2);
            movement_total_chest{setIndex}{fileIndex} = data.data(:, 5);
            
            movement_x_arm{setIndex}{fileIndex} = data.data(:, 8);
            movement_y_arm{setIndex}{fileIndex} = data.data(:, 7);
            movement_z_arm{setIndex}{fileIndex} = data.data(:, 6);
            movement_total_arm{setIndex}{fileIndex} = data.data(:, 9);
            
            % Plot chest movement vs ecg
            plot_movement_vs_ecg(indexes{setIndex}{fileIndex}, movement_x_chest{setIndex}{fileIndex}, movement_y_chest{setIndex}{fileIndex}, ...
                movement_z_chest{setIndex}{fileIndex}, movement_total_chest{setIndex}{fileIndex}, currentFiles{fileIndex});
            
            % Plot arm movement vs arm
            plot_movement_vs_ecg(indexes{setIndex}{fileIndex}, movement_x_arm{setIndex}{fileIndex}, movement_y_arm{setIndex}{fileIndex}, ...
                movement_z_arm{setIndex}{fileIndex}, movement_total_arm{setIndex}{fileIndex}, currentFiles{fileIndex});
        
        else
            warning('File %s has an unexpected number of columns (%d).', currentFiles{fileIndex}, numColumns);
        end
    end
end


% ECG quality indexes
indexes_mat1 = indexes{1};
indexes_mat2 = indexes{2};

% quantified movement
movement_x_chest_mat1 = movement_x_chest{1};
movement_y_chest_mat1 = movement_y_chest{1};
movement_z_chest_mat1 = movement_z_chest{1};
movement_total_chest_mat1 = movement_total_chest{1};

movement_x_chest_mat2 = movement_x_chest{2};
movement_y_chest_mat2 = movement_y_chest{2};
movement_z_chest_mat2 = movement_z_chest{2};
movement_total_chest_mat2 = movement_total_chest{2};

movement_x_arm_mat2 = movement_x_arm{2};
movement_y_arm_mat2 = movement_y_arm{2};
movement_z_arm_mat2 = movement_z_arm{2};
movement_total_arm_mat2 = movement_total_arm{2};

% Comparison...
% data for the Comparison Within Each Register

% data of material 1 that will be used for the CI
indexes_mat1_R2R3R4 =[indexes_mat1{2};indexes_mat1{3};indexes_mat1{4}]; % indexes_mat1_R2R3R4 -> R2:register2, R3:register3, R4:register of Shirt L
indexes_mat1_R1R3R4 =[indexes_mat1{1};indexes_mat1{3};indexes_mat1{4}];
indexes_mat1_R1R2R4 =[indexes_mat1{1};indexes_mat1{2};indexes_mat1{4}];
indexes_mat1_R1R2R3 =[indexes_mat1{1};indexes_mat1{2};indexes_mat1{3}];

xmov_chest_mat1_R2R3R4 =[movement_x_chest_mat1{2};movement_x_chest_mat1{3};movement_x_chest_mat1{4}]; 
xmov_chest_mat1_R1R3R4 =[movement_x_chest_mat1{1};movement_x_chest_mat1{3};movement_x_chest_mat1{4}];
xmov_chest_mat1_R1R2R4 =[movement_x_chest_mat1{1};movement_x_chest_mat1{2};movement_x_chest_mat1{4}];
xmov_chest_mat1_R1R2R3 =[movement_x_chest_mat1{1};movement_x_chest_mat1{2};movement_x_chest_mat1{3}];

ymov_chest_mat1_R2R3R4 =[movement_y_chest_mat1{2};movement_y_chest_mat1{3};movement_y_chest_mat1{4}]; 
ymov_chest_mat1_R1R3R4 =[movement_y_chest_mat1{1};movement_y_chest_mat1{3};movement_y_chest_mat1{4}];
ymov_chest_mat1_R1R2R4 =[movement_y_chest_mat1{1};movement_y_chest_mat1{2};movement_y_chest_mat1{4}];
ymov_chest_mat1_R1R2R3 =[movement_y_chest_mat1{1};movement_y_chest_mat1{2};movement_y_chest_mat1{3}];

zmov_chest_mat1_R2R3R4 =[movement_z_chest_mat1{2};movement_z_chest_mat1{3};movement_z_chest_mat1{4}]; 
zmov_chest_mat1_R1R3R4 =[movement_z_chest_mat1{1};movement_z_chest_mat1{3};movement_z_chest_mat1{4}];
zmov_chest_mat1_R1R2R4 =[movement_z_chest_mat1{1};movement_z_chest_mat1{2};movement_z_chest_mat1{4}];
zmov_chest_mat1_R1R2R3 =[movement_z_chest_mat1{1};movement_z_chest_mat1{2};movement_z_chest_mat1{3}];

tmov_chest_mat1_R2R3R4 =[movement_total_chest_mat1{2};movement_total_chest_mat1{3};movement_total_chest_mat1{4}]; 
tmov_chest_mat1_R1R3R4 =[movement_total_chest_mat1{1};movement_total_chest_mat1{3};movement_total_chest_mat1{4}];
tmov_chest_mat1_R1R2R4 =[movement_total_chest_mat1{1};movement_total_chest_mat1{2};movement_total_chest_mat1{4}];
tmov_chest_mat1_R1R2R3 =[movement_total_chest_mat1{1};movement_total_chest_mat1{2};movement_total_chest_mat1{3}];

% data of material 2 that will be used for the CI
indexes_mat2_R2R3R4 =[indexes_mat2{2};indexes_mat2{3};indexes_mat2{4}]; % indexes_mat2_R2R3R4 -> R2:register2, R3:register3, R4:register of Shirt M
indexes_mat2_R1R3R4 =[indexes_mat2{1};indexes_mat2{3};indexes_mat2{4}];
indexes_mat2_R1R2R4 =[indexes_mat2{1};indexes_mat2{2};indexes_mat2{4}];
indexes_mat2_R1R2R3 =[indexes_mat2{1};indexes_mat2{2};indexes_mat2{3}];

xmov_chest_mat2_R2R3R4 =[movement_x_chest_mat2{2};movement_x_chest_mat2{3};movement_x_chest_mat2{4}]; 
xmov_chest_mat2_R1R3R4 =[movement_x_chest_mat2{1};movement_x_chest_mat2{3};movement_x_chest_mat2{4}];
xmov_chest_mat2_R1R2R4 =[movement_x_chest_mat2{1};movement_x_chest_mat2{2};movement_x_chest_mat2{4}];
xmov_chest_mat2_R1R2R3 =[movement_x_chest_mat2{1};movement_x_chest_mat2{2};movement_x_chest_mat2{3}];

ymov_chest_mat2_R2R3R4 =[movement_y_chest_mat2{2};movement_y_chest_mat2{3};movement_y_chest_mat2{4}]; 
ymov_chest_mat2_R1R3R4 =[movement_y_chest_mat2{1};movement_y_chest_mat2{3};movement_y_chest_mat2{4}];
ymov_chest_mat2_R1R2R4 =[movement_y_chest_mat2{1};movement_y_chest_mat2{2};movement_y_chest_mat2{4}];
ymov_chest_mat2_R1R2R3 =[movement_y_chest_mat2{1};movement_y_chest_mat2{2};movement_y_chest_mat2{3}];

zmov_chest_mat2_R2R3R4 =[movement_z_chest_mat2{2};movement_z_chest_mat2{3};movement_z_chest_mat2{4}]; 
zmov_chest_mat2_R1R3R4 =[movement_z_chest_mat2{1};movement_z_chest_mat2{3};movement_z_chest_mat2{4}];
zmov_chest_mat2_R1R2R4 =[movement_z_chest_mat2{1};movement_z_chest_mat2{2};movement_z_chest_mat2{4}];
zmov_chest_mat2_R1R2R3 =[movement_z_chest_mat2{1};movement_z_chest_mat2{2};movement_z_chest_mat2{3}];

tmov_chest_mat2_R2R3R4 =[movement_total_chest_mat2{2};movement_total_chest_mat2{3};movement_total_chest_mat2{4}]; 
tmov_chest_mat2_R1R3R4 =[movement_total_chest_mat2{1};movement_total_chest_mat2{3};movement_total_chest_mat2{4}];
tmov_chest_mat2_R1R2R4 =[movement_total_chest_mat2{1};movement_total_chest_mat2{2};movement_total_chest_mat2{4}];
tmov_chest_mat2_R1R2R3 =[movement_total_chest_mat2{1};movement_total_chest_mat2{2};movement_total_chest_mat2{3}];

xmov_arm_mat2_R2R3R4 =[movement_x_arm_mat2{2};movement_x_arm_mat2{3};movement_x_arm_mat2{4}]; 
xmov_arm_mat2_R1R3R4 =[movement_x_arm_mat2{1};movement_x_arm_mat2{3};movement_x_arm_mat2{4}];
xmov_arm_mat2_R1R2R4 =[movement_x_arm_mat2{1};movement_x_arm_mat2{2};movement_x_arm_mat2{4}];
xmov_arm_mat2_R1R2R3 =[movement_x_arm_mat2{1};movement_x_arm_mat2{2};movement_x_arm_mat2{3}];

ymov_arm_mat2_R2R3R4 =[movement_y_arm_mat2{2};movement_y_arm_mat2{3};movement_y_arm_mat2{4}]; 
ymov_arm_mat2_R1R3R4 =[movement_y_arm_mat2{1};movement_y_arm_mat2{3};movement_y_arm_mat2{4}];
ymov_arm_mat2_R1R2R4 =[movement_y_arm_mat2{1};movement_y_arm_mat2{2};movement_y_arm_mat2{4}];
ymov_arm_mat2_R1R2R3 =[movement_y_arm_mat2{1};movement_y_arm_mat2{2};movement_y_arm_mat2{3}];

zmov_arm_mat2_R2R3R4 =[movement_z_arm_mat2{2};movement_z_arm_mat2{3};movement_z_arm_mat2{4}]; 
zmov_arm_mat2_R1R3R4 =[movement_z_arm_mat2{1};movement_z_arm_mat2{3};movement_z_arm_mat2{4}];
zmov_arm_mat2_R1R2R4 =[movement_z_arm_mat2{1};movement_z_arm_mat2{2};movement_z_arm_mat2{4}];
zmov_arm_mat2_R1R2R3 =[movement_z_arm_mat2{1};movement_z_arm_mat2{2};movement_z_arm_mat2{3}];

tmov_arm_mat2_R2R3R4 =[movement_total_arm_mat2{2};movement_total_arm_mat2{3};movement_total_arm_mat2{4}]; 
tmov_arm_mat2_R1R3R4 =[movement_total_arm_mat2{1};movement_total_arm_mat2{3};movement_total_arm_mat2{4}];
tmov_arm_mat2_R1R2R4 =[movement_total_arm_mat2{1};movement_total_arm_mat2{2};movement_total_arm_mat2{4}];
tmov_arm_mat2_R1R2R3 =[movement_total_arm_mat2{1};movement_total_arm_mat2{2};movement_total_arm_mat2{3}];

% Number of iteracions in bootstrap
numBootstraps = 1000;

% Significance level for confidence interval
ALPHA = 0.01;

% confidence interval 
% within recordings of material 1
% R1 vs {R2, R3, R4}
CI_indexes_mean_mat1_R1vsR2R3R4 = statDifferenceCI(indexes_mat1{1}, indexes_mat1_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat1_R1vsR2R3R4 = statDifferenceCI(indexes_mat1{1}, indexes_mat1_R2R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat1_R1vsR2R3R4 = statDifferenceCI(movement_x_chest_mat1{1}, xmov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat1_R1vsR2R3R4 = statDifferenceCI(movement_x_chest_mat1{1}, xmov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat1_R1vsR2R3R4 = statDifferenceCI(movement_y_chest_mat1{1}, ymov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat1_R1vsR2R3R4 = statDifferenceCI(movement_y_chest_mat1{1}, ymov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat1_R1vsR2R3R4 = statDifferenceCI(movement_z_chest_mat1{1}, zmov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat1_R1vsR2R3R4 = statDifferenceCI(movement_z_chest_mat1{1}, zmov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat1_R1vsR2R3R4 = statDifferenceCI(movement_total_chest_mat1{1}, tmov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat1_R1vsR2R3R4 = statDifferenceCI(movement_total_chest_mat1{1}, tmov_chest_mat1_R2R3R4, numBootstraps, ALPHA, 'median');

% R2 vs {R1, R3, R4}
CI_indexes_mean_mat1_R2vsR1R3R4 = statDifferenceCI(indexes_mat1{2}, indexes_mat1_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat1_L_R2vsR1R3R4 = statDifferenceCI(indexes_mat1{2}, indexes_mat1_R1R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat1_R2vsR1R3R4 = statDifferenceCI(movement_x_chest_mat1{2}, xmov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat1_R2vsR1R3R4 = statDifferenceCI(movement_x_chest_mat1{2}, xmov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat1_R2vsR1R3R4 = statDifferenceCI(movement_y_chest_mat1{2}, ymov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat1_R2vsR1R3R4 = statDifferenceCI(movement_y_chest_mat1{2}, ymov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat1_R2vsR1R3R4 = statDifferenceCI(movement_z_chest_mat1{2}, zmov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat1_R2vsR1R3R4 = statDifferenceCI(movement_z_chest_mat1{2}, zmov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat1_R2vsR1R3R4 = statDifferenceCI(movement_total_chest_mat1{2}, tmov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat1_R2vsR1R3R4 = statDifferenceCI(movement_total_chest_mat1{2}, tmov_chest_mat1_R1R3R4, numBootstraps, ALPHA, 'median');

% R3 vs {R1, R2, R4}
CI_indexes_mean_mat1_R3vsR1R2R4 = statDifferenceCI(indexes_mat1{3}, indexes_mat1_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat1_R3vsR1R2R4 = statDifferenceCI(indexes_mat1{3}, indexes_mat1_R1R2R4, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat1_R3vsR1R2R4 = statDifferenceCI(movement_x_chest_mat1{3}, xmov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat1_R3vsR1R2R4 = statDifferenceCI(movement_x_chest_mat1{3}, xmov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat1_R3vsR1R2R4 = statDifferenceCI(movement_y_chest_mat1{3}, ymov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat1_R3vsR1R2R4 = statDifferenceCI(movement_y_chest_mat1{3}, ymov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat1_R3vsR1R2R4 = statDifferenceCI(movement_z_chest_mat1{3}, zmov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat1_R3vsR1R2R4 = statDifferenceCI(movement_z_chest_mat1{3}, zmov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat1_R3vsR1R2R4 = statDifferenceCI(movement_total_chest_mat1{3}, tmov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat1_R3vsR1R2R4 = statDifferenceCI(movement_total_chest_mat1{3}, tmov_chest_mat1_R1R2R4, numBootstraps, ALPHA, 'median');

% R4 vs {R1, R2, R3}
CI_indexes_mean_mat1_R4vsR1R2R3 = statDifferenceCI(indexes_mat1{4}, indexes_mat1_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat1_R4vsR1R2R3 = statDifferenceCI(indexes_mat1{4}, indexes_mat1_R1R2R3, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat1_R4vsR1R2R3 = statDifferenceCI(movement_x_chest_mat1{4}, xmov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat1_R4vsR1R2R3 = statDifferenceCI(movement_x_chest_mat1{4}, xmov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat1_R4vsR1R2R3 = statDifferenceCI(movement_y_chest_mat1{4}, ymov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat1_R4vsR1R2R3 = statDifferenceCI(movement_y_chest_mat1{4}, ymov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat1_R4vsR1R2R3 = statDifferenceCI(movement_z_chest_mat1{4}, zmov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat1_R4vsR1R2R3 = statDifferenceCI(movement_z_chest_mat1{4}, zmov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat1_R4vsR1R2R3 = statDifferenceCI(movement_total_chest_mat1{4}, tmov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat1_R4vsR1R2R3 = statDifferenceCI(movement_total_chest_mat1{4}, tmov_chest_mat1_R1R2R3, numBootstraps, ALPHA, 'median');

% within recordings of material 2
% R1 vs {R2, R3, R4}
CI_indexes_mean_mat2_R1vsR2R3R4 = statDifferenceCI(indexes_mat2{1}, indexes_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat2_R1vsR2R3R4 = statDifferenceCI(indexes_mat2{1}, indexes_mat2_R2R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_x_chest_mat2{1}, xmov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_x_chest_mat2{1}, xmov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'median');
CI_xmov_arm_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_x_arm_mat2{1}, xmov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_arm_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_x_arm_mat2{1}, xmov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_y_chest_mat2{1}, ymov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_y_chest_mat2{1}, ymov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'median');
CI_ymov_arm_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_y_arm_mat2{1}, ymov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_arm_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_y_arm_mat2{1}, ymov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_z_chest_mat2{1}, zmov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_z_chest_mat2{1}, zmov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'median');
CI_zmov_arm_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_z_arm_mat2{1}, zmov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_arm_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_z_arm_mat2{1}, zmov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_total_chest_mat2{1}, tmov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_total_chest_mat2{1}, tmov_chest_mat2_R2R3R4, numBootstraps, ALPHA, 'median');
CI_tmov_arm_mean_mat2_R1vsR2R3R4 = statDifferenceCI(movement_total_arm_mat2{1}, tmov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_arm_median_mat2_R1vsR2R3R4 = statDifferenceCI(movement_total_arm_mat2{1}, tmov_arm_mat2_R2R3R4, numBootstraps, ALPHA, 'median');

% R2 vs {R1, R3, R4}
CI_indexes_mean_mat2_R2vsR1R3R4 = statDifferenceCI(indexes_mat2{2}, indexes_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat2_R2vsR1R3R4 = statDifferenceCI(indexes_mat2{2}, indexes_mat2_R1R3R4, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_x_chest_mat2{2}, xmov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_x_chest_mat2{2}, xmov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'median');
CI_xmov_arm_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_x_arm_mat2{2}, xmov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_xmov_arm_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_x_arm_mat2{2}, xmov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_y_chest_mat2{2}, ymov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_y_chest_mat2{2}, ymov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'median');
CI_ymov_arm_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_y_arm_mat2{2}, ymov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_ymov_arm_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_y_arm_mat2{2}, ymov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_z_chest_mat2{2}, zmov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_z_chest_mat2{2}, zmov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'median');
CI_zmov_arm_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_z_arm_mat2{2}, zmov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_zmov_arm_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_z_arm_mat2{2}, zmov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_total_chest_mat2{2}, tmov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_total_chest_mat2{2}, tmov_chest_mat2_R1R3R4, numBootstraps, ALPHA, 'median');
CI_tmov_arm_mean_mat2_R2vsR1R3R4 = statDifferenceCI(movement_total_arm_mat2{2}, tmov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'mean');
CI_tmov_arm_median_mat2_R2vsR1R3R4 = statDifferenceCI(movement_total_arm_mat2{2}, tmov_arm_mat2_R1R3R4, numBootstraps, ALPHA, 'median');

% R3 vs {R1, R2, R4}
CI_indexes_mean_mat2_R3vsR1R2R4 = statDifferenceCI(indexes_mat2{3}, indexes_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat2_R3vsR1R2R4 = statDifferenceCI(indexes_mat2{3}, indexes_mat2_R1R2R4, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_x_chest_mat2{3}, xmov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_x_chest_mat2{3}, xmov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'median');
CI_xmov_arm_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_x_arm_mat2{3}, xmov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_xmov_arm_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_x_arm_mat2{3}, xmov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_y_chest_mat2{3}, ymov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_y_chest_mat2{3}, ymov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'median');
CI_ymov_arm_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_y_arm_mat2{3}, ymov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_ymov_arm_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_y_arm_mat2{3}, ymov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_z_chest_mat2{3}, zmov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_z_chest_mat2{3}, zmov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'median');
CI_zmov_arm_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_z_arm_mat2{3}, zmov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_zmov_arm_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_z_arm_mat2{3}, zmov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_total_chest_mat2{3}, tmov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_total_chest_mat2{3}, tmov_chest_mat2_R1R2R4, numBootstraps, ALPHA, 'median');
CI_tmov_arm_mean_mat2_R3vsR1R2R4 = statDifferenceCI(movement_total_arm_mat2{3}, tmov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'mean');
CI_tmov_arm_median_mat2_R3vsR1R2R4 = statDifferenceCI(movement_total_arm_mat2{3}, tmov_arm_mat2_R1R2R4, numBootstraps, ALPHA, 'median');

% R4 vs {R1, R2, R3}
CI_indexes_mean_mat2_R4vsR1R2R3 = statDifferenceCI(indexes_mat2{4}, indexes_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_indexes_median_mat2_R4vsR1R2R3 = statDifferenceCI(indexes_mat2{4}, indexes_mat2_R1R2R3, numBootstraps, ALPHA, 'median');

CI_xmov_chest_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_x_chest_mat2{4}, xmov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_xmov_chest_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_x_chest_mat2{4}, xmov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'median');
CI_xmov_arm_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_x_arm_mat2{4}, xmov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_xmov_arm_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_x_arm_mat2{4}, xmov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'median');

CI_ymov_chest_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_y_chest_mat2{4}, ymov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_ymov_chest_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_y_chest_mat2{4}, ymov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'median');
CI_ymov_arm_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_y_arm_mat2{4}, ymov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_ymov_arm_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_y_arm_mat2{4}, ymov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'median');

CI_zmov_chest_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_z_chest_mat2{4}, zmov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_zmov_chest_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_z_chest_mat2{4}, zmov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'median');
CI_zmov_arm_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_z_arm_mat2{4}, zmov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_zmov_arm_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_z_arm_mat2{4}, zmov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'median');

CI_tmov_chest_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_total_chest_mat2{4}, tmov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_tmov_chest_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_total_chest_mat2{4}, tmov_chest_mat2_R1R2R3, numBootstraps, ALPHA, 'median');
CI_tmov_arm_mean_mat2_R4vsR1R2R3 = statDifferenceCI(movement_total_arm_mat2{4}, tmov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'mean');
CI_tmov_arm_median_mat2_R4vsR1R2R3 = statDifferenceCI(movement_total_arm_mat2{4}, tmov_arm_mat2_R1R2R3, numBootstraps, ALPHA, 'median');

% between each material
mean_indexes_mat1_vs_mat2 = statDifferenceCI([indexes_mat1{1};indexes_mat1{2};indexes_mat1{3};indexes_mat1{4}], [indexes_mat2{1};indexes_mat2{2};indexes_mat2{3};indexes_mat2{4}], numBootstraps, ALPHA, 'mean');
median_indexes_mat1_vs_mat2 = statDifferenceCI([indexes_mat1{1};indexes_mat1{2};indexes_mat1{3};indexes_mat1{4}], [indexes_mat2{1};indexes_mat2{2};indexes_mat2{3};indexes_mat2{4}], numBootstraps, ALPHA, 'median');

mean_xmov_chest_mat1_vs_mat2 = statDifferenceCI([movement_x_chest_mat1{1};movement_x_chest_mat1{2};movement_x_chest_mat1{3};movement_x_chest_mat1{4}], [movement_x_chest_mat2{1};movement_x_chest_mat2{2};movement_x_chest_mat2{3};movement_x_chest_mat2{4}], numBootstraps, ALPHA, 'mean');
median_xmov_chest_mat1_vs_mat2 = statDifferenceCI([movement_x_chest_mat1{1};movement_x_chest_mat1{2};movement_x_chest_mat1{3};movement_x_chest_mat1{4}], [movement_x_chest_mat2{1};movement_x_chest_mat2{2};movement_x_chest_mat2{3};movement_x_chest_mat2{4}], numBootstraps, ALPHA, 'median');

mean_ymov_chest_mat1_vs_mat2 = statDifferenceCI([movement_y_chest_mat1{1};movement_y_chest_mat1{2};movement_y_chest_mat1{3};movement_y_chest_mat1{4}], [movement_y_chest_mat2{1};movement_y_chest_mat2{2};movement_y_chest_mat2{3};movement_y_chest_mat2{4}], numBootstraps, ALPHA, 'mean');
median_ymov_chest_mat1_vs_mat2 = statDifferenceCI([movement_y_chest_mat1{1};movement_y_chest_mat1{2};movement_y_chest_mat1{3};movement_y_chest_mat1{4}], [movement_y_chest_mat2{1};movement_y_chest_mat2{2};movement_y_chest_mat2{3};movement_y_chest_mat2{4}], numBootstraps, ALPHA, 'median');

mean_zmov_chest_mat1_vs_mat2 = statDifferenceCI([movement_z_chest_mat1{1};movement_z_chest_mat1{2};movement_z_chest_mat1{3};movement_z_chest_mat1{4}], [movement_z_chest_mat2{1};movement_z_chest_mat2{2};movement_z_chest_mat2{3};movement_z_chest_mat2{4}], numBootstraps, ALPHA, 'mean');
median_zmov_chest_mat1_vs_mat2 = statDifferenceCI([movement_z_chest_mat1{1};movement_z_chest_mat1{2};movement_z_chest_mat1{3};movement_z_chest_mat1{4}], [movement_z_chest_mat2{1};movement_z_chest_mat2{2};movement_z_chest_mat2{3};movement_z_chest_mat2{4}], numBootstraps, ALPHA, 'median');

mean_tmov_chest_mat1_vs_mat2 = statDifferenceCI([movement_total_chest_mat1{1};movement_total_chest_mat1{2};movement_total_chest_mat1{3};movement_total_chest_mat1{4}], [movement_total_chest_mat2{1};movement_total_chest_mat2{2};movement_total_chest_mat2{3};movement_total_chest_mat2{4}], numBootstraps, ALPHA, 'mean');
median_tmov_chest_mat1_vs_mat2 = statDifferenceCI([movement_total_chest_mat1{1};movement_total_chest_mat1{2};movement_total_chest_mat1{3};movement_total_chest_mat1{4}], [movement_total_chest_mat2{1};movement_total_chest_mat2{2};movement_total_chest_mat2{3};movement_total_chest_mat2{4}], numBootstraps, ALPHA, 'median');

% mean of each recording 
mean_indexes_mat1 = cellfun(@mean, indexes_mat1);
mean_indexes_mat2 = cellfun(@mean, indexes_mat2);

mean_movement_x_chest_mat1 = cellfun(@mean, movement_x_chest_mat1);
mean_movement_x_chest_mat2 = cellfun(@mean, movement_x_chest_mat2);
mean_movement_x_arm_mat2 = cellfun(@mean, movement_x_arm_mat2);

mean_movement_y_chest_mat1 = cellfun(@mean, movement_y_chest_mat1);
mean_movement_y_chest_mat2 = cellfun(@mean, movement_y_chest_mat2);
mean_movement_y_arm_mat2 = cellfun(@mean, movement_y_arm_mat2);

mean_movement_z_chest_mat1 = cellfun(@mean, movement_z_chest_mat1);
mean_movement_z_chest_mat2 = cellfun(@mean, movement_z_chest_mat2);
mean_movement_z_arm_mat2 = cellfun(@mean, movement_z_arm_mat2);

mean_movement_total_chest_mat1 = cellfun(@mean, movement_total_chest_mat1);
mean_movement_total_chest_mat2 = cellfun(@mean, movement_total_chest_mat2);
mean_movement_total_arm_mat2 = cellfun(@mean, movement_total_arm_mat2);

% standard deviation of each recording
std_indexes_mat1 = cellfun(@std, indexes_mat1);
std_indexes_mat2 = cellfun(@std, indexes_mat2);

std_movement_x_chest_mat1 = cellfun(@std, movement_x_chest_mat1);
std_movement_x_chest_mat2 = cellfun(@std, movement_x_chest_mat2);
std_movement_x_arm_mat2 = cellfun(@std, movement_x_arm_mat2);

std_movement_y_chest_mat1 = cellfun(@std, movement_y_chest_mat1);
std_movement_y_chest_mat2 = cellfun(@std, movement_y_chest_mat2);
std_movement_y_arm_mat2 = cellfun(@std, movement_y_arm_mat2);

std_movement_z_chest_mat1 = cellfun(@std, movement_z_chest_mat1);
std_movement_z_chest_mat2 = cellfun(@std, movement_z_chest_mat2);
std_movement_z_arm_mat2 = cellfun(@std, movement_z_arm_mat2);

std_movement_total_chest_mat1 = cellfun(@std, movement_total_chest_mat1);
std_movement_total_chest_mat2 = cellfun(@std, movement_total_chest_mat2);
std_movement_total_arm_mat2 = cellfun(@std, movement_total_arm_mat2);



