import brml.*

joint = zeros(3,3,3);

% values
r = 1; p = 2; s = 3;

T=23;

p1 = [r p r p r s p r s p p r r r r p r s r p p s r];
p2 = [s p r s p s p s r p s r p p r r s p r s s p r];

for t=2:T % number of games
      P=zeros(3,3,3);
      for i=2:t
          P(p1(i),p2(i-1),p1(i-1)) = P(p1(i),p2(i-1),p1(i-1)) +1;
      end;
      P = condp(P);
      joint = P;
      disp(['Player 1 Next Move: Rock: ',num2str(P(r,p1(i),p2(i))),' Paper: ',num2str(P(p,p1(i),p2(i))),' Scissors: ',num2str(P(s,p1(i),p2(i)))]);
end;