% This file defines a matlab class 'bmeimg' which performs various image analysis tasks.

classdef bmeimg < handle
    
    properties 
        image_; % use image_ because image() is a function in matlab
    end
    
    properties (Dependent)
        img_info_obj = imfinfo(obj.image_)  
        filename = img_info_obj.Filename;
        resolution = string(img_info_obj.Width+' x '+img_info_obj.Height);
        colortype = img_info_obj.ColorType;
    end
  
    methods
        function obj = bmeimg(img_arg) % Constructor
            % if img_arg is a numeric matrix  read with image()
            if isnumeric(img_arg)
               obj.image_ = image(img_arg); 
            % if img_arg is a directory (char array) read with imread()
            elseif ischar(img_arg)
               obj.image_ = imread(img_arg);
            else
               error('Arg must be a matrix or dir to image')  
            end
        end
        
        % Grayscale 
        function out=tograyscale(obj)
            if nargout 
                %create copy if the result of this function is being 
                % assigned to a variable, then pass to function
                objcopy = bmeimg(obj.image_);
                objcopy.image_ = rgb2gray(objcopy.image_); % Change copy
                out = objcopy.image_;
            else
                obj.image_ = rgb2gray(obj.image_); % else, change original object
                out = obj.image_;
            end
        end
        
        % Edge detection
        function out = detectedges(obj)
            if nargout 
                objcopy=bmeimg(obj.image_);
                [~, threshold] = edge(objcopy.image_, 'sobel');
                objcopy.image_ = edge(objcopy.image_,'sobel', threshold);
                out = objcopy.image_;
            else
                [~, threshold] = edge(obj.image_, 'sobel');
                obj.image_ = edge(obj.image_,'sobel', threshold);
                out = obj.image_;
            end
        end
        
        % Dilate 
        function out = dilate(obj,windowsize)
            if windowsize
                w = strel('line', windowsize, 90);    % look up strel
            else
                windowsize = 3;
                w = strel('line', windowsize, 90);
            end
            
             if nargout 
                objcopy=bmeimg(obj.image_);
                objcopy.image_ = imdilate(objcopy.image_, [w w]);
                out = objcopy.image_;
             else
                obj.image_ = imdilate(obj.image_, [w w]);
                out = obj.image_;
             end
        end
        
        % Fill holes
        function out = fillholes(obj)
            if nargout 
                objcopy=bmeimg(obj.image_);
                objcopy.image_ = imfill(objcopy.image_, 'holes');
                out = objcopy.image_;
            else
                obj.image_ = imfill(obj.image_, 'holes');
                out = obj.image_;
            end
        end
        
        % Clear border
        function out = clearborder(obj,connectivity)
             if nargout 
                objcopy=bmeimg(obj.image_);
                objcopy.image_ = imclearborder(obj.copyimage_,connectivity);
                out = objcopy.image_;
             else
                obj.image_ = imclearborder(obj.image_,connectivity);
                out = obj.image_;
             end
        end
        
        % Erode
        function out = erode(obj,windowsize)
            if windowsize
                w = windowsize;
            else
                w = 3;
            end
            
            seD = strel('square',w);
            
            if nargout 
                objcopy=bmeimg(obj.image_);
                objcopy.image_ = imerode(objcopy.image_,seD);
                out = objcopy.image_;
            else
                obj.image_ = imerode(obj.image_,seD);
                out = obj.image_;
            end
        end
        
        % Count Blobs
        function out = countblobs(obj, minsize, connectivity)
            if connectivity
                conn = connectivity;
            else
                conn = 4;
            end
            
            if nargout 
                objcopy=bmeimg(obj.image_);
                cc = bwconncomp(objcopy.image_,conn);
                out = cc.NumObjects;
            else
                cc = bwconncomp(obj.image_,conn);
                out = cc.NumObjects;
            end
        end
        
        % Show image
        function show(obj)
            imshow(obj.image_);
        end
        
        %{
        function disp(obj)
             img_info_obj = imfinfo(obj.image_)  
             filename = img_info_obj.Filename;
             resolution = string(img_info_obj.Width+' x '+img_info_obj.Height);
             colortype = img_info_obj.ColorType; 
             disp(filename,resolution,colortype)
        end
        %}
        
    end
end
