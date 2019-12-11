CREATE TABLE IF NOT EXISTS public.candidate_elections (
    id integer primary key,
    candidate_id integer,
    election_type character varying,
    election_year integer,
    inc_chall_open character varying,
    won_lost character varying,
    fair_campaign boolean,
    limits_off boolean,
    limits_off_reason character varying
);

LOCK TABLE public.candidate_elections IN EXCLUSIVE MODE;

UPDATE public.candidate_elections
SET
    candidate_id = raw.canelections.candidateid,
    election_type = raw.canelections.electiontype,
    election_year = raw.canelections.electionyear,
    inc_chall_open = raw.canelections.incchallopen,
    won_lost = raw.canelections.wonlost,
    fair_campaign = raw.canelections.faircampaign,
    limits_off = raw.canelections.limitsoff,
    limits_off_reason = raw.canelections.limitsoffreason
FROM raw.canelections
WHERE raw.canelections.id = public.candidate_elections.id;

INSERT INTO public.candidate_elections
SELECT 
    raw.canelections.id,
    raw.canelections.candidateid,
    raw.canelections.electiontype,
    raw.canelections.electionyear,
    raw.canelections.incchallopen,
    raw.canelections.wonlost,
    raw.canelections.faircampaign,
    raw.canelections.limitsoff,
    raw.canelections.limitsoffreason
FROM raw.canelections
LEFT OUTER JOIN public.candidate_elections ON (public.candidate_elections.id = raw.canelections.id)
WHERE public.candidate_elections.id IS NULL;

ALTER TABLE public.candidate_elections DROP CONSTRAINT IF EXISTS candidate_election;
ALTER TABLE public.candidate_elections ADD CONSTRAINT candidate_election FOREIGN KEY (candidate_id) REFERENCES public.candidates (id) NOT VALID;

-- CREATE TABLE public.candidate_elections AS
--     SELECT
--         id as id,
--         candidateid as candidate_id,
--         electiontype as election_type,
--         electionyear as election_year,
--         incchallopen as inc_chall_open,
--         wonlost as won_lost,
--         faircampaign as fair_campaign,
--         limitsoff as limits_off,
--         limitsoffreason as limits_off_reason
--     FROM
--         raw.canelections
-- ;

-- ALTER TABLE public.candidate_elections ADD PRIMARY KEY (id);
