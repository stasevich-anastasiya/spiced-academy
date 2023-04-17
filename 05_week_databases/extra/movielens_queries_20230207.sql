-- films with maximum number of ratings ever (complete dataset)

select m.movie_id
     , m.title
     , count(r.movie_id) as qty
	from public.movies m
		inner join public.ratings r
			on m.movie_id = r.movie_id
	--where m.movie_id = 8620;
	group by m.movie_id, m.title
	order by qty desc;

-- film with the highest average rating ever (complete daataset)

select m.movie_id
     , m.title
     , avg(r.rating) as avg_rating
     , max(to_timestamp(r.rating_timestamp)) as latesd_review_date
	from public.movies m
		inner join public.ratings r
			on m.movie_id = r.movie_id
	--where m.movie_id = 8620;
	group by m.movie_id, m.title
	order by avg_rating desc, latesd_review_date desc;

	
