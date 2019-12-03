CREATE TABLE public.investments AS
    SELECT
        id as id,
        committeeid as committee_id,
        fileddocid as filed_doc_id,
        description as description,
        purchasedate as purchase_date,
        purchaseshares as purchase_shares,
        purchaseprice as purchase_price,
        currentvalue as current_value,
        liquidvalue as liquid_value,
        lastonlyname as last_only_name,
        firstname as first_name,
        address1 as address1,
        address2 as address2,
        city as city,
        state as state,
        zip as zip,
        archived as archived,
        country as country
    FROM
        raw.investments
;
ALTER TABLE public.investments ADD PRIMARY KEY (id);