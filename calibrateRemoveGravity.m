% This function filters the gravity effect of the accelerometer through a high-pass filter and returns
% the linear acceleration which corresponds to the acceleration of the
% body.
% It first calibrate the raw data values and then removes the gravity
% effect by asolating the gravity with a low-pass filter and substracting
% it from the calibrated value.


function filteredData = calibrateRemoveGravity(data, Cmin, Cmax)

    % Calibration of the data --> converts raw values into g-force
    acc_g = (data - Cmin) / (Cmax - Cmin) * 2 - 1;

    % Initializing values
    alpha = 0.8; 
    gravity = 0;
    linear_acceleration = zeros(1, length(acc_g));

    % Filtering gravity - high pass filter
    for sample = 1:length(acc_g)
        % Low-pass filter
        gravity = alpha * gravity + (1 - alpha) * acc_g(sample); 

        % Removing gravity component
        linear_acceleration(sample) = acc_g(sample) - gravity;
    end

    filteredData = linear_acceleration;

end