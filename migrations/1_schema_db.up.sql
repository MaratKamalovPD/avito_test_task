ALTER SEQUENCE IF EXISTS public.user_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.house_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.flat_id_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS public.developer_id_seq RESTART WITH 1;

CREATE TYPE user_type AS ENUM ('client', 'moderator');
CREATE TYPE moderations_status AS ENUM ('created', 'approved', 'declined', 'on moderation');

CREATE TABLE IF NOT EXISTS public.developer
(
    id                    BIGINT                                         GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS public."user"
(
    id              BIGINT                                                       GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email           TEXT UNIQUE                                                  NOT NULL CHECK (email <> '')
        CONSTRAINT max_len_email CHECK (LENGTH(email) <= 256),
    password_hash   TEXT                                                         NOT NULL CHECK (password_hash <> '')
        CONSTRAINT max_len_password_hash CHECK (LENGTH(password_hash) <= 256),
    user_type       user_type                                                    NOT NULL
);

CREATE TABLE IF NOT EXISTS public.house
(
    id                    BIGINT                                         GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    creator_id            BIGINT                                         NOT NULL REFERENCES public."user" (id) ON DELETE CASCADE,
    developer_id          BIGINT                                         NOT NULL REFERENCES public.developer (id) ON DELETE CASCADE,
    "address"             TEXT                                           NOT NULL CHECK ("address" <> ''),
    year_of_build         SMALLINT                                       NOT NULL
        CONSTRAINT check_year_not_future CHECK (year_of_build <= EXTRACT(YEAR FROM CURRENT_DATE)),
    created_time          TIMESTAMP DEFAULT NOW()                        NOT NULL,  
    last_flat_added_time  TIMESTAMP      
);

CREATE TABLE IF NOT EXISTS public.flat
(
    id                    BIGINT                                         GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    creator_id            BIGINT                                         NOT NULL REFERENCES public."user" (id) ON DELETE CASCADE,
    house_id              BIGINT                                         NOT NULL REFERENCES public.house (id) ON DELETE CASCADE,
    "number"              SMALLINT                                       NOT NULL
        CONSTRAINT number_not_negative CHECK ("number" >= 0),
    price                 BIGINT                                         NOT NULL
        CONSTRAINT price_not_negative CHECK (price >= 0),      
    room_count            SMALLINT                                       NOT NULL
        CONSTRAINT room_count_not_negative CHECK (room_count >= 0),
    moderations_status moderations_status DEFAULT 'created'              NOT NULL   

);

