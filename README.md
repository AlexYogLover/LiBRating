# LiBRating

A two-person ranking board for *Love Is Blind* Season 11 (Boston), so that Alex and Rose can each rank the couples, see each other's rankings and leave notes on every couple.

Everything is in `index.html`: a single self-contained page with no build step.

## Features
- Pick who you are (Alex or Rose). Your device remembers the choice.
- Move couples up and down your own ranking and see the other person's ranking next to it.
- Each couple has a card showing both rankings, how far apart you are, and both of your notes.
- Mark couples as Together, Split or Hidden, or add a new couple.
- "Watched ep N" saves a snapshot of the rankings, and arrows then show how couples moved since the last episode.

## Saving
The page saves shared state through Claude's artifact runtime (`claude.use("artifact")`). When you open it anywhere else, for example straight from this repo or on GitHub Pages, it runs in preview mode and doesn't keep changes.
