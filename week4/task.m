% Test tasks for the Week 4
clear all; close all; clc;

% Load the image:
img = imread('../lena512.pgm');

% Display the image:
disp('Figure 1: the original image')
figure(1);
imshow(img);

% Add Gaussian and salt&pepper noise of various intensities
ng1 = img_add_noise(img, 0, 0.001);
ng2 = img_add_noise(img, 0, 0.005);
ng3 = img_add_noise(img, 0, 0.01);
ng4 = img_add_noise(img, 0, 0.05);

sp1 = img_add_noise(img, 1, 0.01);
sp2 = img_add_noise(img, 1, 0.05);
sp3 = img_add_noise(img, 1, 0.1);
sp4 = img_add_noise(img, 1, 0.5);

disp('Figure 2: Gaussian and salt & pepper noise of various levels added tothe image');
figure(2);
subplot(2, 4, 1);
imshow(ng1);
title('Gaussian noise, var=0.001');
subplot(2, 4, 2);
imshow(ng2);
title('Gaussian noise, var=0.005');
subplot(2, 4, 3);
imshow(ng3);
title('Gaussian noise, var=0.01');
subplot(2, 4, 4);
imshow(ng4);
title('Gaussian noise, var=0.05');

subplot(2, 4, 5);
imshow(sp1);
title('Salt & pepper noise, D=0.01');
subplot(2, 4, 6);
imshow(sp2);
title('Salt & pepper noise, D=0.05');
subplot(2, 4, 7);
imshow(sp3);
title('Salt & pepper noise, D=0.1');
subplot(2, 4, 8);
imshow(sp4);
title('Salt & pepper noise, D=0.5');

rep = input('Press any key to continue...', 's');
%close(figure(2));


% Apply median filter to filter the noisy images obtained above

% figure counter
i = 3;
for n = [3, 5, 10];
    fprintf('Figure %d\n: apply median filter of size %dx%d', i, n, n);
    figure(i);
    subplot(2, 4, 1);
    imshow(medfilt2(ng1, [n, n]));
    subplot(2, 4, 2);
    imshow(medfilt2(ng2, [n, n]));
    subplot(2, 4, 3);
    imshow(medfilt2(ng3, [n, n]));
    subplot(2, 4, 4);
    imshow(medfilt2(ng4, [n, n]));
    subplot(2, 4, 5);
    imshow(medfilt2(sp1, [n, n]));
    subplot(2, 4, 6);
    imshow(medfilt2(sp2, [n, n]));
    subplot(2, 4, 7);
    imshow(medfilt2(sp3, [n, n]));
    subplot(2, 4, 8);
    imshow(medfilt2(sp4, [n, n]));
    
    i = i + 1;
end  % for

rep = input('Press any key to close all figures, clear all variables and finish...', 's');
close all; clear all;
