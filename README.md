# LiBRating

A two-person ranking board for *Love Is Blind* Season 11 (Boston), so that Alex and Rose can each rank the couples, see each other's rankings and leave notes on every couple. It saves to Supabase, and each of you sees the other's changes live.

## Setup (one time, about 5 minutes)
1. Create a free project at [supabase.com](https://supabase.com).
2. In the project, go to **SQL Editor → New query**, paste in all of `supabase.sql` and click **Run**.
3. Go to **Project Settings → API** and copy the **Project URL** and the **anon public** key.
4. In `index.html`, paste them into `SUPABASE_URL` and `SUPABASE_ANON_KEY` near the top of the script, then commit.
5. To host the page, go to this repo's **Settings → Pages**, choose **Deploy from a branch**, pick `main` and `/ (root)`, and save. The site will then be live at `https://alexyoglover.github.io/librating/`.

The anon key is safe to publish. It only permits what the policies in `supabase.sql` allow: reading and editing the three rows this app uses. Anyone who has the page link can edit the rankings, which is fine for a sofa game.

## Features
- Pick who you are (Alex or Rose). Your device remembers the choice.
- Move couples up and down your own ranking and see the other person's ranking next to it.
- Each couple has a card showing both rankings, how far apart you are, and both of your notes.
- Mark couples as Together, Split or Hidden, or add a new couple.
- "Watched ep N" saves a snapshot of the rankings, and arrows then show how couples moved since the last episode.

## How data is stored
There is one table, `lib_state`, with three rows: `shared` (the episode, the couples and the episode snapshots), `alex` (Alex's ranking and notes) and `rose` (Rose's ranking and notes). Each person only writes to their own row, so you can't overwrite each other's rankings.
