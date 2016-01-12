function [m] = feat_match(p1, p2)
%compute SSD between all pairs of descriptors between p1 and p2
%output is a pointer of match in p2 from p1

n1 = size(p1,2);
n2 = size(p2,2);

threshold = 0.65;

%find  two NN for each descriptor of p1
for i = 1:n1
    SSD(:,1) = sum(bsxfun(@minus, p1(:,i), p2) .^ 2)';
    SSD(:,2) = (1:n2)';
    sorted = sortrows(SSD, 1);
    if sorted(1,1) / sorted(2,1) < threshold %if ratio b/t 1-NN and 2-NN is large enough
        m(i) = sorted(1,2);
    else
        m(i) = -1;
    end
end
% 
% %repeat the columns of p1/p2 to get all n1 x n2 combinations possible
% rep_p2 = repmat(p2, [1 n1]);
% rep_p1 = kron(p1, [ones(1, n2)]);
% 
% SSD = sum((rep_p1 - rep_p2).^2);%output is a 1 x (n1 * n2) array, where the first n2 terms are the SSD between p1(:,1) and all columns of p2
% 
% 
% SSD_matrix = reshape(SSD, n2, n1); %reshape to an n2 x n1 matrix
% 
% sorted = sort(SSD_matrix); %sort along columns of SSD matrix, ascending
% 
% %create output m w/ pointer to matched descriptor in p2
% threshold = 0.65;
% pointer = repmat((1:n2)', [1 n1]); %matrix of element numbers for pointer purposes
% 
% for i = 1:n1
%     if sorted(1,i) / sorted(2,i) < threshold %if ratio b/t 1-NN and 2-NN is large enough
%         m(i) = pointer(sorted(:,i) == SSD_matrix(1,i));
%     else
%         m(i) = -1;
%     end
% end

m = m';
end