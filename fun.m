function fit = fun(x, funNum)

global D
dim = 5;

switch funNum
    
    case 1
    % F5 ----------------------------------------------------->
    % optimum: fitness = -39.336 dla dim = 4
    %          fitness = -59.0041 dla dim = 6 

    % bounds = [-5.12, 5.12];
    % dim = 6;        % dim mo¿e byæ dowolne    

    fit = 0;
    for i=1:dim
        fit = fit + x(i).^2 - 10*cos(2*pi.*x(i) + 10);
    end


    case 2
    % F8 (Schwefela) ----------------------------------------->
    
    % optimum: fitness = -418.9829*dim   x* = [420.9687, 420.9687, ..., 420.9687]
    
    % bounds = [-500, 500];
    % dim = 8;        % dim dowolne wiêksze ni¿ 2   
    
    fit = 0;
    for i = 1 : dim
        fit = fit + (-x(i)*sin(sqrt(abs(x(i))))); 
    end


    case 3
    % F9 (Michalewicza) -------------------------------------->

    % optimum: dla dim = 5: fitness = -4.687
    %          dla dim = 10: fitness = -9.6602
    % bounds = [0, 3.1416];
    % dim = 10;        % dim dowolne wiêksze ni¿ 2

    fit = 0;
    m=10;
    for i = 1 : dim
        fit = fit + sin( x(i) ) * ( sin( (i*x(i)^2)./pi ) ).^(2*m);
    end
    fit = -1*fit;
    
    case 4
    % Rosenbrocka -------------------------------------->

    % optimum: dla dim = 7: fitness = 0 w (1, 1, …, 1)
    % bounds = [-2.048, 2.048];
    % dim = 7; 

    fit = 0;
    for i = 1 : dim-1
        fit = fit + (100*(x(i+1) - x(i)^2)^2  + (1-x(i))^2);
    end
    
    case 5
    % Schwefela -------------------------------------->

    % optimum: dla dim = 7: fitness = 0 w (1, 1, …, 1)
    % bounds = [-500, 500];
    % dim = 7; 

    fit = 0;
    for i = 1 : dim-1
        fit = fit + (100*(x(i+1) - x(i)^2)^2  + (1-x(i))^2);
    end
    

    otherwise
        error('Incorrect function number');
end




