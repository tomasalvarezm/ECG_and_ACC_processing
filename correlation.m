function correlations = correlation(indexes, movement)

    correlations = cell(1, length(indexes));
    for i = 1:length(indexes)
        correlations{i} = round(corr(indexes{i}, movement{i}), 3);
    end

end