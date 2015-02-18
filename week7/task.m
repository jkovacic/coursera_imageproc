% Test tasks for the Week 7
clear all; close all; clc;


% dI / dt for the given image
img = imread('../lena512.pgm');

figure(1);
disp('Figure 1: the original image');
imshow(img);

it = img_inpainting_i_t(img);
disp('Figure 2: inpainting PDEs'' dI/dt');
figure(2);
mesh(it);
