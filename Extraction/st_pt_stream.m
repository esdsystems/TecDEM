function [rt ct] = st_pt_stream(to1)

pzero = evalin('base','pzero');
r = size(pzero);

[rt ct]=ind2sub(r,to1(pzero(to1) == 0));
