CREATE TABLE IF NOT EXISTS public.committee_candidate_links (
    id integer primary key,
    officer_id integer,
    committee_id integer
);

LOCK TABLE public.committee_candidate_links IN EXCLUSIVE MODE;

UPDATE public.committee_candidate_links
SET
    candidate_id = raw.cmteofficerlinks.candidateid,
    committee_id = raw.cmteofficerlinks.committeeid
FROM raw.cmteofficerlinks
WHERE raw.cmteofficerlinks.id = public.committee_candidate_links.id;

INSERT INTO public.committee_candidate_links
SELECT 
    raw.cmteofficerlinks.id,
    raw.cmteofficerlinks.candidateid,
    raw.cmteofficerlinks.committeeid
FROM raw.cmteofficerlinks
LEFT OUTER JOIN public.committee_candidate_links ON (public.committee_candidate_links.id = raw.cmteofficerlinks.id)
WHERE public.committee_candidate_links.id IS NULL;

-- ALTER TABLE DROP CONSTRAINT IF EXISTS committee_candidate_committee;
-- ALTER TABLE public.committee_candidate_links ADD CONSTRAINT committee_candidate_committee FOREIGN KEY (committee_id) REFERENCES public.committees (id) NOT VALID;
-- ALTER TABLE DROP CONSTRAINT IF EXISTS committee_candidate_candidate;
-- ALTER TABLE public.committee_candidate_links ADD CONSTRAINT committee_candidate_candidate FOREIGN KEY (candidate_id) REFERENCES public.candidates (id) NOT VALID;


-- CREATE TABLE public.committee_officer_links AS
--     SELECT
--         id as id,
--         officerid as officer_id,
--         committeeid as committee_id
--     FROM
--         raw.cmteofficerlinks
-- ;
-- ALTER TABLE public.committee_officer_links ADD PRIMARY KEY (id);

-- ALTER TABLE public.committee_officer_links ADD CONSTRAINT committee_officer_committee FOREIGN KEY (committee_id) REFERENCES public.committees (id) NOT VALID;
-- ALTER TABLE public.committee_officer_links ADD CONSTRAINT committee_officer_officer FOREIGN KEY (officer_id) REFERENCES public.officers (id) NOT VALID;