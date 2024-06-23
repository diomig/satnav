function [N, summary] = inspect(filename)

%% Find out the Total Number of Messages, N
%global filename;
fileID = fopen(filename, 'r');
N = 0;
fails = [];
while ~feof(fileID)
    line = fgetl(fileID);
    N = N+1;
    if (isempty(line)), continue; end
    
    if ~checksum(line)
        fails = [fails, N];
    end
    
end
fclose(fileID);


if isempty(fails)
    fprintf(2, 'No checksum fails! \n')
else
    fprintf(2, 'Checksum fails on lines: \n')
    disp(fails)
end
%% Get the summary. How many messages each formatter has
fileID = fopen(filename, 'r');
accum = strings(1,N);
i = 1;
while ~feof(fileID)
    line = fgetl(fileID);
    if (isempty(line)), continue; end

    msg_type = strtok(line, ',');
                
    accum(i) = msg_type;
    i = i+1;
end
fclose(fileID);

[counts, groupnames] = groupcounts(accum');
summary = cell(1,2);
summary{1, 1} = groupnames;
summary{1,2} = counts;

end