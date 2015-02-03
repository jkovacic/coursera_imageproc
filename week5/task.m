% Test tasks for the Week 5
clear all; close all; clc;

% The test image of coins can be downloaded from:
% https://commons.wikimedia.org/wiki/File:Coin_Christian_the_Elder_of_Brunswick_and_Luneburg.png

% Load the image and threshold it:
img = edge(imread('../Coin_Christian_the_Elder_of_Brunswick_and_Luneburg.png'), 'sobel');

% Display the image:
disp('Figure 1: the original image')
figure(1);
imshow(img);

[ Hc, pc, qc, rc]= img_hough_circle(img);
nimg = img_draw_circles(img, Hc, pc, qc, rc, 5);

figure(2);
disp('Figure 2: the original image with detected circles in gray');
imshow(nimg);

rep = input('Press any key to close all figures, clear all variables and finish...', 's');
close all; clear all;
