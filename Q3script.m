clear all
close all

SelectedSizes = [3 11 14];

Q3function('non_real_time_no_load', SelectedSizes);
Q3function('non_real_time_with_load', SelectedSizes);
Q3function('real_time_no_load', SelectedSizes);
Q3function('real_time_with_load', SelectedSizes);