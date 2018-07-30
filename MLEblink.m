function output=MLEblink(data,dT,varargin)
%% this one uses Berglund's information theory method to deal with blinking
%  data. I have verified that in case of no noise, it is the same as use
%  all the independent information. I want to try it in case of noise,
%  because this method is the only one I can find that be able of dealing
%  with noise and blinking data. Let's see its performance.

%% 
R=0;

D_i = indpblink(data)/4/dT;
sigma2_i = D_i;%abs(core(data));

if isempty(varargin)
    options = optimset('MaxFunEvals',100000,'MaxIter',100000);
    [b,~,errflag] = fminsearch(@(b)-Likelihood_subfunction(...
        data,b(1),b(2),dT,R ), [D_i sigma2_i],options);

    EstVals(1) = b(1);
    EstVals(2) = b(2);
    EstVals(3) = Likelihood_subfunction(data,EstVals(1),EstVals(2),dT,R);
else
    options = optimset('MaxFunEvals',100000,'MaxIter',100000);
    [b,~,errflag] = fminsearch(@(b)-Likelihood_subfunction(...
        data,b,varargin{1},dT,R ), [D_i],options);
    EstVals(1) = b;
    EstVals(2) = varargin{1};
    EstVals(3) = Likelihood_subfunction(data,EstVals(1),EstVals(2),dT,R);
end
output = EstVals;
end


function L = Likelihood_subfunction1D( dXX , D, sig2, dT, R )
% dXX is square dst of diff of trajectory with mean subtracted and
% k_th element multiplied by (-1)^k 

    if D<0 || sig2 < 0;
        L = -Inf;
    else
        ncero = find(dXX~=0);
        Sigma = zeros(numel(ncero)-1);
        for i = 1:numel(ncero)-1
            inc=ncero(i+1)-ncero(i);
            delta(i)=(dXX(ncero(i+1),1)-dXX(ncero(i),1));
            Sigma(i,i)=(2*D*dT*inc+2*sig2);
            if i+1<numel(ncero)
                Sigma(i,i+1)=-sig2;
                Sigma(i+1,i)=-sig2;
            end
        end
        
        L=-0.5*log(det(Sigma))-0.5*delta/(Sigma)*delta';
    end
end

function L = Likelihood_subfunction( dXX , varargin )
    L = 0;
    for kk=1:size(dXX,2);
        L = L+Likelihood_subfunction1D(dXX(:,kk),varargin{:});
    end
end