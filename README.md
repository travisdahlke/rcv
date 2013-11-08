Ranked Choice Voting Tabulator
=========

A basic implementation of a ranked choice voting tabulation. Inspired by the 2013 Minneapolis mayoral election, in which it took several days to tabulate the results by hand/using spreadsheets. As I heard about this process, I (and any other decent programmer) thought to myself: "self, you could write a program that could tabulate those results in a matter of seconds, and it would only take a few hours to write". So that's what I did. It may be a little rough around the edges, but I didn't spend that much time on it. More of a proof of concept.

To run
------
```
bundle install
rspec spec
```

Example results
---------------
```
Round 25
Cooper Okuneva: 21226 (26.53%)
Dorcas Kemmer I: 20095 (25.12%)
Ms. Julio Romaguera: 20080 (25.1%)
exhausted: 18599 (23.25%)
Round 26
Cooper Okuneva: 24261 (30.33%)
Dorcas Kemmer I: 23033 (28.79%)
exhausted: 32706 (40.88%)
Round 27
Cooper Okuneva: 27711 (34.64%)
exhausted: 52289 (65.36%)
Congratulations Cooper Okuneva!
```