function [U] = im2one(U)
%¶şÎ¬Í¼Ïñ¹éÒ»»¯

U=(abs(U)-min(min(abs(U))))/(max(max(abs(U)))-min(min(abs(U))));
end

