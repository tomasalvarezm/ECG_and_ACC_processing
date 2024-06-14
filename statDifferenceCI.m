

function [confidenceInterval, bootDiffs] = statDifferenceCI(energy1, energy2, numBootstraps, ALPHA, statType)

    % Define the statistic function
    switch statType  
        case 'mean'
            statfun = @(x) mean(x);

        case 'median'
            statfun = @(x) median(x);

        otherwise
            error('Statistic type not supported');
    end

    % Bootstrapping using bootstrp
    bootstat1 = bootstrp(numBootstraps, statfun, energy1);
    bootstat2 = bootstrp(numBootstraps, statfun, energy2);

    % Differences for each bootstrap sample
    bootDiffs = bootstat1 - bootstat2;

     % Confidence interval from the bootstrapped differences
    lowerBound = prctile(bootDiffs, 100 * (ALPHA / 2));
    upperBound = prctile(bootDiffs, 100 * (1 - ALPHA / 2));
    confidenceInterval = [lowerBound, upperBound];

end