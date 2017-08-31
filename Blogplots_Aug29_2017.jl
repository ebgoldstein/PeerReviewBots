
#run the model
include("PeerReviewBots.jl")
using PyPlot
figure(2)
subplot(2,1,1)
hold
title("Signed")
#xlabel("Time")
ylabel("Feelings")
for k=1:50
    plot(SinSigned[k,:])
end
ylim([-3,3])

subplot(2,1,2)
hold
title("Unsigned")
xlabel("Time")
ylabel("Feelings")
for k=1:49
    plot(SinUnsigned[k,:])
end
ylim([-3,3])
