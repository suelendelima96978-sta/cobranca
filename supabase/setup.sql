-- Banco único compartilhado do Acervo.
create table if not exists public.acervo_shared_state (
  id smallint primary key check (id = 1),
  payload jsonb not null,
  revision bigint not null default 0,
  updated_at timestamptz not null default now()
);
alter table public.acervo_shared_state enable row level security;
revoke all on table public.acervo_shared_state from anon, authenticated;
grant select, update on table public.acervo_shared_state to service_role;
insert into public.acervo_shared_state (id, payload, revision)
values (1, '{"debtors":[],"creditors":[],"cases":[],"agreements":[],"installments":[],"events":[]}'::jsonb, 0)
on conflict (id) do nothing;