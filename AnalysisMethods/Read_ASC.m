function [Output] = Read_ASC(FilePath)
%this is a function to read ASC file
%Output: value matrix
%FilePath: file path
FilePath = 'C:\Users\Chuanzhen\Desktop\Matlab\Raman\20160907\qz_1.asc'
fid = fopen(FilePath);
raw = textscan(fid,'%f%c%f%c');
fclose(fid);
temp = [raw(1), raw(3)];
data = cell2mat(temp);
for ij = 1:size(data, 1)/1024
    Output(ij, :) = data((ij-1)*1024+1):(ij*1024), 2)';
end

Output = data;