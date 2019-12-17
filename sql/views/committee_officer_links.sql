CREATE TABLE IF NOT EXISTS public.committee_officer_links (
    id integer primary key,
    officer_id integer,
    committee_id integer
);

LOCK TABLE public.committee_officer_links IN EXCLUSIVE MODE;

UPDATE public.committee_officer_links
SET
    officer_id = raw.cmteofficerlinks.officerid,
    committee_id = raw.cmteofficerlinks.committeeid
FROM raw.cmteofficerlinks
WHERE raw.cmteofficerlinks.id = public.committee_officer_links.id;

INSERT INTO public.committee_officer_links
SELECT 
    raw.cmteofficerlinks.id,
    raw.cmteofficerlinks.officerid,
    raw.cmteofficerlinks.committeeid
FROM raw.cmteofficerlinks
LEFT OUTER JOIN public.committee_officer_links ON (public.committee_officer_links.id = raw.cmteofficerlinks.id)
WHERE public.committee_officer_links.id IS NULL;


ALTER TABLE public.committee_officer_links DROP CONSTRAINT IF EXISTS committee_officer_committee;
ALTER TABLE public.committee_officer_links ADD CONSTRAINT committee_officer_committee FOREIGN KEY (committee_id) REFERENCES public.committees (id) NOT VALID;
ALTER TABLE public.committee_officer_links DROP CONSTRAINT IF EXISTS committee_officer_officer;
ALTER TABLE public.committee_officer_links ADD CONSTRAINT committee_officer_officer FOREIGN KEY (officer_id) REFERENCES public.officers (id) NOT VALID;