function [p] = feat_desc(im, y, x)
%want an 8x8 patch describing each corner

filt = fspecial('gaussian'); %set gaussian filter

%pad the image with zeros in case the window goes out of bounds
im = padarray(im, [20 20]);

for i = 1:numel(y)
    patch = im(y(i):y(i)+39, x(i):x(i)+39); %get a 40x40 patch around the corner
    
    blur  = imfilter(patch, filt, 'same'); %blur the patch
    
    %sample every 5th pixel of the patch
    sampled = blur(1:5:end, :);
    sampled = sampled(:, 1:5:end);
    
    sampled = double(sampled);
    
    %normalize to mean 0 and std 1
    sampled = (sampled - mean(mean(sampled))) ./ std(std(sampled));
    
    p(:,i) = reshape(sampled, [numel(sampled) 1]);%store sample in [p]
end

end