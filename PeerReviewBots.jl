#=
This is a code designed to do some random investigation
about the peer review system using an agent based model (bots)

Started by EBG in 08/2017; MIT license
=#
###############################################################

using PyPlot

# number of scientist
N=99

#number of paper writers per time step
P=33
#Fraction of scintists who sign their reviews
Sf=0.5
#max time step
Tmax=200

#scientists feeling toward each other
Nf=zeros(N,N,Tmax+1)

#vector of scientists behavior: signed (1) and blind reviews (0)
Si=shuffle([ones(round(Int,N*Sf));zeros(N-round(Int,N*Sf))])

for t=1:Tmax
  RandP=randperm(N)
  W=RandP[1:P]
  R=RandP[P+1:N]
  Reviews=shuffle([ones(P);-ones(P)])
  RW=1:2:66
  for PW=1:33
    RW[PW]
    #assign the reviewers
    IndexRev1=R[RW[PW]]
    IndexRev2=R[RW[PW]+1]
    #assign the review score
    ReviewRev1=Reviews[RW[PW]]
    ReviewRev2=Reviews[RW[PW]+1]
    #determine if signed or unsigned
    SRev1=Si[IndexRev1]
    SRev2=Si[IndexRev2]
    #assign the blame/credit
    if SRev1==1 # signed R1
        Nf[W[PW],IndexRev1,t] += ReviewRev1
    else # blind R1
        RandomRev=R[rand(1:66)]
        Nf[W[PW],RandomRev,t] += ReviewRev1
    end
    if SRev2==1 # signed R2
        Nf[W[PW],IndexRev2,t] += ReviewRev2

    else # blind R1
        RandomRev=R[rand(1:66)]
        Nf[W[PW],RandomRev,t] += ReviewRev2
    end

  end
  if t<Tmax
      Nf[:,:,t+1]=Nf[:,:,t]
  end
end
imshow(Nf[:,:,Tmax])
#plot feelings re: signed reviewers
#Nf[:,findn(Si)]
#plot feelings re: blind reviewers
#Nf[:,find(iszero,Si)]
#plot aggregate peoples feelings aobut the dsicpline (summed)
