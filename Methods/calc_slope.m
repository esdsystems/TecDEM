function slope_degrees = calc_slope(z,x_cell_size,y_cell_size)

dzdx = ((z(7) + 2*z(8) + z(9)) - (z(1) + 2*z(2) + z(3))) / (8 * x_cell_size);
dzdy = ((z(3) + 2*z(6) + z(9)) - (z(1) + 2*z(4) + z(7))) / (8 * y_cell_size);

rise_run = sqrt(power(dzdx,2)+power(dzdy,2));

slope_degrees = round(atan (rise_run) * 57.29578);