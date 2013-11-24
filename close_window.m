function close_window(varargin)

ans1=questdlg('Your are about to exit from TecDEM.', ...
    'Saving Data', ...
    'Yes','No','Yes');


switch ans1,
    case 'Yes',
        closereq
        evalin('base','clear all');
        close all
    case 'No',
        return
end % switch
