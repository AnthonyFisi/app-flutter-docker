-- We put things inside the basic_auth schema to hide
-- them from public view. Certain public procs/views will
-- refer to helpers and tables inside.
create schema if not exists basic_auth;

create table if not exists
basic_auth.users (
  email text primary key check ( email ~* '^.+@.+\..+$' ),
  pass  text not null check (length(pass) < 512),
  role  name not null check (length(role) < 512)
);


create or replace function
basic_auth.check_role_exists() returns trigger as $$
begin
  if not exists (select 1 from pg_roles as r where r.rolname = new.role) then
  raise foreign_key_violation using message =
    'unknown database role: ' || new.role;
  return null;
  end if;
  return new;
end
$$ language plpgsql;

drop trigger if exists ensure_user_role_exists on basic_auth.users;
create constraint trigger ensure_user_role_exists
  after insert or update on basic_auth.users
  for each row
  execute procedure basic_auth.check_role_exists();


create extension if not exists pgcrypto;

create or replace function
basic_auth.encrypt_pass() returns trigger as $$
begin
  if tg_op = 'INSERT' or new.pass <> old.pass then
  new.pass = crypt(new.pass, gen_salt('bf'));
  end if;
  return new;
end
$$ language plpgsql;

drop trigger if exists encrypt_pass on basic_auth.users;
create trigger encrypt_pass
  before insert or update on basic_auth.users
  for each row
  execute procedure basic_auth.encrypt_pass();


  create or replace function
basic_auth.user_role(email text, pass text) returns name
  language plpgsql
  as $$
begin
  return (
  select role from basic_auth.users
   where users.email = user_role.email
  and users.pass = crypt(user_role.pass, users.pass)
  );
end;
$$;


create extension if not exists pg_ed25519;

create extension if not exists pgjwt_ed25519;

-- add type
CREATE TYPE basic_auth.jwt_token AS (
  token text
);

-- login should be on your exposed schema
create or replace function
basic_auth.login(email text, pass text) returns basic_auth.jwt_token as $$
declare
  _role name;
  result basic_auth.jwt_token;
begin
  -- check email and password
  select basic_auth.user_role(email, pass) into _role;
  if _role is null then
  raise invalid_password using message = 'invalid user or password';
  end if;

  select pgjwt_ed25519.sign(
    --put public key and private key in this order
    row_to_json(r), decode('NZV4l8hck3iUqInENyI+nn5vkW7rqzQg0uiuuZkPnHE=','base64'),decode('eT7qaT8vkIgCl6/9EmEDYYEgxA0oOgHc0P6UYzcQN28=','base64')
  ) as token
  from (
    select _role as role, login.email as email,
      extract(epoch from now())::integer + 60*60 as exp
  ) r
  into result;
  return result;
end;
$$ language plpgsql security definer;


-- the names "anon" and "authenticator" are configurable and not
-- sacred, we simply choose them for clarity
create role anon noinherit;

create role authenticator noinherit login password 'mysecretpassword';

grant anon to authenticator;

grant execute on function basic_auth.login(text,text) to anon;

grant usage on schema basic_auth to anon;


-- data
INSERT INTO basic_auth.users (email,pass,role) values ('jhon@gmail.com','password','anon');