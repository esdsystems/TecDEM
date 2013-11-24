function [m, Ks]= regress_plot(stream,no)

ind = find(stream.bit == no);

ind2 = isinf(stream.logarea(ind));

ind3 = isinf(stream.logslope(ind));

info = evalin('base','info');
% stream.logarea(ind)
% stream.logslope(ind)
% 
ind(ind2) = [];
ind(ind3) = [];


s = size (stream.len(ind));

t = s (:,1);

m = [ones(t,1) stream.logarea(ind)]\stream.logslope(ind);

% Ks = power (10, m(1));
% sum(isinf(stream.logarea(ind) ))
% sum(isinf(stream.logslope(ind) ))

[Ks]=reg_qau(stream.logarea(ind),stream.logslope(ind),info.dtheta);