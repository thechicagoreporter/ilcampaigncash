CREATE TABLE IF NOT EXISTS public.candidates (
    id integer primary key,
    last_name character varying,
    first_name character varying,
    address1 character varying,
    address2 character varying,
    city character varying,
    state character varying,
    zipcode character varying,
    office character varying,
    district_type character varying,
    district character varying,
    residence_county character varying,
    party_affiliation character varying,
    redaction_requested boolean
);

LOCK TABLE public.candidates IN EXCLUSIVE MODE;

UPDATE public.candidates
SET
    last_name = raw.candidates.lastname,
    first_name = raw.candidates.firstname,
    address1 = raw.candidates.address1,
    address2 = raw.candidates.address2,
    city = raw.candidates.city,
    state = raw.candidates.state,
    zipcode = raw.candidates.zip,
    office = raw.candidates.office,
    district_type = raw.candidates.districttype,
    residence_county = raw.candidates.residencecounty,
    party_affiliation = raw.candidates.partyaffiliation,
    redaction_requested = raw.candidates.redactionrequested
FROM raw.candidates
WHERE raw.candidates.id = public.candidates.id;

INSERT INTO public.candidates
SELECT 
    raw.candidates.id,
    raw.candidates.lastname,
    raw.candidates.firstname,
    raw.candidates.address1,
    raw.candidates.address2,
    raw.candidates.city,
    raw.candidates.state,
    raw.candidates.zip,
    raw.candidates.office,
    raw.candidates.districttype,
    raw.candidates.residencecounty,
    raw.candidates.partyaffiliation,
    raw.candidates.redactionrequested
FROM raw.candidates
LEFT OUTER JOIN public.candidates ON (public.candidates.id = raw.candidates.id)
WHERE public.candidates.id IS NULL;