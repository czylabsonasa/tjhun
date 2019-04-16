function circle(t, r) 
  n=max(3,Int(floor(0.6*(2*r*pi))))
  a=2*r*pi/n
  fok=360/n
  for i in 1:n
    forward(t,a)
    turn(t,fok)
  end
end
@svg begin
  t=Turtle()
  n=7
  fok=360/n
  for d in 1:n
    for r in 15:5:50
      circle(t,r)
    end    
    turn(t,fok)
  end
end 300 300 "./elso.svg"

