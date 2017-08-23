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
Tmax=1000

#Rtype =0 for random reviews between -1 and 1
#Rtype=1 for 50-50 split of reviews either +1 -1
#Rtype=2 for random split of reviews either +1 -1
Rtype=1


#scientists feeling toward each other
Nf=zeros(N,N,Tmax)

#vector of scientists behavior: signed (1) and blind reviews (0)
Si=shuffle([ones(round(Int,N*Sf));zeros(N-round(Int,N*Sf))])

for t=1:Tmax
  RandP=randperm(N)
  W=RandP[1:P]
  R=RandP[P+1:N]
  if Rtype==0
      Reviews=2rand((2*P))-1
  elseif Rtype==1
      Reviews=shuffle([ones(P);-ones(P)])
  elseif Rtype==2
      Reviews=rand(-1:1,(2*P))
  end

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
#imshow(Nf[:,:,Tmax])

#plot feelings others have re: signed reviewers
SignedReviewers=Nf[:,findn(Si),:];
Sfeelings=squeeze(sum(SignedReviewers,1),1);
figure(1)
hold
title("Signed")
for k=1:50
    plot(Sfeelings[k,:])
end

#plot feelings others have re: blind reviewers
BlindReviewers=Nf[:,find(iszero,Si),:];
Bfeelings=squeeze(sum(BlindReviewers,1),1);
figure(2)
hold
title("Blind")
for k=1:49
    plot(Bfeelings[k,:])
end

#plot aggregate peoples feelings about the discpline (summed)
Discfeeelings=squeeze(sum(Nf,2),2)
figure(3)
hold
title("Discipline")
for k=1:N
    plot(Discfeeelings[k,:])
end

#histogram of final feelings for all
figure(4)
FF=Discfeeelings[:,1000]
h = PyPlot.plt[:hist](FF,10)
