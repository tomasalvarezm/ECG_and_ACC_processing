% This functions plots the correlation between each axis of
% movement and the total module vs the ecg

function plot_movement_vs_ecg(geometricMean_vector, accX_quantified, accY_quantified, accZ_quantified, totalMovement_quantified, file_name)

    title_text = strrep(file_name, '_', ' ');
    title_text = strrep(title_text, '.txt', '');

    % Create the figure with the specified title
    figure('Name', title_text, 'NumberTitle', 'off');
    sgtitle(title_text);  % Set the overall title of the figure

    % Plot x movement vs ecg indexes
    subplot(4, 1, 1);
    scatter(accX_quantified, geometricMean_vector, 'filled');
    hold on;
    p = polyfit(accX_quantified, geometricMean_vector, 1);
    yfit = polyval(p, accX_quantified);
    plot(accX_quantified, yfit, '-r');
    hold off;
    r = corrcoef(accX_quantified, geometricMean_vector);
    r_value = r(1, 2);
    title(sprintf('x movement vs ecg indexes    Correlation coefficient: %.2f', r_value));
    xlabel('x movements');
    ylabel('ecg indexes');

    % Plot y movement vs ecg indexes
    subplot(4, 1, 2);
    scatter(accY_quantified, geometricMean_vector, 'filled');
    hold on;
    p = polyfit(accY_quantified, geometricMean_vector, 1);
    yfit = polyval(p, accY_quantified);
    plot(accY_quantified, yfit, '-r');
    hold off;
    r = corrcoef(accY_quantified, geometricMean_vector);
    r_value = r(1, 2);
    title(sprintf('y movement vs ecg indexes    Correlation coefficient: %.2f', r_value));
    xlabel('y movements');
    ylabel('ecg indexes');

    % Plot z movement vs ecg indexes
    subplot(4, 1, 3);
    scatter(accZ_quantified, geometricMean_vector, 'filled');
    hold on;
    p = polyfit(accZ_quantified, geometricMean_vector, 1);
    yfit = polyval(p, accZ_quantified);
    plot(accZ_quantified, yfit, '-r');
    hold off;
    r = corrcoef(accZ_quantified, geometricMean_vector);
    r_value = r(1, 2);
    title(sprintf('z movement vs ecg indexes    Correlation coefficient: %.2f', r_value));
    xlabel('z movements');
    ylabel('ecg indexes');

    % Plot total movement vs ecg indexes
    subplot(4, 1, 4);
    scatter(totalMovement_quantified, geometricMean_vector, 'filled');
    hold on;
    p = polyfit(totalMovement_quantified, geometricMean_vector, 1);
    yfit = polyval(p, totalMovement_quantified);
    plot(totalMovement_quantified, yfit, '-r');
    hold off;
    r = corrcoef(totalMovement_quantified, geometricMean_vector);
    r_value = r(1, 2);
    title(sprintf('total movement vs ecg indexes    Correlation coefficient: %.2f', r_value));
    xlabel('total movements');
    ylabel('ecg indexes');
end
