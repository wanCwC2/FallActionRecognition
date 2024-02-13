clc;
clear;
close all;

for i = 1:9
    eval(['load(''C:\Users\User\Downloads\Protocol\subject10',num2str(i),'.dat'');'])
end

for i = 1:9
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,1:3)=subject10',num2str(i),'(:,5:7);'])
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,4:6)=subject10',num2str(i),'(:,11:13);'])
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,7:9)=subject10',num2str(i),'(:,22:24);'])
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,10:12)=subject10',num2str(i),'(:,28:30);'])
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,13:15)=subject10',num2str(i),'(:,39:41);'])
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,16:18)=subject10',num2str(i),'(:,45:47);'])
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,19)=subject10',num2str(i),'(:,2);'])
end

%subject總共有9組要計算
for i = 1:9
    WS = 100;
    SP = 50; %每個視窗的大小
    eval(['NW = fix(((length(subject10',num2str(i),'_HandChestAnkle_AccGyro)-WS)/SP)+1);']) %number of window總共可以分成多少區間個視窗
    eval(['subject10',num2str(i),'_HandChestAnkle_AccGyro(:,19)=subject10',num2str(i),'(:,2);'])
    for j = 1:NW
        %第幾區間視窗的資料
        interval = 1+(j-1)*SP:100+(j-1)*SP;
        %之所以會18是因為有3個感測器(頭胸膝)，每個感測器都有6個軸，因此3*6=18
        %再來因為每個軸都要計算6筆資料，因此18*6=108
        %所以如果輸出結果要是num*108
        for k = 1:18
            eval(['FT_subject10',num2str(i),'(j,(1+(k-1)*6))=mean(subject10',num2str(i),'_HandChestAnkle_AccGyro(interval,k));'])
            eval(['FT_subject10',num2str(i),'(j,(2+(k-1)*6))=std(subject10',num2str(i),'_HandChestAnkle_AccGyro(interval,k));'])
            eval(['FT_subject10',num2str(i),'(j,(3+(k-1)*6))=max(subject10',num2str(i),'_HandChestAnkle_AccGyro(interval,k));'])
            eval(['FT_subject10',num2str(i),'(j,(4+(k-1)*6))=min(subject10',num2str(i),'_HandChestAnkle_AccGyro(interval,k));'])
            eval(['FT_subject10',num2str(i),'(j,(5+(k-1)*6))=range(subject10',num2str(i),'_HandChestAnkle_AccGyro(interval,k));'])
            eval(['FT_subject10',num2str(i),'(j,(6+(k-1)*6))=var(subject10',num2str(i),'_HandChestAnkle_AccGyro(interval,k));'])
        end
        eval(['GT_subject10',num2str(i),'(j,1)=mode(subject10',num2str(i),'_HandChestAnkle_AccGyro(interval,19));'])
    end
    eval(['FT_GT_subject10',num2str(i),'=[FT_subject10',num2str(i),',GT_subject10',num2str(i),'];'])
end