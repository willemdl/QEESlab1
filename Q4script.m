clear all
close all

set(0,'DefaultFigureWindowStyle','docked')


info3 = Q4function('connext');
info1 = Q4function('fastrtps');
info2 = Q4function('opensplice');

%% ANOVA
data2way = [info1.data(2:end,1), info2.data(2:end,1), info3.data(2:end,1);
        info1.data(2:end,10), info2.data(2:end,10), info3.data(2:end,10)];
[p2way,tb2way] = anova2(data2way,998);

%% Data analysis for table
mean256 = mean([info1.data(2:end,1), info2.data(2:end,1), info3.data(2:end,1)]);
mean128 = mean([info1.data(2:end,10), info2.data(2:end,10), info3.data(2:end,10)]);
meanall = [mean256; mean128];
meancol = mean(meanall,1);
meanrow = mean(meanall,2);
meantot = mean(meanall,'all');
effcol = meancol - meantot;
effrow = meanrow - meantot;