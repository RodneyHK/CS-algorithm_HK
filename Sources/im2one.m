function [U] = im2one(U)
%��άͼ���һ��

U=(abs(U)-min(min(abs(U))))/(max(max(abs(U)))-min(min(abs(U))));
end

