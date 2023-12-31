%Binomial lattice model for European and 
%American call/put options
S0=input('S0= ');
u=input('u= ');
d=input('d= ');
T=input('T= ');
k=input('k= ');
r=input('r= ');
R=1+r;
p=(R-d)/(u-d);

BinomialLattice= zeros(T,T);
r=0; %power of d in binomial lattice
for i= T:-1:1 %row generation
    r=1;
    %i+j = T+1 => j=T+1-i for lower triangle column generation
    for j= T+1-i:T
        BinomialLattice(i,j)=(S0*u^(T-i))*d^(r-1);
        r=r+1;
    end
end
fprintf('Binomial lattice for stock movement');
disp(BinomialLattice);

%Ask for American or European call/put option
fprintf(['\n 1: for American options' ...
    '\n 2: for European options \n']);
choice_A_E=input('Your choices ');
switch choice_A_E
    case 1
        fprintf('\n 1: for call option \n 2: for put option \n');
        choice_p_c=input('Your choice');
        c0= zeros(T,T);
        c0(:,T)=max(BinomialLattice(:,T)-k,0);
        if choice_p_c==1
            for j= T-1:-1:1 %j=column traversal
                for i=T:-1:2 % i= row traversal
                    if i+j>=T+1 %lower triangle
                        c0(i,j)= max(BinomialLattice(i,j)-k, (1/R)*(p*c0(i-1,j+1)+(1-p)*c0(i,j+1)));
                    end
                end
            end
            disp('American call option Binomial Lattice');
            disp(c0);
        else
            p0= zeros(T,T);
            p0(:,T)=max(k- BinomialLattice(:,T),0);
            for j= T-1:-1:1 % column
                for i= T:-1:2 % row
                    if i+j>=T+1
                        p0(i,j)= max(k-BinomialLattice(i,j), (1/R)*(p*p0(i,j+1)+(1-p)*p0(i-1,j+1)));
                    end
                end
            end
            disp('American put option Binomial Lattice');
            disp(p0);
        end
    case 2
        fprintf('\n 1: for call option \n 2: for put option \n');
        choice_p_c=input('Your choice');
        c0= zeros(T,T);
        c0(:,T)=max(BinomialLattice(:,T)-k,0);
        if choice_p_c==1
            for j= T-1:-1:1 %j=column traversal
                for i=T:-1:2 % i= row traversal
                    if i+j>=T+1 %lower triangle
                        c0(i,j)= (1/R)*(p*c0(i-1,j+1)+(1-p)*c0(i,j+1));
                    end
                end
            end
            disp('European call option Binomial Lattice');
            disp(c0);
        else
            p0= zeros(T,T);
            p0(:,T)=max(k- BinomialLattice(:,T),0);
            for j= T-1:-1:1 % column
                for i= T:-1:2 % row
                    if i+j>=T+1
                        p0(i,j)= (1/R)*(p*p0(i,j+1)+(1-p)*p0(i-1,j+1));
                    end
                end
            end
            disp('European put option Binomial Lattice');
            disp(p0);
        end
    otherwise
        disp('Unknown choice');
end


