function handle = stdv_plot(xaxis,X,mean_color,lw)
% plot 
if nargin<4
    lw = 1;
end
    
[~,L] = size(X);
stds = std(X);

order = 1:L;
[~,revidx] = sort(order,'descend');

Xm = mean(X);

revXm = Xm(revidx);
revstds = stds(revidx);
revxaxis = xaxis(revidx);

polyys = [Xm+stds,revXm-revstds];
polyxs = [xaxis,revxaxis];


handle(1) = fill(polyxs,polyys,mean_color,'EdgeColor','none');
if ~ishold
    hold on
end
handle(2) = plot(xaxis,Xm,'Color',mean_color,'LineWidth',lw);
xlim([xaxis(1) xaxis(end)])