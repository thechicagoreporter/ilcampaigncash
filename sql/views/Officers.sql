CREATE TABLE IF NOT EXISTS public.officers (like raw.officers including all);

LOCK TABLE public.officers IN EXCLUSIVE MODE;

UPDATE public.officers
SET
    lastname = raw.officers.lastname,
    firstname = raw.officers.firstname,
    address1 = raw.officers.address1,
    address2 = raw.officers.address2,
    state = raw.officers.state,
    zip = raw.officers.zip,
    title = raw.officers.title,
    phone = raw.officers.phone,
    redactionrequested = raw.officers.redactionrequested
FROM raw.officers
WHERE raw.officers.id = public.officers.id;

INSERT INTO public.officers
SELECT 
    raw.officers.id,
    raw.officers.lastname,
    raw.officers.firstname,
    raw.officers.address1,
    raw.officers.address2,
    raw.officers.state,
    raw.officers.zip,
    raw.officers.title,
    raw.officers.phone,
    raw.officers.redactionrequested
FROM raw.officers
LEFT OUTER JOIN public.officers ON (public.officers.id = raw.officers.id)
WHERE public.officers.id IS NULL;