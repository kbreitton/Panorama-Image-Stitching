function [patch1, patch2] = test_match(I1,I2, y1, x1, y2, x2, m)

close all

I1 = padarray(I1, [20 20], 'replicate');
I2 = padarray(I2, [20 20], 'replicate');

m1 = find(m ~= -1);%elements of I1
m2 = m(m ~= -1); %elements of I2

for i = 1:5
   patch1{i} = I1(y1(m1(i)):y1(m1(i))+39, x1(m1(i)):x1(m1(i))+39); 
   patch2{i} = I2(y2(m2(i)):y2(m2(i))+39, x2(m2(i)):x2(m2(i))+39); 
   
   figure(i)
   subplot(1,2,1), imshow(patch1{i}), subplot(1,2,2), imshow(patch2{i})
end

end