#=
This is a code designed to do some random investigation
about the peer review system using an agent based model (bots)

Started by EBG in 08/2017; MIT license
=#
###############################################################

using PyPlot

# number of scientist
N=99

#scientsits feeling toward each other
Nf=zeros(N,N)

#number of paper writers per time step
P=33
#Fraction of scintists who sign their reviews
Sf=0.5
#max time step
Tmax=10

#vector of scientists behavior: signed (1) and blind reviews (0)
Si=shuffle([ones(round(Int,N*Sf));zeros(N-round(Int,N*Sf))])

for t=1:10
  RandP=randperm(N)
  W=RandP[1:P]
  R=RandP[P+1:N]
  Reviews=shuffle([ones(P);-ones(P)])
  for PW=1:33
    #assign the reviewers
    #determine if signed or unsigned
    #assign the blame/credit
  end
end

#plot feelings re: signed reviewers
#plot feelings re: blind reviewers
#plot aggregate peoples feelings aobut the dsicpline (summed)
