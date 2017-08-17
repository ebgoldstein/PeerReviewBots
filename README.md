# PeerReviewBots
the idea is:

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
