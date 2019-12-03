CREATE TABLE public.officers AS
    SELECT
        id as id,
        lastname as last_name,
        firstname as first_name,
        address1 as address1,
        address2 as address2,
        city as city,
        state as state,
        zip as zip,
        title as title,
        phone as phone,
        redactionrequested as redaction_requested
    FROM
        raw.officers
;
ALTER TABLE public.officers ADD PRIMARY KEY (id);