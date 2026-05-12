create extension if not exists pgcrypto;

create table if not exists sessions (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  status text not null default 'active' check (status in ('active', 'closed')),
  intake_open boolean not null default true,
  user_event_limit integer not null default 20,
  user_event_count integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists incoming_events (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references sessions(id) on delete cascade,
  source_type text not null check (source_type in ('system', 'user')),
  event_code text not null,
  event_label text not null,
  channel text not null,
  amount numeric not null,
  processing_status text not null default 'queued' check (processing_status in ('queued', 'processing', 'done')),
  device_token text,
  created_at timestamptz not null default now()
);

create table if not exists processed_operations (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references sessions(id) on delete cascade,
  incoming_event_id uuid references incoming_events(id) on delete set null,
  operation_code text not null,
  operation_label text not null,
  type text not null,
  channel text not null,
  gross_amount numeric not null,
  fee_amount numeric not null default 0,
  refund_amount numeric not null default 0,
  final_status text not null,
  issue_type text not null,
  prevented_loss numeric not null default 0,
  is_user_event boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists exceptions (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references sessions(id) on delete cascade,
  operation_id uuid,
  severity text not null check (severity in ('low', 'medium', 'high')),
  title text not null,
  description text not null,
  status text not null default 'open' check (status in ('open', 'reviewed')),
  is_user_event boolean not null default false,
  created_at timestamptz not null default now()
);

alter publication supabase_realtime add table sessions;
alter publication supabase_realtime add table incoming_events;
alter publication supabase_realtime add table processed_operations;
alter publication supabase_realtime add table exceptions;

alter table sessions enable row level security;
alter table incoming_events enable row level security;
alter table processed_operations enable row level security;
alter table exceptions enable row level security;

create policy "anon can read sessions" on sessions for select using (true);
create policy "anon can update sessions" on sessions for update using (true) with check (true);
create policy "anon can insert sessions" on sessions for insert with check (true);

create policy "anon can read incoming" on incoming_events for select using (true);
create policy "anon can insert incoming" on incoming_events for insert with check (true);
create policy "anon can update incoming" on incoming_events for update using (true) with check (true);
create policy "anon can delete incoming" on incoming_events for delete using (true);

create policy "anon can read operations" on processed_operations for select using (true);
create policy "anon can insert operations" on processed_operations for insert with check (true);
create policy "anon can delete operations" on processed_operations for delete using (true);

create policy "anon can read exceptions" on exceptions for select using (true);
create policy "anon can insert exceptions" on exceptions for insert with check (true);
create policy "anon can delete exceptions" on exceptions for delete using (true);
