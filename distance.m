%Euclidean distance between two points
function d = distance(point1, point2)
   d=sqrt((point2{1}-point1{1})^2+(point2{2} - point1{2})^2);
end