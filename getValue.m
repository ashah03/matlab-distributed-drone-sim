 %Return utility value of an agent being at pos
function value = getValue(pos, map, objects, radius)
    mask = getRangeMask(pos,radius,objects,size(map));
    values = map.*mask; %Cancels all values not in range
    value=sum(sum(values)); %Find sum of rows and columns (total sum of array)
end