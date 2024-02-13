clc;
clear;
close all;

for i = 1:9
    eval(['load(''C:\Users\User\Desktop\FT_GT_subject10',num2str(i),''');'])
end

FT_GT = [];
for i = 1:9
    eval(['FT_GT = [FT_GT;FT_GT_subject10',num2str(i),'];'])
end

data_traintest_matrix = [];
for i = 1:9
    eval(['L',num2str(i),'=length(FT_GT_subject10',num2str(i),');'])
%    eval(['data_traintest_matrix_L',num2str(i),'=[];'])
%    eval(['data_traintest_matrix_L',num2str(i),'(1:L',num2str(i),',1)=',i,';'])
    eval(['data_traintest_matrix_L',num2str(i),'(1:L',num2str(i),',1)=i;'])
    eval(['data_traintest_matrix=[data_traintest_matrix;data_traintest_matrix_L',num2str(i),'];'])
end

%KNN
for i = 1:9
    test = (data_traintest_matrix==i);
    train = ~test;
    FT_GT_test = FT_GT(test,:);
    FT_GT_train = FT_GT(train,:);
    model = fitcknn(FT_GT_train(:,1:108),FT_GT_train(:,109));
    predictmodel = predict(model,FT_GT_test(:,1:108));
    eval(['Confusionmatrix_',num2str(i),'=confusionmat(FT_GT_test(:,109),predictmodel,''Order'',[0 1 2 3 4 5 6 7 12 13 16 17 24]);'])
    eval(['Acc=sum(diag(Confusionmatrix_',num2str(i),'))/sum(sum(Confusionmatrix_',num2str(i),'));']);
    for j =1:13
       eval(['Sen(j,1)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(j,:));']);
       eval(['Pre(1,j)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(:,j));']);
   end
   TotalMatrix(i,1)=Acc;
   TotalMatrix(i,2)=mean(Sen(:,1));
   TotalMatrix(i,3)=mean(Pre(1,:));
end
TotalMatrix2(1,1)=mean(TotalMatrix(:,1));
TotalMatrix2(1,2)=mean(TotalMatrix(:,2));
TotalMatrix2(1,3)=mean(TotalMatrix(:,3));


% NB
for i = 1:9
    test = (data_traintest_matrix==i);
    train = ~test;
    FT_GT_test = FT_GT(test,:);
    FT_GT_train = FT_GT(train,:);
    model = fitcnb(FT_GT_train(:,1:108),FT_GT_train(:,109));
    predictmodel = predict(model,FT_GT_test(:,1:108));
    eval(['Confusionmatrix_',num2str(i),'=confusionmat(FT_GT_test(:,109),predictmodel,''Order'',[0 1 2 3 4 5 6 7 12 13 16 17 24]);'])
    eval(['Acc=sum(diag(Confusionmatrix_',num2str(i),'))/sum(sum(Confusionmatrix_',num2str(i),'));']);
    for j =1:13
       eval(['Sen(j,1)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(j,:));']);
       eval(['Pre(1,j)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(:,j));']);
   end
   TotalMatrix(i,1)=Acc;
   TotalMatrix(i,2)=mean(Sen(:,1));
   TotalMatrix(i,3)=mean(Pre(1,:));
end
TotalMatrix2(2,1)=mean(TotalMatrix(:,1));
TotalMatrix2(2,2)=mean(TotalMatrix(:,2));
TotalMatrix2(2,3)=mean(TotalMatrix(:,3));

% DB
for i = 1:9
    test = (data_traintest_matrix==i);
    train = ~test;
    FT_GT_test = FT_GT(test,:);
    FT_GT_train = FT_GT(train,:);
    model = fitctree(FT_GT_train(:,1:108),FT_GT_train(:,109));
    predictmodel = predict(model,FT_GT_test(:,1:108));
    eval(['Confusionmatrix_',num2str(i),'=confusionmat(FT_GT_test(:,109),predictmodel,''Order'',[0 1 2 3 4 5 6 7 12 13 16 17 24]);'])
    eval(['Acc=sum(diag(Confusionmatrix_',num2str(i),'))/sum(sum(Confusionmatrix_',num2str(i),'));']);
    for j =1:13
       eval(['Sen(j,1)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(j,:));']);
       eval(['Pre(1,j)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(:,j));']);
   end
   TotalMatrix(i,1)=Acc;
   TotalMatrix(i,2)=mean(Sen(:,1));
   TotalMatrix(i,3)=mean(Pre(1,:));
end
TotalMatrix2(3,1)=mean(TotalMatrix(:,1));
TotalMatrix2(3,2)=mean(TotalMatrix(:,2));
TotalMatrix2(3,3)=mean(TotalMatrix(:,3));

%KNN sample by sample
SP = 50;
for i = 1:9
    test = (data_traintest_matrix==i);
    train = ~test;
    FT_GT_test = FT_GT(test,:);
    FT_GT_train = FT_GT(train,:);
    model = fitcknn(FT_GT_train(:,1:108),FT_GT_train(:,109));
    predictmodel = predict(model,FT_GT_test(:,1:108));
    predictpoint = [];
    for j = 1:length(predictmodel)
        predictpoint(1+(j-1)*SP:100+(j-1)*SP,1)=predictmodel(j,1);
    end
    eval(['predictpoint(length(predictpoint)+1:length(subject10',num2str(i),'),1)=predictmodel(length(predictmodel),1);'])
    eval(['Confusionmatrix_',num2str(i),'=confusionmat(FT_GT_test(:,109),predictpoint,''Order'',[0 1 2 3 4 5 6 7 12 13 16 17 24]);'])
    eval(['Acc=sum(diag(Confusionmatrix_',num2str(i),'))/sum(sum(Confusionmatrix_',num2str(i),'));']);
    for j =1:13
       eval(['Sen(j,1)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(j,:));']);
       eval(['Pre(1,j)=Confusionmatrix_',num2str(i),'(j,j)/sum(Confusionmatrix_',num2str(i),'(:,j));']);
   end
   TotalMatrix(i,1)=Acc;
   TotalMatrix(i,2)=mean(Sen(:,1));
   TotalMatrix(i,3)=mean(Pre(1,:));
end
TotalMatrix2(1,1)=mean(TotalMatrix(:,1));
TotalMatrix2(1,2)=mean(TotalMatrix(:,2));
TotalMatrix2(1,3)=mean(TotalMatrix(:,3));
