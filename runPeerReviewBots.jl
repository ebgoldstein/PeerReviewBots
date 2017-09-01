#build the functions:
include("PeerReviewBots.jl")

#Run the code:
N=99 #is the number of scientist; 99
P=33 #is the number of paper writers per time step; 33
Sf=0.5 #is Fraction of scientists who sign their reviews; 0.5
Tmax=1000 #is max time step; 10000
Re=0.3 #is Retaliatory Fraction; 0.3
Rtype=1 #for 50-50 split of reviews either +1 -1


(A,RCategories)=PeerReviewBots(N,P,Sf,Tmax,Re,Rtype)

#The key for RCategories:
#   signed (1),
#   signed+retal (2),
#   unsigned (0)
#   unsigned+retal (3)

Runsigned=WeightR(A,RCategories,Tmax,0)
Rsigned=WeightR(A,RCategories,Tmax,1)
RsignedRetal=WeightR(A,RCategories,Tmax,2)
RunsignedRetal=WeightR(A,RCategories,Tmax,3)

figure()
plot(Runsigned[1]',Runsigned[2]',"o",color="darkorange")
hold
plot(Rsigned[1]',Rsigned[2]',"o",color="steelblue")
plot(RsignedRetal[1]',RsignedRetal[2]',"o", mfc="none",color="steelblue")
plot(RunsignedRetal[1]',RunsignedRetal[2]',"o", mfc="none",color="darkorange")
legend( ["Unsigned","Signed","Signed+R","Unsigned+R"])
xlabel("Rin")
ylabel("Rout")
