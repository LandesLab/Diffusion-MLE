function stuno=indpblink(data)
ncero=find(data(:,1)~=0);
gain=0;
for i=1:numel(ncero)-1
    gain=((data(ncero(i+1),1)-data(ncero(i),1))^2+(data(ncero(i+1),2)-data(ncero(i),2))^2)/(ncero(i+1)-ncero(i))+gain;
end
stuno=gain/(numel(ncero)-1);