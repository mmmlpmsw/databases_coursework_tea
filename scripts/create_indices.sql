create index customer_fname_idx on customer using hash (fname);
create index customer_mname_idx on customer using hash (mname);
create index customer_lname_idx on customer using hash (lname);
create index customer_email_idx on customer using hash (email);
create index customer_phone_idx on customer using hash (phone);

create index delivery_truck_capacity_idx on delivery_truck using btree(capacity);

create index composition_item_amount_percent_idx on composition_item using btree(amount_percent);