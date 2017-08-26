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
#Fraction of scientists who sign their reviews
Sf=0.5
#max time step
Tmax=10000

#Rtype=0 for random reviews between -1 and 1
#Rtype=1 for 50-50 split of reviews either +1 -1
#Rtype=2 for random split of reviews either +1 -1
Rtype=1


#scientists feeling toward each other.
# Row of Nf is the feelings of scientist (R) toward other scientists.
# Column index (C) of Nf is the feeling of Scientist (R) toward another (with index of C)
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

#plot feelings others have toward the signed reviewers
#first find all feelings others have toward the signed reviewers (columns)
SignedReviewers=Nf[:,findn(Si),:];
#Sum down the columns and then squeeze the other dimension
Sfeelings=squeeze(mean(SignedReviewers,1),1);
figure(1)
subplot(2,1,1)
hold
title("Signed")
#xlabel("Time")
ylabel("Feelings")
for k=1:50
    plot(Sfeelings[k,:])
end
ylim([-3,3])
#plot feelings others have toward the blind reviewers
#first find all feelings others have toward the blind reviewers (columns)
BlindReviewers=Nf[:,find(iszero,Si),:];
#Sum down the columns and then squeeze the other dimension
Bfeelings=squeeze(mean(BlindReviewers,1),1);
subplot(2,1,2)
hold
title("Unsigned")
xlabel("Time")
ylabel("Feelings")
for k=1:49
    plot(Bfeelings[k,:])
end
ylim([-3,3])

#plot aggregate peoples feelings about the discpline (summed over all reviewers)
#Sum the rows
Discfeeelings=squeeze(mean(Nf,2),2)
figure(3)
hold
title("Discipline")
xlabel("Time")
ylabel("Feelings")
for k=1:N
    plot(Discfeeelings[k,:])
end

#histogram of final feelings for all
figure(4)
FF=Discfeeelings[:,1000]
h = PyPlot.plt[:hist](FF,10)
xlabel("Feelings")
