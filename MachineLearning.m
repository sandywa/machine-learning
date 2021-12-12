
%create matrix sample data 1
folder = uigetdir();
I=dir(fullfile(folder,'*.png'));
for a=1:numel(I)
  filename=fullfile(folder,I(a).name);
  name{a} = filename;
  disp(filename);
end
for aa=1:numel(I)
    img=name{aa};
    sz=imread(img); %read the image
    pict=double(sz);% convert it to double for calculations
    dim=size(pict); %determine the dimension of the pict
    count=0;meanR=0;meanG=0;meanB=0;%preallocations
    for i=1:dim(1)
        for j=1:dim(2)
            meanR=meanR+pict(i,j,1);
            meanG=meanG+pict(i,j,2);
            meanB=meanB+pict(i,j,3);
            count=count+1;
        end
        meanR1=meanR/count;
        meanG1=meanG/count;
        meanB1=meanB/count;
    end
    avgrgb{aa}=[meanR1,meanG1,meanB1]; %prints the rgb average value
      disp(avgrgb{aa});
   
      % create matrix sample
      if (aa  == 1)
        sample1 = ['mentah'];
      else 
        sample1 = [sample1;'mentah'];
      end
      
      % create matrix rgb data1
      if (aa == 1)
            matrix = avgrgb{aa};
      else
            matrix = [ matrix ; avgrgb{aa}];
      end
end

%create matrix sample data 2
folder = uigetdir();
J=dir(fullfile(folder,'*.png'));
for b=1:numel(J)
  filename2=fullfile(folder,J(b).name);
  name2{b} = filename2;
  disp(filename2);
end
for bb=1:numel(J)
    img2=name2{bb};
    sz2=imread(img2); %read the image
    pict2=double(sz2);% convert it to double for calculations
    dim2=size(pict2); %determine the dimension of the pict
    count2=0;meanR2=0;meanG2=0;meanB2=0;%preallocations
    for m=1:dim2(1)
        for n=1:dim2(2)
            meanR2=meanR2+pict2(m,n,1);
            meanG2=meanG2+pict2(m,n,2);
            meanB2=meanB2+pict2(m,n,3);
            count2=count2+1;
        end
        meanR12=meanR2/count2;
        meanG12=meanG2/count2;
        meanB12=meanB2/count2;
    end
    avgrgb2{bb}=[meanR12,meanG12,meanB12]; %prints the rgb average value
      disp(avgrgb2{bb});
      
      % create matrix sample2
      if (bb  == 1)
        sample2 = ['matang'];
      else 
        sample2 = [sample2;'matang'];
      end
      
      % create matrix data2
      if (bb == 1)
            matrix2 = avgrgb2{bb};
      else
            matrix2 = [ matrix2 ; avgrgb2{bb}];
      end
end

%Membuat matrik input
img3=uigetfile(...
    {'.bmp;*.png;*.jpeg;*.jpg', 'File citra(.bmp,*.png,*.jpeg,*.jpg)';
    '.bmp', 'File Bitmap(.bmp)';...
    '.png', 'File Png(.png)';...
    '.jpg', 'File Jpeg(.jpg)';
    '.', 'Semua File (.)'},...
    'Buka Citra asli');

    sz3=imread(img3); %read the image
    pict3=double(sz3);% convert it to double for calculations
    dim3=size(pict3); %determine the dimension of the pict
    count3=0;meanR3=0;meanG3=0;meanB3=0;%preallocations
    for i3=1:dim3(1)
        for j3=1:dim3(2)
            meanR3=meanR3+pict3(i3,j3,1);
            meanG3=meanG3+pict3(i3,j3,2);
            meanB3=meanB3+pict3(i3,j3,3);
            count3=count3+1;
        end
        meanR13=meanR3/count3;
        meanG13=meanG3/count3;
        meanB13=meanB3/count3;
    end
    avgrgb3=[meanR13,meanG13,meanB13]; %prints the rgb average value
    
%menyimpan inputan    
sample = avgrgb3;

%data yang sudah dikelompokkan 
namaBaru = [sample1;sample2];
dataBaru = [matrix;matrix2];

%KNN
training = dataBaru;
group = namaBaru;

class = fitcknn(training, group,'NumNeighbors', 3);
klasifikasi = predict(class, sample);

disp('Hasil klasifikasi :  ')
disp(klasifikasi)

