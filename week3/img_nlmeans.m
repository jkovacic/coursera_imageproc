function [ fimg ] = img_nlmeans( img, r, f, h )
%IMG_NLMEANS Non-local means denoising of an image
%
% Input:
%   img   - a matix of noisy image's pixels
%   r     - size of the research neighbourhood
%   f     - size of the comparison window
%   h     - degree of filtering
%
% Return:
%   fimg - a matrix of filtered image's pixels


% The algorithm is described in detail at:
% http://www.ipol.im/pub/art/2011/bcm_nlm/


% img(x, y) == Om(x+f, y+f)
Om = padarray( double( img ), [f, f], 'symmetric' );
[rows, cols ] = size(img);

% Preallocate 'fimg'
fimg = zeros(rows, cols);

h2 = h * h;
f2 = (2*f+1);  f2 = f2*f2;

for x = 1 : rows
    for y = 1:cols
        Cp = 0;
        up = 0;
        
        % Ensure that pixel's rxr neighbourhood will not reach out of img's range
        rx1 = max( x-r, 1 );
        rx2 = min( x+r, rows );
        ry1 = max( y-r, 1 );
        ry2 = min( y+r, cols );
        
        % fxf neighbourhood around p (x,y):
        W1 = Om( (x) : (x+2*f), (y) : (y+2*f) );

        for rx = rx1: rx2
            for ry = ry1 : ry2
                % fxf neighbourhood around q (rx, ry):
                W2 = Om((rx) : (rx+2*f), (ry) : (ry+2*f) );
                
                % d2 = sum of squared differences of both fxf neighbourhoods
                du = W2 - W1;
                d2 = sum(sum( du .* du )) / f2;
                
                w = exp(-d2 / h2);
                Cp = Cp + w;
                up = up + Om(rx+f, ry+f) * w;
                
            end  % for ry
        end  % for rx
        
        fimg(x, y) = up / Cp;
    end  % for y
end  % for x

% Convert 'fimg' to uint8:
fimg = uint8( fimg );

end
