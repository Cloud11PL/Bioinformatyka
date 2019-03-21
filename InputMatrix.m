function [window] = InputMatrix(matrix,sizer,error)
    [rows,columns] = size(matrix);                                          %Set values of columns and rows to appropiate dimetions of the matrix +2
    window = zeros(size(matrix));                                           %Prealocation +1
    for w = 1:rows                                                          %Checking condition +1
       for k = 1:columns                                                    %Checking condition +1
           if matrix(w,k) == 1                                              %Checking condition +1
               foundZeros = 0;                                              %Setting value +1
               for i = 1:sizer-1                                            %Checking condition +1
                  if  ~(w+i < rows && k+i < columns && matrix(w+i,k+i) == 1)%Checking 3 conditions +3
                      foundZeros = foundZeros+1;                            %Setting value +1
                  end
               end
               if foundZeros <= error                                       %Checking condition +1
                   window(w,k) =1;                                          %Setting matrix values +1
                  for i = 1:sizer-1                                         %Checking condition +1
                     window(w+i,k+i) = 1;                                   %Setting matrix values +1
                  end
               end
           end
       end     
    end
end   

%