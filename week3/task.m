% Test tasks for the Week 2
clear all; close all; clc;

% Load the image:
img = imread('../lena512.pgm');

% Display the image:
disp('Figure 1: the original image')
figure(1);
imshow(img);

% Median filtering of noised images:
nimg = img_noise(img, 12);
disp('Figure 2: Image with gaussian noise added (s=12)');
figure(2);
imshow(nimg);

fimg = img_median_filt(nimg, 1);
disp('Figure 3: Noisy image filtered by a 3x3 median filter');
figure(3);
imshow(fimg);

fimg = img_median_filt(nimg, 2);
disp('Figure 4: Noisy image filtered by a 5x5 median filter');
figure(4);
imshow(fimg);

rep = input('Press any key to continue...', 's');
close(figure(2));  close(figure(3)); close(figure(4));


% Multiple addition of noise
[nimg, e] = img_rep_noise(img, 100, 12);
disp('Figure 2: Gaussian noise (sigma=12), added to the original image for 100 times');
figure(2);
imshow(nimg);
fprintf('Max. absolute error: %d\n', max(max(e)));


rep = input('Press any key to close all figures, clear all variables and finish...', 's');
close all; clear all;
