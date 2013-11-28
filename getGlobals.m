function [bounds, dim] = getGlobals(filename, funNum)

% GETGLOBALS parses 'fun.m' in order to make 'dim' and
% 'bounds' variables available as globals prior to the execution of the rest
% of the code
% 'filename' ('fun.m') is passed as a string
% [vector, int] <- (string, int)


fid = fopen(filename, 'r');
line = fgetl(fid);
caseToken = sprintf('case %d', funNum);

boundsTmp = [];
dimTmp = [];

while ischar(line)
   
    match = strfind(line, caseToken);

    if (length(match) == 1)
        break
    end
    
    line = fgetl(fid);
    
end

line = fgetl(fid);

while ischar(line)
  
    % if declaration of dim
    if isempty(dimTmp)
        [token, r] = regexp(line, '\<dim\s*=\s*(\d+)\s*;', 'once', 'tokens');
        if r
            value = token{:};
            dimTmp = str2double(value);
        end
    end
    
    % if declaration of bounds
    if isempty(boundsTmp)
        [token, r] = regexp(line,'\[([-]?[0-9]*\.?[0-9]+[,]?\s*[-]?[0-9]*\.?[0-9]+)\]', 'once', 'tokens');
            if r
                value = token{:};
                boundsTmp = str2num(value);
            end
    end
    
    if ~(isempty(dimTmp) || isempty(boundsTmp))
        fclose(fid);
        
        if nargout == 2
            bounds = boundsTmp;
            dim = dimTmp
        else
            bounds = boundsTmp;
        end
        return
        
    end

    line = fgetl(fid);

end


end