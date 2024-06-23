function process_gsv(gsv)
gsv = nmea.gsv;

aux = diff(nmea.gsv.num)~=1;
aux = circshift(aux,1); aux(1)=1;
heads = find(aux);
head_nums = gsv.num(aux);
N = length(heads)-1;

total = max(gsv.total);

data = strings(N, 12*total);
for k = 1:N
    for n = 0:gsv.total-1
        data(k, (n*12+1):((n+1)*12)) = gsv.data((heads(k)+n),:);
    end
end

end