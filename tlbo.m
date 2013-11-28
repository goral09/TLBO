% Teaching–learning-based optimization: A novel method for constrained
% mechanical design optimization problems

close all;

%\global D bounds

%% PARAMETERS

% number of students
NS = 40;

% number of iterations
GEN = 1000;

% elite size
ELITE_SIZE = 3;

%%
funNum = 3;                % numer optymalizowanej funkcji
f = @(x)fun(x, funNum);    % function handle do wybranej funkcji

[bounds, D] = getGlobals('fun.m', funNum);
%%GENERATE sample X data
%										Dim(DImensions)
%  							[ X X X X X X X X X X X X X X X X X X]
%  NS(number of students)   [ X X X X X X X X X X X X X X X X X X]
%          					[ X X X X X X X X X X X X X X X X X X]
%							[ X X X X X X X X X X X X X X X X X X]
%
% X must be within bounds
grades = 10;
X = rand([NS, grades]);
% grades - liczba ocen ucznia
for i = 1 : GEN

	tmp = zeros(1,grades);
	for w = 1 : NS
		if( f(X(w,:)) < f(tmp) )
			tmp = X(w,:);
		else
			;
		end 
	end
	Teacher = Tg = tmp;
	
	%%%%%%%%%%%%%%%%%%%%%%%% Mg 
	tmp2 = zeros(1,grades);
	for w = 1 : NS
		tmp2 = X(w,:);
	end
	tmp2 = tmp2 ./ NS;
	Mg = tmp2;
	%%%%%%%%%%%%%%%%%%%%%%%%
	rand2 = (rand > 0.5) + 1;
	diffMean = rand(1, grades) .* (Tg -  rand2 * Mg);

	% Teacher phase
	X_tmp = zeros(NS, grades);
	for w = 1 : NS
		X_tmp(w,:) = X(w,:) + diffMean;
		if(f(X_tmp(w,:)) < f(X(w,:)))
			X(w,:) = X_tmp(w,:);
		else
			;
		end
	end
	%$End Teacher phase



	%Learner phase
	X_tmp2 = zeros(1, grades);
	%println("Learner phase");
	for l = 1: NS
		
		randomRowNumber = floor(rand() * NS);
		if(randomRowNumber == 0) 
			randomRowNumber +=1; 
		end


		if( f(X(l,:)) < f(X(randomRowNumber,:)) )
			X_tmp2(l,:) = X(l,:) + (rand > 0.5) * (X(l,:) - X(randomRowNumber,:));
		else
			X_tmp2(l,:) = X(l,:) + (rand > 0.5) * (X(randomRowNumber,:) - X(l,:));
		end

		if(f(X_tmp2(l,:)) < f(X(l,:)))
			X(l,:) = X_tmp2(l,:);
		else 
			;
		end
	end
	%%End Learner phase


	%Elitaryzm
	%for g = 1 : ELITE_SIZE
	%	ELITE = zeros([ELITE_SIZE, length(X)]);
	%
	%end
end
Teacher