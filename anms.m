function [y x rmax] = anms(cimg, max_pts)

%for each pixel, find the largest radius in which it would be considered a
%corner -- find the distance to the closest point with a greater score


%pre-create matrix of i,j indices of cimg
compare_matrix(:,1) = repmat((1:size(cimg,1))', [size(cimg,2) 1]);
compare_matrix(:,2) = kron((1:size(cimg,2))', ones(size(cimg,1),1));
compare_matrix(:,3) = zeros(numel(cimg), 1);

pass = find(cimg > .00005); %only look pixel scores beyond at arbitrary threshold
% if numel(pass) > 2000
%     pass = find(cimg > .005);
% end

for k = 1:numel(pass);
    
    subtracted = bsxfun(@minus, cimg(pass(k)), cimg); %subtract the score of pixel k with every other score
    [i, j] = find(subtracted < 0); %return the i,j indices of the greater pixels
    
    if numel(i) ~= 0 %if it's not the greatest pixel
        dist = max(abs((bsxfun(@minus, compare_matrix(pass(k),[1 2]), [i j]))')); %get the minimum distance of the next greater pixel
        compare_matrix(pass(k),3) = min(dist'); %insert distance in third element of compare_matrix every row
    else
        compare_matrix(pass(k),3) = Inf;
    end
end

sorted = sortrows(compare_matrix,-3);%sort descending

sorted = sorted(1:max_pts,:); %keep the max_pts

%keep only one of the last elements of sorted if there's a repeat
[mini index]= min(sorted(:,3));
new_sorted = sorted(sorted(:,3) ~= mini, :);
new_sorted = [new_sorted; sorted(index,:)];


rmax = new_sorted(end,3);
y = new_sorted(:,1);
x = new_sorted(:,2);

end