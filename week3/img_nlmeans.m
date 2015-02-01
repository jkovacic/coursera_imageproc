function [ fimg ] = img_nlmeans( img, r, f, sigma, h )
%IMG_NLMEANS Non-local means denoising of an image
%
% Input:
%   img   - a matix of noisy image's pixels
%   r     - size of ht research neighbourhood
%   f     - size of the comparison window
%   sigma - standard deviation of the noise
%   h     - degree of filtering
%
% Return:
%   fimg - a matrix of filtered image's pixels


% The algorithm is described in detail at:
% http://www.ipol.im/pub/art/2011/bcm_nlm/

O = double( img );
[rows, cols ] = size(img);

% Prallocate 'fimg'
fimg = zeros(rows, cols);

h2 = h * h;
f2 = (2*f+1);  f2 = f2*f2;
sigma2 = 2*sigma * sigma;

for x = 1 : rows
    for y = 1:cols
        Cp = 0;
        up = 0;
        
        % Ensure that pixel's rxr neighbourhood will not reach out of img's range
        rx1 = max( x-r, 1 );
        rx2 = min( x+r, rows );
        ry1 = max( y-r, 1 );
        ry2 = min( y+r, cols );
        for rx = rx1: rx2
            for ry = ry1 : ry2
                % Obtain d2:
                d2 = 0;
                for fx = -f : f 
                    for fy = -f : f
                        % Comparison window of the current pixel
                        p = [ x+fx, y+fy ];
                        % Comparison window of pixel within the research window
                        q = [ rx+fx, ry+fy ];
                        
                        % If any pixel of any comparison window reaches out
                        % of img's range, fill those pixels with img
                        % mirrored around the corresponding edge
                        % (padarray(img, ...., 'symmetric'))
                        
                        if ( p(1) < 1 )
                            p(1) = 1 - p(1);
                        elseif ( p(1) > rows )
                            p(1) = 2 * rows - p(1) + 1;
                        end
                        
                        if ( p(2) < 1 )
                            p(2) = 1 - p(2);
                        elseif ( p(2) > cols )
                            p(2) = 2 * cols - p(2) + 1;
                        end
                        
                        if ( q(1) < 1 )
                            q(1) = 1 - q(1);
                        elseif ( q(1) > rows )
                            q(1) = 2 * rows - q(1) + 1;
                        end
                        
                        if ( q(2) < 1 )
                            q(2) = 1 - q(2);
                        elseif ( q(2) > cols )
                            q(2) = 2 * cols - q(2) + 1;
                        end
                        
                        du = O( p(1), p(2) ) - O(q(1), q(2) );
                        d2 = d2 + du*du;
                    end  % for fy
                end  % for fx
                
                d2 = d2 / f2;
                
                w = exp(-max(d2-sigma2, 0) / h2);
                Cp = Cp + w;
                up = up + O(rx, ry) * w;
                
            end  % for ry
        end  % for rx
        
        fimg(x, y) = up / Cp;
    end  % for y
end  % for x

% Convert 'fimg' to uint8:
fimg = uint8( fimg );

end
