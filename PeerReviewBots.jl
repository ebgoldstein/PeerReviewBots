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
Tmax=50000

#Rtype=0 for random reviews between -1 and 1
#Rtype=1 for 50-50 split of reviews either +1 -1
#Rtype=2 for random split of reviews either +1 -1
Rtype=1

#Retaliatory Fraction
Re=0.2

#scientists feeling toward each other. Adjacency matrix
# Row of A is the feelings of scientist (R) toward other scientists.
# Column index (C) of A is the feeling of Scientist (R) toward another (with index of C)
A=zeros(N,N,Tmax)

#vector of scientists behavior: signed (1) and blind reviews (0)
Si=shuffle([ones(round(Int,N*Sf));zeros(N-round(Int,N*Sf))])

#vector of scientists behavior : retaliate (1) and not-retaliate (0)
Retal=shuffle([ones(round(Int,N*Re));zeros(N-round(Int,N*Re))])

#Make a new vector; signed (1), signed+retal (2),unsigned (3) unsigned+retal (4)


Posreviewsperstep=zeros(10000)

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
    #assign the review score based on if retaliation occurs
    if Retal[IndexRev1] == 1  &  round(Int,A[IndexRev1,W[PW],t]) != 0 #retaliate
        ReviewRev1=sign(A[IndexRev1,W[PW],t])
    else    #don't retaliate
        ReviewRev1=Reviews[RW[PW]]
    end
    if Retal[IndexRev2] == 1  &  round(Int,A[IndexRev2,W[PW],t]) != 0 #retaliate
        ReviewRev2=sign(A[IndexRev2,W[PW],t])
    else    #don't retaliate
        ReviewRev2=Reviews[RW[PW]+1]
    end
    #determine if signed or unsigned
    SRev1=Si[IndexRev1]
    SRev2=Si[IndexRev2]
    #assign the blame/credit
    if SRev1==1 # signed R1
        A[W[PW],IndexRev1,t] += ReviewRev1
    else # blind R1
        RandomRev=R[rand(1:66)]
        A[W[PW],RandomRev,t] += ReviewRev1
    end
    if SRev2==1 # signed R2
        A[W[PW],IndexRev2,t] += ReviewRev2

    else # blind R1
        RandomRev=R[rand(1:66)]
        A[W[PW],RandomRev,t] += ReviewRev2
    end

    # #track the positive reviews for each time step
    # if ReviewRev1 == 1
    #     Posreviewsperstep[t] += 1
    # end
    # if ReviewRev2 == 1
    #     Posreviewsperstep[t] += 1
    # end

  end
  if t<Tmax
      A[:,:,t+1]=A[:,:,t]
  end
end


#figure(1)
#imshow(A[:,:,Tmax])
#colorbar()

# #histogram of final feelings for all
# figure(4)
# FF=Discfeeelings[:,1000]
# h = PyPlot.plt[:hist](FF,10)
# xlabel("Feelings")

#Calculate feelings others have toward the signed reviewers (input strength)
#first find all feelings others have toward the signed reviewers (columns)
SignedReviewerscol=A[:,findn(Si),:];
SignedReviewersrow=A[findn(Si),:,:];
#find ranges
RinSigned=maximum(SignedReviewerscol[:,:,Tmax],1)-minimum(SignedReviewerscol[:,:,Tmax],1);
RoutSigned=(maximum(SignedReviewersrow[:,:,Tmax],2)-minimum(SignedReviewersrow[:,:,Tmax],2))';

#Calculate feelings others have toward the blind reviewers (input strength)
#first find all feelings others have toward the blind reviewers (columns)
UnsignedReviewerscol=A[:,find(iszero,Si),:];
UnsignedReviewersrow=A[find(iszero,Si),:,:];
#find ranges
RinUnsigned=maximum(UnsignedReviewerscol[:,:,Tmax],1)-minimum(UnsignedReviewerscol[:,:,Tmax],1);
RoutUnsigned=(maximum(UnsignedReviewersrow[:,:,Tmax],2)-minimum(UnsignedReviewersrow[:,:,Tmax],2))';

figure()
plot(RinSigned',RoutSigned',"o")
hold
plot(RinUnsigned',RoutUnsigned',"o")
legend( ["Signed","Unsigned"])
xlabel("Rin")
ylabel("Rout")
