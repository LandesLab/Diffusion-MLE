function run_control(filelist,datadir,MLEshort,programdir);

if iscell(filelist)
    numfiles = numel(filelist);
else
    numfiles = 1;
end
D_all = [];
for n = 1 : numfiles
cd(datadir);
if numfiles == 1
    filename = filelist;
else
    filename = filelist{n};
end
trj=importdata([filename]);
if isstruct(trj)
    trj = trj.R;
end
trj = double(trj); % Make sure that the input data is a double instead of uint8 %

time=str2double(get(findobj(MLEshort.time),'String'));
cola=str2double(get(findobj(MLEshort.size),'String'));
MLE1 = get(findobj(MLEshort.MLE1),'Value');
MLE2 = get(findobj(MLEshort.MLE2),'Value');
auto = get(findobj(MLEshort.auto),'Value');

% D_all = [];

for i=1:size(trj,3)
    s(i)=find(trj(:,1,i)~=0,1,'first');
    e(i)=find(trj(:,1,i)~=0,1,'last');
    if e(i) - s(i) < 5 % shortest length of data
        D(i)=0;
    else
        D(i)=indpblink(trj(s(i):e(i),1:2,i)*cola)/4/time; % use only the first MSD 
    end
end
if MLE1~=1
    for i=1:size(trj,3)
        if e(i) - s(i) < 3
            out(1:3,i)=0;
        else
            out(:,i)=MLEblink(trj(s(i):e(i),1:2,i)*cola,time)'; % use MLE(2) 
        end
    end
    ind=find(D~=0);
    mean(out(:,ind),2);
    mean(D(ind));
    if mean(out(2,ind))>mean(D(ind))*0.2*time % check the reduced noise x
        D=out(1,:);
    elseif MLE2
        D=out(1,:);
    end
end
sum(isnan(D(:)))
set(gcf,'CurrentAxes',MLEshort.Dhist)
cla
ind=find(D~=0);
disp(['frame # = ' num2str(n) '; size of D_all is'])
size(D_all)
disp(['frame # = ' num2str(n) '; size of D(ind) is'])
size(D(ind))
D_all = [D_all D(ind)];
end
D_all=D_all';
hist(log10(D_all))
xlabel('Log(D/(nm.^2/s))'); ylabel('# of occurrence'); % (nm^2/s)
savename = [filename(1:(end-4)) '_diffcoe' filename((end-3):end)];
save(savename,'D_all')