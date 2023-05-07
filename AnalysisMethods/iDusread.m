function [Z,mode] = iDusread(filename)
% This File is used to read data from an iDus ASCII output file (filename) 
% containing spectral Data.  It outputs a cell array, Z, containing a set 
% of matricies with wavelength and spectral data. Also included is a string 
% 'mode' denoting the mode (single, kinetic, or accumulate) that was used
% to gather the spectral data.  NOTE::: Make sure you append the aquisition
% information, option available when exporting data in Andor Shamrock 
% software, for correct operation of this function!

fprintf('Reading spectral file %s...\n',filename);

maximum = 200; % Sets the maximum number of frames for iDusread to search for

fid=fopen(filename, 'r'); % open iDus spectral data file

% A is the first line of the data file
A = fgetl(fid);
% converts A to collection of numbers
x = str2num(A);
% get # of columns = N
[M,N] = size(x);
% read rest of spectral data (i.e. 1023 * N) using fscanf
B = fscanf(fid,'%e',[N,1023]);
% stitch this to x forming new matrix Z
Z{1} = [x;B'];



ijk = 2; % Counter
while (ijk < maximum+1) % Check for more frames, up to 'maximum' frames
    fgetl(fid);
    A = fgetl(fid);
    % converts A to collection of numbers
    x = str2num(A);
    if (isempty(x) == 1) % End of spectral data reached
        ijk = maximum + 2;
    else % Read next frame of spectral data
        B = fscanf(fid,'%e',[N,1023]);
        Z{ijk} = [x;B'];
    end
    ijk = ijk+1; % Increase Counter
end

% Scan for footer text 'Mode:'
% Aquisition mode is found right after this
footer_text = fscanf(fid, '%s',1);
escapecounter = 0;

while ((strcmp(footer_text, 'Mode:') == 0) & (escapecounter < 1000))
   footer_text = fscanf(fid,'%s',1);
   escapecounter = escapecounter+1;
end

if (escapecounter==1000)
   disp('iDusread failed to determine the aquisition mode')
   mode = 'Not Found';
else
    % the next thing to read is the aquisition mode
    mode = fscanf(fid, '%s',1);
end

fclose(fid);