CREATE TABLE auth (
    id text UNIQUE primary key,
    password text NOT NULL,
    salt bytea  NOT NULL,
    isAdmin boolean DEFAULT false NOT NULL
);

CREATE TABLE profiles (
    id serial UNIQUE primary key,
    user_id text UNIQUE REFERENCES auth (id) NOT NULL,
    icon_url text DEFAULT '' NOT NULL,
    username text DEFAULT 'default' NOT NULL,
    bio text DEFAULT '' NOT NULL
);

CREATE TABLE posts (
    id serial UNIQUE primary key,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    create_user text REFERENCES auth (id) NOT NULL,
    title text NOT NULL,
    main_text text NOT NULL
);

CREATE TABLE set_category (
    id serial UNIQUE primary key,
    post_id integer REFERENCES posts (id) NOT NULL,
    category_id integer REFERENCES category (id) NOT NULL,
    UNIQUE (post_id, category_id)
);

CREATE TABLE category (
    id serial UNIQUE primary key,
    title text UNIQUE NOT NULL,
    bio text
);

CREATE TABLE likes (
    id serial UNIQUE primary key,
    user text NOT NULL,
    like_posts text UNIQUE REFERENCES posts (id) NOT NULL,
)