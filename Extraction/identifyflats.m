function flats = identifyflats(dem)

% identify flat terrain in a digital elevation model
%
% Syntax
%
%     I = identifyflats(dem)
%
% Description
%
%     identifyflats returns a logical matrix that is true for cells
%     indicating flat terrain. flat terrain cells are defined as cells to
%     which no flow direction can be assigned to.
%
% Input
%
%     dem        digital elevation model
%    
% Output
% 
%     I          logical matrix (true cells indicate flat terrain)
%
% Example
%
%     dem = peaks(300);
%     dem = fillsinks(dem);
%     I = identifyflats(dem);
%     surf(dem,+I)
%     shading flat; camlight
%
% 
%
% 
% See also: ROUTEFLATS, CROSSFLATS
%
%
% Author: Wolfgang Schwanghart (w.schwanghart[at]unibas.ch)
% Date: 8. July, 2009



% handle NaNs
log_nans = isnan(dem);
if any(log_nans(:));
    flag_nans = true;
    dem(log_nans) = min(dem(:))-1;
else
    flag_nans = false;
end
nhood = ones(3);


% identify flats
% flats: logical matrix with true where cells don't have lower neighbors
if flag_nans
    flats = imerode(dem,nhood) == dem & ~log_nans;
%     flats = ordfilt2(dem, 9, nhood) == dem & ~log_nans;
else
    flats = imerode(dem,nhood) == dem;
end

% remove flats at the border
flats(1:end,[1 end])  = false;
flats([1 end],1:end)  = false;

