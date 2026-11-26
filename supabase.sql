-- LiBRating: run this once in Supabase > SQL Editor > New query > Run

create table if not exists public.lib_state (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.lib_state enable row level security;

-- Anyone with the page can read and edit these three rows (no logins).
drop policy if exists "lib read" on public.lib_state;
drop policy if exists "lib insert" on public.lib_state;
drop policy if exists "lib update" on public.lib_state;
create policy "lib read" on public.lib_state for select to anon using (true);
create policy "lib insert" on public.lib_state for insert to anon
  with check (id in ('shared','alex','rose'));
create policy "lib update" on public.lib_state for update to anon
  using (id in ('shared','alex','rose')) with check (id in ('shared','alex','rose'));

-- Live updates: each of you sees the other's changes without refreshing.
do $$ begin
  alter publication supabase_realtime add table public.lib_state;
exception when duplicate_object then null; end $$;

-- Starting data: Season 11 couples, up to episode 4.
insert into public.lib_state (id, data) values
  ('shared', '{"ep": 4, "couples": [{"id": "sj", "a": "Sarah", "b": "John", "full": "Sarah Williams & John Shannon", "status": "on"}, {"id": "eb", "a": "Erika", "b": "Blake", "full": "Erika Ellis & Blake Carver", "status": "on"}, {"id": "ac", "a": "Aneha", "b": "Cam", "full": "Aneha Singh & Cam Halloran", "status": "on"}, {"id": "ww", "a": "Wilnie", "b": "Wilson", "full": "Wilnie Louis & Wilson", "status": "on"}, {"id": "mr", "a": "Michaella", "b": "Rob", "full": "Michaella & Rob Feeley", "status": "on"}, {"id": "js", "a": "Jax", "b": "Stew", "full": "Jax & Scott “Stew” Stewart", "status": "on"}], "hist": {"alex": {}, "rose": {}}}'::jsonb),
  ('alex',   '{"ranks": ["sj", "eb", "ac", "ww", "mr", "js"], "notes": {}}'::jsonb),
  ('rose',   '{"ranks": ["sj", "eb", "ac", "ww", "mr", "js"], "notes": {}}'::jsonb)
on conflict (id) do nothing;
