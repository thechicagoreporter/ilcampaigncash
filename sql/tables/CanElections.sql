CREATE UNLOGGED TABLE IF NOT EXISTS raw.canelections (
    id integer primary key,
    candidateid integer,
    electiontype character varying,
    electionyear integer,
    incchallopen character varying,
    wonlost character varying,
    faircampaign boolean,
    limitsoff boolean,
    limitsoffreason character varying
);
