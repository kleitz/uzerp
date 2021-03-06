DROP VIEW tax_eu_saleslist;

CREATE OR REPLACE VIEW tax_eu_saleslist AS 
 SELECT si.id, si.invoice_number, si.sales_order_number, si.invoice_date, si.transaction_type, si.ext_reference, si.currency_id, si.rate, si.settlement_discount, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.gross_value * (-1)::numeric
            ELSE si.gross_value
        END AS gross_value, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.tax_value * (-1)::numeric
            ELSE si.tax_value
        END AS tax_value, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.net_value * (-1)::numeric
            ELSE si.net_value
        END AS net_value, si.twin_currency_id AS twin_currency, si.twin_rate, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.twin_gross_value * (-1)::numeric
            ELSE si.twin_gross_value
        END AS twin_gross_value, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.twin_tax_value * (-1)::numeric
            ELSE si.twin_tax_value
        END AS twin_tax_value, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.twin_net_value * (-1)::numeric
            ELSE si.twin_net_value
        END AS twin_net_value, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.base_gross_value * (-1)::numeric
            ELSE si.base_gross_value
        END AS base_gross_value, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.base_tax_value * (-1)::numeric
            ELSE si.base_tax_value
        END AS base_tax_value, 
        CASE
            WHEN si.transaction_type::text = 'C'::text THEN si.base_net_value * (-1)::numeric
            ELSE si.base_net_value
        END AS base_net_value, si.payment_term_id, si.due_date, si.status, si.description, si.tax_status_id, si.delivery_note, si.despatch_date, si.date_printed, si.print_count, si.usercompanyid, coy.name AS customer, cum.currency, twc.currency AS twin, syt.description AS payment_terms, ts.description AS tax_status, coy.vatnumber AS vat_number, cad.countrycode AS country
   FROM si_header si
   JOIN slmaster slm ON si.slmaster_id = slm.id
   JOIN company coy ON slm.company_id = coy.id
   JOIN companyaddress cad ON coy.party_id = cad.party_id
   LEFT JOIN sl_analysis sla ON slm.sl_analysis_id = sla.id
   JOIN cumaster cum ON si.currency_id = cum.id
   JOIN cumaster twc ON si.twin_currency_id = twc.id
   JOIN tax_statuses ts ON si.tax_status_id = ts.id
   JOIN syterms syt ON si.payment_term_id = syt.id
  WHERE ts.eu_tax = true;