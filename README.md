## PeerReviewBots — an agent based model of Peer Review

This model is outlined in a series of blog posts:

the motivation for the model was a series of papers from 2003:
https://ebgoldstein.wordpress.com/2017/08/15/the-agu-eos-anonymous-peer-review-debate-of-2003-2004/

And the rules for the model were outlined here:
https://ebgoldstein.wordpress.com/2017/08/22/rules-for-a-agent-based-peer-review-model/

For reference, the general rules are:
Each agent (scientist) is set to either sign or blind their reviews.

For each time step

  Step 1:
    -randomly pick the number of scientists ('P') out of 'N' total scientists
    who will publish a single paper


  Step 2: randomly assign 'R' reviewers for each paper.
    -Nobody can review their own paper
    -Writing Scientists can review (not implemented)
    -Scientist can do multiple reviews (not implemented)

  Step 3:
    -Each reviewer gives a random review score (good or bad)

  Step 4:
    -Reviews are returned to each writer and writers 'mood' changes.
      - signed (+) reviews result in (+) feelings toward the
      reviewer
      - signed (-) reviews result in (-) feelings toward the
      reviewer
      - unsigned (+) reviews result in (+) feelings toward a random scientist (currently only a random reviewer)
      - unsigned (-) reviews result in (-) feelings toward a random scientist (currently only a random reviewer)

  end time step
