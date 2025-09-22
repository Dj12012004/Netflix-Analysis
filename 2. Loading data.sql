load data local infile 'C:\\Users\\daksh\\Downloads\\archive\\netflix_titles.csv'
into table netflix 
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines ;