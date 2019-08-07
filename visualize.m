%Visualizes locations of every drone overlayed on a heatmap of values 
function visualize(agents,map,radius,colors,I)
    %hold off
    %Visualization Code
    x = cell2mat(cellfun(@(v)v(2),agents));
    y = cell2mat(cellfun(@(v)v(1),agents));

    %N = length(x); X = linspace(0,pi*3,1000); 
    %c = linspace(N); 

     scatter(x,y,300,colors,'filled');
     for a = 1:size(agents)
         viscircles(cell2mat({agents{a}{2},agents{a}{1}}),radius,"Color",colors(a,:));
     end
    sz=size(map);
    hold on
    %I = (imread('heatmap.png'));
    I=I(70:778, 154:1005, :);
    %I=I(70:780, 153:996, :);
    %I=I(90:830, 153:996, :);
    I=imresize(I,[sz(1) sz(2)]);
    axis image
    imh = image(I);
    hold off
    uistack(imh, 'bottom');

    xlim([0.5 sz(2)+.5]);
    ylim([0.5 sz(1)+.5]);
end
