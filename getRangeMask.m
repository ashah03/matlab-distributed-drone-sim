% Create a mask of 1s for objects inside agent's range, 0s outside
function mask = getRangeMask(pos,radius,objects,mapSize)
    sz=size(objects);
    mask = zeros(sz);
    for row = max([1,pos{1}-ceil(radius)]):min([mapSize(1),pos{1}+ceil(radius)])
        for col=max([1,pos{2}-ceil(radius)]):min([mapSize(2),pos{2}+ceil(radius)])
            if objects{row,col}(1) == 0 && distance(pos,{row,col})<=radius
                mask(row,col)=1;
            end
        end 
    end
end