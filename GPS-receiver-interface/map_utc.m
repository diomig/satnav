function timevalues = map_utc(dest, donor)
% map utc timestamps based on a previous messages that has utc 

num_dest = dest.num;
num_donor = donor.num;

len = length(num_dest);
indexes = zeros(len, 1);
timevalues = zeros(len, 1);

for k=1:len
    aux = num_donor(num_dest(k)>num_donor);
    indexes(k) = aux(end);
    timevalues(k) = donor.utc(donor.num==aux(end));
end

end