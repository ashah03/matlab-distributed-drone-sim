% Function used to generate maps 20, 30, and 50
% Arguments: size of the map, number of circles to plot
% Variables to experiment with: maxRadius calculation, initial val calculation, val decrement
function map = genMap(size, numCircles)
    map = zeros(size);
    centers = randi([1 size],numCircles,2);
    for i = 1:length(centers)
        center = num2cell(centers(i, :));
        maxRadius = randi([floor(size/10) ceil(size/3)]);
        val = maxRadius/5+rand(1)*maxRadius*5;
        for r=1:maxRadius
            for row = max([1,center{1}-ceil(r)]):min([size,center{1}+ceil(r)])
                for col = max([1,center{2}-ceil(r)]):min([size,center{2}+ceil(r)])
                    if distance(center,{row,col})<=r
                        map(row,col) = map(row,col) + val;
                    end
                end 
            end
            val = val - 1;
        end
    end
end