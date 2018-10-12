-- Run this on your database after restoring the DVD retail example database

create or replace function list_films()
    returns character varying
    language 'plpgsql'
as $BODY$
declare lvJSON character varying;
begin
	select array_to_json(array_agg(row_to_json(categories)), true)
	into lvJSON
	from (
		select
			name as "Name",
			(select array_to_json(array_agg(row_to_json(films)))
			from (
				select
					f.film_id as "FilmId",
					f.title as "Title"
				from film as f
				join film_category as fc on fc.film_id = f.film_id and fc.category_id = c.category_id
				order by title
			) as films) as "Films"
		from category as c
		order by name
	) as categories;

	if (coalesce(lvJSON, '') = '') then
		lvJSON := '[]';
	end if;

	return lvJSON;
end;
$BODY$;

create or replace function get_film(p_id integer)
    returns character varying
    language 'plpgsql'
as $BODY$
declare lvJSON character varying;
begin
	select
		json_build_object(
			'FilmId', f.film_id,
			'Title', title,
			'Description', description,
			'ReleaseYear', release_year,
			'Language', (
				select json_build_object('LanguageId', l.language_id, 'Name', trim(l.name))
				from language as l
				where l.language_id = f.language_id
			),
			'RentalDuration', rental_duration,
			'RentalRate', rental_rate,
			'Length', length,
			'ReplacementCost', replacement_cost,
			'Rating', rating,
			'LastUpdate', last_update,
			'SpecialFeatures', special_features,
			'Fulltext', fulltext,
			'Actors', (
				select array_to_json(array_agg(row_to_json(actors)))
				from (
					select
						a.actor_id as "ActorId", 
						first_name as "FirstName",
						last_name as "LastName"
					from actor as a
					join film_actor as fa on fa.actor_id = a.actor_id
					where fa.film_id = f.film_id
				) as actors
			)
		)
	into lvJSON
	from film as f
	where f.film_id = p_id;
	
	if (coalesce(lvJSON, '') = '') then
		lvJSON = '[]';
	end if;

	return lvJSON;
end;
$BODY$;



create or replace function set_film(p_json character varying)
    returns integer
    language 'plpgsql'
as $BODY$
declare lvJSON jsonb;
declare lvFilmId integer;
declare lvLanguageId integer;
declare lvFeatures text[];
declare lvDateTime timestamp without time zone;
begin
	lvJSON := p_json::jsonb;
	
	select film_id into lvFilmId from film where film_id = cast(lvJSON->>'FilmId' as integer);
	raise notice 'My film id is %', lvFilmId;
	
	select language_id into lvLanguageId from language where language_id = cast(lvJSON->'Language'->>'LanguageId' as integer);
	if (lvLanguageId is NULL) then
		raise exception 'This is not a valid language or language is missing!';
	else
		raise notice 'My language id is %', lvLanguageId;
	end if;
	
	select array_agg(v::text) 
	into lvFeatures
	from jsonb_array_elements(lvJSON->'SpecialFeatures') as v;
	
	raise notice 'Features %', lvFeatures;
	
	-- just testing our date/time conversion, we are not using this but will instead use the system time
	lvDateTime := cast(lvJSON->>'LastUpdate' as timestamp without time zone);
	raise notice 'What is our date %', lvDateTime;
	
	if (lvFilmId is NULL) then
		insert into film (
			title, description, release_year, language_id, rental_duration, rental_rate,
			length, replacement_cost, rating, last_update, special_features, fulltext
		) values (
			lvJSON->>'Title', lvJSON->>'Description', cast(lvJSON->>'ReleaseYear' as year), 
			lvLanguageId, cast(lvJSON->>'RentalDuration' as smallint),
			cast(lvJSON->>'RentalRate' as float), cast(lvJSON->>'Length' as smallint),
			cast(lvJSON->>'ReplacementCost' as float), cast(lvJSON->>'Rating' as mpaa_rating),
			now(), lvFeatures, ''
		) returning film_id into lvFilmId;
	else
		update film
		set title = lvJSON->>'Title',
			description = lvJSON->'Description',
			release_year = cast(lvJSON->>'ReleaseYear' as year),
			language_id = lvLanguageId,
			rental_duration = cast(lvJSON->>'RentalDuration' as smallint),
			rental_rate = cast(lvJSON->>'RentalRate' as float),
			length = cast(lvJSON->>'Length' as smallint),
			replacement_cost = cast(lvJSON->>'ReplacementCost' as float),
			rating = cast(lvJSON->>'Rating' as mpaa_rating),
			special_features = lvFeatures,
			last_update = now()
		where film_id = lvFilmId;
	end if;
	
	return lvFilmId;
end;
$BODY$;
