function rács(kr, kc, br, bc)
  belso = "|"*repeat(repeat(" ",bc)*"|",kc)
  belso = belso*repeat( "\n"*belso, br-1)
  zar = "+"*repeat(repeat("-",bc)*"+",kc)
  zar*"\n"*repeat(belso*"\n"*zar*"\n",kr)
end
