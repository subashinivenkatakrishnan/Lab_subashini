% Entropy of images
clear;
clc;
tic;
numOfImages=12;

for i=1:numOfImages
    imageName=['Img' num2str(i)];
    Images.(imageName)= dlmread([imageName '.txt'],' ',0,1);    %A struct of 6 500x500 images
end
names=fieldnames(Images);

%for i=1:length(names)                                           %length(names) is same as numOfImages
    minimum=min(min(Images.(char(names(1)))));                  %to find the min pixel value in the matrix
    maximum=max(max(Images.(char(names(1)))));                  %to find the max pixel value in the matrix
%end
for j=1:length(names)
       [r c]=size(Images.(char(names(j))));
          mat= Images.(char(names(j)));
    for i=minimum:maximum
        data(j,i)= length(find(mat== i))/(r*c);                  %data matrix will contain probability of values 1-10 in rows
    end
end

%{
for i=1:length(names)   
    sum1=0;
    for j=minimum:maximum
        sum1=sum1+(-data(i,j)*log2(data(i,j)));
    end
    entropy_images(i)=sum1;                                      %entropy_images vector will contain the intropy of the given images          
end
   disp('entropy of whole image');
   disp(entropy_images); 
  %}
  
 
f1='entropy';
f2='mean';
f3='index';
    imnum=11;
    n=1;
    %for n=2:numOfImages
         k=1;
        for i=1:5:r-9
            for j=1:5:c-9
                rSt=j;
                rEd=j+9;
                cSt=i;
                cEd=i+9;
                 sum1=0;
                 
                for l=minimum:maximum
                 data2(n,l)= length(find((Images.(char(names(imnum)))([rSt:rEd],[cSt:cEd]))== l))/(10*10);  %data matrix will contain probability of values 1-10 in rows
                 if data2(n,l)==0  % to avoid NaN
                 continue;
                 else
                     sum1=sum1+(-data2(n,l)*log2(data2(n,l)));
                 end
                end
                 image_struct(k).f1=sum1;
                 %entropy_images_submat(n,k)=sum1;
                 A=Images.(char(names(imnum)))([rSt:rEd],[cSt:cEd]);
                 B=reshape(A,1,[]);
                 X(1,:,k)=B;
                 tot=sum((Images.(char(names(imnum)))([rSt:rEd],[cSt:cEd])));
                 image_struct(k).f2=sum(tot)/100;
                 image_struct(k).f3=sub2ind(size(Images.(char(names(1)))),rSt,cSt);
                
                % mean_images_submat(n,k)=sum(tot)/100;
                 
                k=k+1;
             end
        end
        X

        % for i=1:numOfImages
%        colMat=im2col(Images.(char(names(1))),[10 10]);
%        [row col]=size(colMat);
%         sum2=sum(colMat);
%         for m=1:col
%             sum1=0;
%             for j=minimum:maximum
%                 data2(m,j)= length(find(colMat(:,m)== j))/row;                  %data matrix will contain probability of values 1-10 in rows
%                  if data2(m,j)==0  % to avoid NaN
%                     continue;
%                  else
%                      sum1=sum1+(-data2(m,j)*log2(data2(m,j)));
%                  end
%                  
%             end
%             mean_images_submat(1,m)=sum2(m)/row;
%             entropy_images_submat(1,m)=sum1;
%         end

      
   %end
         
   %end
   
   %---------sorting in increasing order of entropy------------------------
   
   Img_fields = fieldnames(image_struct);
   Img_cell = struct2cell(image_struct);
   sz = size(Img_cell);
   Img_cell = reshape(Img_cell, sz(1), []);
   Img_cell = Img_cell';                       
   Img_cell = sortrows(Img_cell, 1);
   Img_cell = reshape(Img_cell', sz);
   Img_sorted = cell2struct(Img_cell, Img_fields, 1);
%    Img_sorted=flipud(Img_sorted(:));
%    Img_sorted=Img_sorted';
   %----------taking the 1st , mid and last 100 values---------------------
    min_img=Img_sorted(1:100);
    mid_img=Img_sorted(round((k-1)/2)-50:round((k-1)/2)+49);
    max_img=Img_sorted(k-100:k-1);
   
  
   
   %---------sorting in increasing order of min mean---------------------------
   
   Img_minmean = fieldnames(min_img);
   Img_cell_minmean = struct2cell(min_img);
   szm = size(Img_cell_minmean);
   Img_cell_minmean = reshape(Img_cell_minmean, szm(1), []);
   Img_cell_minmean = Img_cell_minmean';                       
   Img_cell_minmean = sortrows(Img_cell_minmean, 2);
   Img_cell_minmean = reshape(Img_cell_minmean', szm);
   Img_sorted_minmean = cell2struct(Img_cell_minmean, Img_minmean, 1);
   
   %---------sorting in increasing order of mid mean---------------------------
   
   Img_midmean = fieldnames(mid_img);
   Img_cell_midmean = struct2cell(mid_img);
   szm = size(Img_cell_midmean);
   Img_cell_midmean = reshape(Img_cell_midmean, szm(1), []);
   Img_cell_midmean = Img_cell_midmean';                       
   Img_cell_midmean = sortrows(Img_cell_midmean, 2);
   Img_cell_midmean = reshape(Img_cell_midmean', szm);
   Img_sorted_midmean = cell2struct(Img_cell_midmean, Img_midmean, 1);
   
   %---------sorting in increasing order of max mean---------------------------
   
   Img_maxmean = fieldnames(max_img);
   Img_cell_maxmean = struct2cell(max_img);
   szm = size(Img_cell_maxmean);
   Img_cell_maxmean = reshape(Img_cell_maxmean, szm(1), []);
   Img_cell_maxmean = Img_cell_maxmean';                       
   Img_cell_maxmean = sortrows(Img_cell_maxmean, 2);
   Img_cell_maxmean = reshape(Img_cell_maxmean', szm);
   Img_sorted_maxmean = cell2struct(Img_cell_maxmean, Img_maxmean, 1);
   
   
   %-----------------------------------------------------------------------
   
    j=1;    
    l=1;
    rm=100;
%     [rm cm]=size(maxmean);
    for i=1:10:rm
        minmean_final(j)=Img_sorted_minmean(i);
        midmean_final(j)=Img_sorted_midmean(i);
        maxmean_final(j)=Img_sorted_maxmean(i);     
        j=j+1;
    end
 
   %-------------------------------------------------------------------------- 
   
   
  toc 