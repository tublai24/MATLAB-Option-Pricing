%Black Scholes formula for dividend and non-dividend paying underlying 

s0=input('Enter the stock price at t=0: S0= ');
k=input("Enter the strike price for underlying asset : k= ");
r=input('Enter the risk free rate of interest: r= ');
T=input('Enter the expiry time: T= ');
sigma=input('Enter the volatility for underlying assets: sigma= ');

Ch=1;
while Ch==1
    fprintf('\n 1: for dividend \n 2: non dividend \n');
    choice=input('Your choice');
    switch choice 
        case 1
            disp('Data for dividend paying stock');
            dtime=input('Enter the time in array');
            damount=input('Enter the dividend amount in array');
            rd=-r*dtime;
            erd=exp(rd);
            ds=damount.*erd;
            sa= s0 - sum(sum(ds));
            lsa=(log(sa/k)+ (r+ (sigma*sigma)/2)*T);
            d1= lsa/(sigma*sqrt(T));
            d2= d1 - sigma*sqrt(T);

            fprintf('\n 1: call option \n 2: put option \n');
            ch=input('Your choice');
            if ch==1
                c0=sa*normcdf(d1) - k*exp(-r*T)*normcdf(d2);
                fprintf('Value of call option = %4.4f\n',c0);
            end
            if ch==2
                p0=k*exp(-r*T)*normcdf(-d2) - sa*normcdf(-d1);
                fprintf('Value of put option = %4.4f\n',p0);
            end
            if ch ~=1 && ch~=2
                disp('Invalid choice')
            end
        case 2
            lso= (log(s0/k)+ (r+(sigma*sigma)/2)*T);
            d1= lso/(sigma*sqrt(T));
            d2= d1- sigma*sqrt(T);
            fprintf('\n 1: call option \n 2: put option \n');
            ch=input('Your choice');
            if ch==1
                c0=s0*normcdf(d1) - k*exp(-r*T)*normcdf(d2);
                fprintf('Value of call option = %4.4f\n',c0);
            end
            if ch==2
                p0=k*exp(-r*T)*normcdf(-d2) - s0*normcdf(-d1);
                fprintf('Value of put option = %4.4f\n',p0);
            end
            if ch ~=1 && ch~=2
                disp('Invalid choice')
            end
    end
    CH=input('1- continue option pricing else any other key');
end

