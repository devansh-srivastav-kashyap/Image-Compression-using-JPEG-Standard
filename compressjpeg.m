%-----------------------------------------
%Author- Devansh Srivastava
%Github link- https://github.com/devansh-srivastav-kashyap/Image-Compression-using-JPEG-Standard

% JPEG standard is used to compress the image. 
% Steps of the Compression-

% 1- Convert the image to Y Cb Cr.
% 2- Downsample the chromatic channels.
% 3- Divide each channels into 8x8 blocks.
% 4- Apply DCT to each block of each channel.
% 5- Apply Quantization by default quantization matrix.
% 6- Recombine the blocks.
% 7- Apply Huffman Coding.

%------------------------------------------

function var= compressjpeg(img)
    
    imgy= rgb2ycbcr(img);   %convert to Y Cb Cr
    figure;
    imshow(img);title('Original Image');
    im=imgy;
    %downsample the chromatic channels
    im(:,:,2)= 2*round(im(:,:,2)/2);
    im(:,:,3)= 2*round(im(:,:,3)/2);
    
    Q = [16 11 10 16 24 40 51 61 ;      %default matrix used for quantization
     12 12 14 19 26 28 60 55 ;
     14 13 16 24 40 57 69 56 ;
     14 17 22 29 51 87 80 62 ;
     18 22 37 56 68 109 103 77 ;
     24 35 55 64 81 104 113 92 ;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
    
    recombine= zeros(size(im));
    recombine1=recombine;
    for channel=1:3
        for j=1:8:size(im,1)-7          %for rows
            for i=1:8:size(im,2)        %for columns
                mat= im(j:j+7,i:i+7,channel);          %block of 8x8
                freq = dct2(mat);     %DCT
                freq= Q.* round(freq./Q);        %quantization 
                
                recombine(j:j+7,i:i+7,channel)= freq;   %repasting the blocks
                recombine1(j:j+7,i:i+7,channel) =idct2(freq);  %inverse DCT
            end
        end
    end
 figure; imshow(ycbcr2rgb(uint8(recombine1))); title('Compressed Image');  
 
 
 %originalsize= 8* prod(size(img))
 %compressedsize = 8 * (nnz(recombine(:,:,1)) + 7*nnz(recombine(:,:,2)) + 7*nnz(recombine(:,:,3)))
end

                
                 
        
        
