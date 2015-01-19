% Test tasks for the Week 2

clear all; close all; clc;

% Load the image:
img = imread('../lena512.pgm');

% Display the image:
disp('Figure 1: the original image')
figure(1);
imshow(img);


%DCT transform:
timg = img_transform(img, 1);

% Quantizations:
% - by quantization matrix:
q1 = img_quantize(timg, 0, 0);

% - threshold (th=32):
q2 = img_quantize(timg, 1, 32);

% - threshold (th=16):
q3 = img_quantize(timg, 1, 16);

% - preserved 8 largest coefficients:
q4 = img_quantize(timg, 2, 0);

% Inverse transforms of all  quantizations:
im1 = img_inv_transform(q1, 0);
im2 = img_inv_transform(q2, 1);
im3 = img_inv_transform(q3, 0);
im4 = img_inv_transform(q4, 1);

% Display all compressed images:
disp('Figure 2: compressed using the quantization matrix:');
figure(2);
imshow(im1);

disp('Figure 3: compressed using the threshold 32:');
figure(3);
imshow(im2);

disp('Figure 4: compressed using the threshold 16:');
figure(4);
imshow(im3);

disp('Figure 5: compressed by preserving 8 largest DCT coefficients:');
figure(5);
imshow(im3);

rep = input('Press any key to continue...', 's');
close(figure(2));  close(figure(3));  close(figure(4));  close(figure(5));

% Apply quantization on the original image
im1 = img_quantize(img, 0, 0);
disp('Figure 2: Quantization of an image without performing DCT, use quantization matrix:')
figure(2);
imshow(im1);

im2 = img_quantize(img, 1, 32);
disp('Figure 3: Quantization of an image without performing DCT, use threshold 32:')
figure(3);
imshow(im2);

im3 = img_quantize(img, 1, 16);
disp('Figure 4: Quantization of an image without performing DCT, use threshold 16:')
figure(4);
imshow(im3);

im3 = img_quantize(img, 2, 0);
disp('Figure 5: Quantization of an image without performing DCT, use preservation of 8 largest values:')
figure(5);
imshow(im4);


rep = input('Press any key to close all figures, clear all variables and finish...', 's');

close all; clear all;
