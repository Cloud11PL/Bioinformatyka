function window = InputMatrix(matrix,sizer,ts)
    [rows,columns] = size(matrix);
    window = matrix;
    for w = 1:rows
       for k = 1:columns
           % %  VER II  
              iterationVal = 0;
              if w-sizer > 0 && k-sizer > 0
               for p = 1:sizer
                    if window(w+1-p,k+1-p) == 1
                         iterationVal = iterationVal + 1;
                    end
               end
              end
               for o = 1:sizer
                     if iterationVal == sizer-ts || iterationVal == sizer
                         window(w+1-o,k+1-o) = 8;
                     end
               end  
       end     
    end
    spy(window)
end   


%         %VER I
%         if w -2 >0 && k -2 >0
%            if window(w,k) == 1 && window(w-2,k-2)==1 && window(w-1,k-1)==1
%                  window(w,k) = 8;
%                  window(w-1,k-1) = 8;
%                  window(w-2,k-2) = 8;
%            end
%         end



   



    
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

