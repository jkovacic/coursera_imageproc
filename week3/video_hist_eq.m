clear all;   close all;

% The video clip taken from
% https://commons.wikimedia.org/wiki/File:Ap16_rover.ogg
% and further process to reduce its size and length:
vobj = VideoReader('../rover.webm');

nFrames = vobj.NumberOfFrames;
vidHeight = vobj.Height;
vidWidth = vobj.Width;


%
% Part 1: histogram equalization is performed on each frame
%

% Preallocate movie structure.
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);

% Read one frame at a time.
for i = 1 : nFrames
    frame = read(vobj, i);

    % Apply histogramequalization on ech frame's channel:
    for ch = 1 : 3
        %frame(:, :, ch) = img_hist_eq( frame(:, :, ch) );
        frame(:, :, ch) =  histeq(frame(:, :, ch), 256);
    end  % for ch

    % And append the frame to the movie
    mov(i).cdata = frame;
end  % for i

% Save the movie as an AVI file
movie2avi(mov, 'single_histeq.avi', 'FPS', vobj.FrameRate);
disp('Each frame''s histogram has been equalized and the movie has been');
disp('saved to ''single_hist_eq.avi''');


%
% Part 2: all frames are combined into a single image, histogram
% equalization is performed on it, then the large image is split back to
% frames and a video is composed from the frames:
%

% Preallocate memory for the large mage (for eachcolor channel separately)
buf = uint8(zeros(vidHeight * nFrames, vidWidth, 3));

% Each frame is copied into the approprate place within 'buf'
for f = 1 : nFrames
    frame = read(vobj, f);
    buf((1+(f-1)*vidHeight) : (f*vidHeight), :, :) = frame;
end  % for f

% Histogram equalization is performed on the large image 
% (separately for each color channel )
for ch = 1 : 3
    buf(:, :, ch) = histeq(buf(:, :, ch), 256);
end  % for ch


% Preallocate the movie structure.
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);

% The appropriate parts of the large image are copied into the movie
% structure
for f = 1 : nFrames
    mov(f).cdata = buf((1+(f-1)*vidHeight) : (f*vidHeight), :, :);
end  % for f

% The movie is saved into an AVI file
movie2avi(mov, 'group_histeq.avi', 'FPS', vobj.FrameRate);
disp('All frames'' histogram has been equalized and the movie has been');
disp('saved to ''group_hist_eq.avi''');
