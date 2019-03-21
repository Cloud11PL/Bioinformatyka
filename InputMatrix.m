function [window] = InputMatrix(matrix,sizer,error)
%sizer - size of the window
    [rows,columns] = size(matrix);
    window = zeros(size(matrix));
    for w = 1:rows
       for k = 1:columns
           if matrix(w,k) == 1
               foundZeros = 0;
               for i = 1:sizer-1
                  if  ~(w+i < rows && k+i < columns && matrix(w+i,k+i) == 1) 
                      foundZeros = foundZeros+1;
                  end
               end
               if foundZeros <= error
                   window(w,k) =1;
                  for i = 1:sizer-1
                     window(w+i,k+i) = 1; 
                  end
               end
           end
       end     
    end
end   

%VER I
%               if window(w,k) == 1 && window(w-2,k-2)==1 &&window(w-1,k-1)==1
%                  window(w,k) = 8;
%                  window(w-1,k-1) = 8;
%                  window(w-2,k-2) = 8;



%              %  VER II  
%               iterationVal = 0;
%               if w-sizer > 0 && k-sizer > 0
%                for p = 1:sizer
%                     if window(w+2-p,k+1-p) == 1
%                          iterationVal = iterationVal + 1;
%                     end
%                end
%               end
%                for o = 1:sizer
%                      if iterationVal == sizer-err || iterationVal == sizer
%                          window(w+1-o,k+1-o) = 8;
%                      end
%                end     



    
 %VER III
%  counter = 0;
%            if matrix(w,k) ==1 
%                for p = 1:sizer
%                   if k+p <= columns && w+p <= rows && window(w+p-1,k+p-1) ==1 
%                       counter = counter +1;
%                       counter
%                   end
%                end
%                if counter == sizer-error || counter == sizer
%                    for p = 1:sizer
%                       window(w-p,k-p) =8; 
%                    end
%                end
%            end   
% 

