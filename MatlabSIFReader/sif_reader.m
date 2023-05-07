% function data = sif_reader(path,data_size)
clear
clc
%%
addpath('./atsifio');
data_size = 1024;
% path = 'ps_pad_0.5s_144-147_zach.sif';
path = 'D:\109slim\ramanFile\2021114/';
% %%
% subdir = dir(strcat(path,'*.sif'));
% data_num = length(subdir);
% data = zeros(data_size,1);
% for i = 1:length(subdir)
%     data_path = fullfile(path,subdir(i).name);
%     data = data+ReadAndorSIF(data_path);
% end
% data = data/data_num;
% % end

%% 
name = 'ps_single_beads_5s.sif';
sif_path = [path, name];
sif_data = ReadAndorSIF(sif_path);
figure
plot(sif_data);