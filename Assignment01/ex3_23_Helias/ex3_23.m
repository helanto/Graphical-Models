import brml.*

% values
r = 1; p = 2; s = 3;

T=30;

p1 = zeros(T,1);
p2 = zeros(T,1);
p1(1) = r;
p2(1) = s;

for t=2:T % number of games
     in1 = input(['Round ',num2str(t), '! Player 1:'],'s');
     in2 = input(['Round ',num2str(t), '! Player 2:'],'s');
      switch lower(in1)
          case 'r'
              p1(t) = r;
          case 'p'
              p1(t) = p;
          case 's'
              p1(t) = s;
      end;
      switch lower(in2)
          case 'r'
              p2(t) = r;
          case 'p'
              p2(t) = p;
          case 's'
              p2(t) = s;
      end;
      
      P=zeros(3,3,3);
      for i=2:t
          P(p1(i),p1(i-1),p2(i-1)) = P(p1(i),p1(i-1),p2(i-1)) +1;
      end;
      disp(P);
      P = condp(P);
      disp(P);
      disp(['Player 1 Next Move: Rock: ',num2str(P(r,p1(i),p2(i))),' Paper: ',num2str(P(p,p1(i),p2(i))),' Scissors: ',num2str(P(s,p1(i),p2(i)))]);
end;