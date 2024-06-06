% This function combines data from two files recorded by Bitalino/Plux devices,
% extracts all data without the header from the second file and appends it
% at the end of the first file.

function combinePluxDataWithHeader(fileName1, fileName2)

    % Read data from second file
    data2 = importdata(fileName2);
    data2 = data2.data;
    
    % Write data at the end of the first file
    writematrix(data2, fileName1, 'FileType', 'text', 'Delimiter', '\t', 'WriteMode', 'append');
    
end
