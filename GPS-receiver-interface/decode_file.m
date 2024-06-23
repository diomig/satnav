function [storage, N, summary] = decode_file(filename)

    fileID = fopen(filename, 'r');
    [N, summary] = inspect(filename);
    j = 1;
    %storage is preallocated for speed optimization
    [storage, index] = storage_init(summary);
    wb = waitbar(0, 'Parsing Data'); %progressbar
    while ~feof(fileID)
        line = fgetl(fileID);
        if (isempty(line)||~checksum(line))
            j=j+1;continue; 
        end

        sentence = strsplit(""+line, ',','CollapseDelimiters', false);

        msg = parse(sentence);
        
        msg.num = j;
        [storage, index] = store(storage,index, msg);
        j = j+1;
        
        %periodically update progressbar
        if ismember(j, (0:1000:N))
            waitbar(j/N, wb, sprintf('Parsing Data - %2.0f %%', (j/N*100)+1));
        end
    end
    fclose(fileID);
    close(wb)

end