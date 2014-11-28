function InfoMat = calculate_informations(Hs)

load combInds.mat;

combNum = length(Hs);
InfoMat = zeros(184);


for i=1:combNum
    
    n = combInds(i,1);
    m = combInds(i,2);
   
    if n==140 || m==140
        temp=0;
    else
        temp = information(Hs{i});
    end
    InfoMat(n,m) = temp;
    InfoMat(m,n) = temp;
end

save('informationMatrix.mat','InfoMat');

displayMatrix(InfoMat);
end