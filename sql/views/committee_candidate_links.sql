CREATE TABLE IF NOT EXISTS public.committee_candidate_links (
    id integer primary key,
    candidate_id integer,
    committee_id integer
);

LOCK TABLE public.committee_candidate_links IN EXCLUSIVE MODE;

UPDATE public.committee_candidate_links
SET
    candidate_id = raw.cmtecandidatelinks.candidateid,
    committee_id = raw.cmtecandidatelinks.committeeid
FROM raw.cmtecandidatelinks
WHERE raw.cmtecandidatelinks.id = public.committee_candidate_links.id;

INSERT INTO public.committee_candidate_links
SELECT 
    raw.cmtecandidatelinks.id,
    raw.cmtecandidatelinks.candidateid,
    raw.cmtecandidatelinks.committeeid
FROM raw.cmtecandidatelinks
LEFT OUTER JOIN public.committee_candidate_links ON (public.committee_candidate_links.id = raw.cmtecandidatelinks.id)
WHERE public.committee_candidate_links.id IS NULL;

ALTER TABLE public.committee_candidate_links DROP CONSTRAINT IF EXISTS committee_candidate_committee;
ALTER TABLE public.committee_candidate_links ADD CONSTRAINT committee_candidate_committee FOREIGN KEY (committee_id) REFERENCES public.committees (id) NOT VALID;
ALTER TABLE public.committee_candidate_links DROP CONSTRAINT IF EXISTS committee_candidate_candidate;
ALTER TABLE public.committee_candidate_links ADD CONSTRAINT committee_candidate_candidate FOREIGN KEY (candidate_id) REFERENCES public.candidates (id) NOT VALID;