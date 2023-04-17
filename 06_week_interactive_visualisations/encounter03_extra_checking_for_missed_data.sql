-- 1
-- countries missed data: None

select sum(case  when "name" = '-9999' then 1 else 0 end) as missed_qty_name,
	   sum(case  when alpha2 = '-9999' then 1 else 0 end) as missed_qty_alpha2,
	   sum(case  when alpha3 = '-9999' then 1 else 0 end) as missed_qty_alpha3,
	   sum(case  when code = -9999 then 1 else 0 end) as missed_qty_code,
	   sum(case  when lat = -9999 then 1 else 0 end) as missed_qty_lat,
	   sum(case  when lon = -9999 then 1 else 0 end) as missed_qty_lon
	from countries;

/*
 * missed_qty_name	missedcountr_qty_alpha2	missed_qty_alpha3	missed_qty_code	missed_qty_lat	missed_qty_lon
 * 0				0					0					0				0				0
 */	 

-- 2
-- stations missed data: 5 records with missed 'hght' (all cn='NO')

select sum(case  when staid = -9999 then 1 else 0 end) as missed_qty_staid,
	   sum(case  when staname = '-9999' then 1 else 0 end) as missed_qty_staname,
	   sum(case  when cn = '-9999' then 1 else 0 end) as missed_qty_alpha3,
	   sum(case  when lat = '-9999' then 1 else 0 end) as missed_qty_lat,
	   sum(case  when lon = '-9999' then 1 else 0 end) as missed_qty_lon,
	   sum(case  when hght = -9999 then 1 else 0 end) as missed_qty_hght
	from stations s;

/*
 * missed_qty_staid	missed_qty_staname	missed_qty_alpha3	missed_qty_lat	missed_qty_lon	missed_qty_hght
 * 0				0					0					0				0				5
 */

select *
	from stations s 
	where hght = -9999;

/*
staid	staname			 cn	lat			lon			hght	coordinates
---------------------------------------------------------------------------------------------------
18543	SLEIPNER B   	 NO	+58:25:04	+001:43:04	-9999	(58.41777777777778,1.7177777777777778)
18711	GRANEFELTET      NO	+59:09:55	+002:29:13	-9999	(59.165277777777774,2.4869444444444446)
18762	FRIGG            NO	+59:53:08	+002:04:15	-9999	(59.885555555555555,2.0708333333333333)
18829	YME              NO	+57:49:08	+004:31:10	-9999	(57.818888888888885,4.519444444444445)
19066	HYWIND           NO	+59:16:59	+005:15:00	-9999	(59.283055555555556,5.25)
*/


-- 3
-- mean_temperature missed data: None

select sum(case  when staid = -9999 then 1 else 0 end) as missed_qty_staid,
	   --sum(case  when date = to_date('-9999') then 1 else 0 end) as missed_qty_staname,
	   sum(case  when tg = -9999 then 1 else 0 end) as missed_qty_alpha3
	from mean_temperature mt;

/*
 missed_qty_staid	missed_qty_alpha3
 0					0
 */

-- no test for 'date' as it should have given the following error at load:
-- SQL Error [22008]: ERROR: date out of range: "-9999"
select to_date('-9999', 'YYYY-MM-DD'); -- gives SQL Error [22008]: ERROR: date out of range: "-9999"
