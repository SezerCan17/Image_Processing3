% Clear workspace clear all 

close all 

 

% Load the original image myimg = imread('images.jpg'); 

figure; imshow(myimg); title('Initial Image'); 

 

% Convert the image to grayscale gray_img = rgb2gray(myimg); 

 

% Visualize the grayscale image and its histogram figure; 

subplot(2, 1, 1); imshow(gray_img); title('Gray Scale Image'); subplot(2, 1, 2); imhist(gray_img); title('Gray Scale Histogram'); 

 

% Define histogram equalization parameters slow = 10; % Slow threshold 

shigh = 10; % High threshold 

 

% Calculate the histogram of the grayscale image [counts, ~] = imhist(gray_img); 

totalPixels = sum(counts); 

 

% Find the alow value according to the slow threshold sumPixels = 0; 

alow = 0; 

for i = 1:numel(counts) 

sumPixels = sumPixels + counts(i); 

if sumPixels >= slow * totalPixels / 100 alow = i - 1; 

break; end end 

 

% Find the ahigh value according to the high threshold sumPixels = 0; 

ahigh = 0; 

for i = 1:numel(counts) 

sumPixels = sumPixels + counts(numel(counts) - i + 1); if sumPixels >= shigh * totalPixels / 100 

ahigh = numel(counts) - i; 
break; end end 

% Set the amin and amax values for the new image amin = 0; % Minimum pixel intensity 

amax = 255; % Maximum pixel intensity 

 

% Calculate the new pixel values new_pixel_vals = zeros(256, 1); for a = 1:256 

if a <= alow new_pixel_vals(a) = amin; elseif a >= ahigh new_pixel_vals(a) = amax; else 

new_pixel_vals(a) = amin + (a - alow) * ((amax - amin) / (ahigh - alow)); end 

End 

 

% Create the new image 

[rows, cols] = size(gray_img); new_img = zeros(rows, cols, 'uint8'); for i = 1:rows 

for j = 1:cols 

intensity = gray_img(i, j) + 1; % MATLAB indices start from 1 

new_img(i, j) = new_pixel_vals(intensity); % Create the new image using the new pixel values 

end End 

 

% Visualize the new image and its histogram figure; 

subplot(2, 1, 1); imshow(new_img); title(['New Image (slow = ' num2str(slow) ', shigh = ' num2str(shigh) ')']); 

subplot(2, 1, 2); imhist(new_img); title('New Histogram');