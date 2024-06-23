function [storage, index] = store(storage, index, msg)
%store the GNSS message in a proper structure
    switch msg.type
        case "$GPGGA"
            fn = fieldnames(storage.gga);
            for k=1:numel(fn)
                storage.gga.(fn{k})(index.gga, :) = msg.(fn{k});
            end
            index.gga = index.gga + 1;
        case "$GPGLL"
            fn = fieldnames(storage.gll);
            for k=1:numel(fn)
                storage.gll.(fn{k})(index.gll, :) = msg.(fn{k});
            end
            index.gll = index.gll + 1;
        case "$GPGSA"
            fn = fieldnames(storage.gsa);
            for k=1:numel(fn)
                storage.gsa.(fn{k})(index.gsa, :) = msg.(fn{k});
            end
            index.gsa = index.gsa + 1;
        case "$GPGSV"
            fn = fieldnames(storage.gsv);
            for k=1:numel(fn)
                if size(storage.gsv.(fn{k})(index.gsv, :)) == size(msg.(fn{k}))
                    storage.gsv.(fn{k})(index.gsv, :) = msg.(fn{k});
                end
            end
            index.gsv = index.gsv + 1;
        case "$GPRMC"
            fn = fieldnames(storage.rmc);
            for k=1:numel(fn)
                storage.rmc.(fn{k})(index.rmc, :) = msg.(fn{k});
            end
            index.rmc = index.rmc + 1;
        case "$GPVTG"
            fn = fieldnames(storage.vtg);
            for k=1:numel(fn)
                storage.vtg.(fn{k})(index.vtg, :) = msg.(fn{k});
            end
            index.vtg = index.vtg + 1;
        case "$GPZDA"
            fn = fieldnames(storage.zda);
            for k=1:numel(fn)
                storage.zda.(fn{k})(index.zda, :) = msg.(fn{k});
            end
            index.zda = index.zda + 1;
    end

end