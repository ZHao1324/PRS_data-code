function [filtered] = cosmic_ray(unfiltered,medthresh,plotflag)
% function [filtered] = cosmic_ray(unfiltered,medthresh)
%
% a median filter based cosmic ray removal tool.  based on code
% originally written by ed hull during the bsl lab - inlight collaboration.
% function finds the median spectrum and compares each other spectrum pixel
% by pixel to the median spectrum.  if any pixel is a certain number of
% absolute median deviations away, it is replaced by the median value for
% that pixel.
%
% INPUTS:   unfiltered  =   the spectra you'd like to filter
%           medthresh   =   replacement criterion. (number of absolute
%                           median deviations a pixel value can be before 
%                           being replaced)
%           plotflag    =   do you want to see the threshold plots as they
%                           process? (use only two arguments or '0' if no)
%
% OUTPUTS:  filtered    =   filtered spectra

%                               -zjs 06/22/2005

if nargin<3
    flag = 0;
else
    if plotflag == 0
        flag = 0;
    else
        flag = 1;
    end
end


porder = 5;
% calculate the median of all frames in this acquisition
medspec = median(unfiltered); 
% center the polynomial-corrected data about its median
median_centered = unfiltered-repmat(medspec,size(unfiltered,1),1);	
% find the median of the absolute value of the centered data, fit to a
% polynomial
[FitCoeffs,jk,Mu] = polyfit(1:length(medspec),...
    median(abs(median_centered)),porder);	
% threshold is some number (medthresh) of median absolute deviations
threshold = medthresh*polyval(FitCoeffs,1:length(medspec),[],Mu);	



if flag
    h = gcf;
    figure(h+1)
    clf
    plot(median_centered')
    hold on
    plot(threshold);
    pause(3);
    close(h+1);
end

% replacement loop
filtered = unfiltered; 	
for i=1:size(unfiltered,1)
	outs{i} = find(abs(median_centered(i,:))>threshold);
	if ~isempty(outs{i})
		filtered(i,outs{i}) = medspec(outs{i});
	end
end
