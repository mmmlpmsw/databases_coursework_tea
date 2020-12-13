### Table: customer
## Without indices:
```sql
-- 34680 items in table
explain analyze select * from customer
    where fname = 'Anatoliy' and mname = 'Borisovich'; -- 60 ms
```
## Creating indices:
```sql
create index customer_fname_idx on customer using hash (fname);
create index customer_mname_idx on customer using hash (mname);
create index customer_lname_idx on customer using hash (lname);
create index customer_email_idx on customer using hash (email);
create index customer_phone_idx on customer using hash (phone);
```
## With indices:
```sql
explain analyze select * from customer
    where fname = 'Anatoliy' and mname = 'Borisovich'; -- 2 ms
```

### Table: delivery_truck
## Without indices:
```sql
-- tested with 40000 trucks
explain analyze select * from delivery_truck where capacity < 10; -- 50 ms
```
## Creating indices:
```sql
create index delivery_truck_capacity_idx on delivery_truck using btree(capacity);
```
## With indices:
```sql
explain analyze select * from delivery_truck where capacity < 10; -- 0.1 ms
```

### Table: composition_item
## Without indices:
```sql
-- tested with 12175 items
explain analyze select composition_id from composition_item where amount_percent > 0.5; -- 16 ms
```
## Creating indices
```sql
create index composition_item_amount_percent_idx on composition_item using btree(amount_percent);
```
## With indices:
```sql
explain analyze select composition_id from composition_item where amount_percent > 0.5; -- 0.3 ms
```