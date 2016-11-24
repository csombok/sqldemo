-- Create a user defined table function to return a table from split text
if not exists (select 1 from sysobjects where name = 'Split')
begin
	CREATE FUNCTION [dbo].[Split]
	(
		@String NVARCHAR(4000),
		@Delimiter NCHAR(1)
	)
	RETURNS TABLE
	AS
	RETURN
		(
			WITH Split(stpos,endpos)
			AS(
				SELECT 0 AS stpos, CHARINDEX(@Delimiter,@String) AS endpos
				UNION ALL
				SELECT endpos+1, CHARINDEX(@Delimiter,@String,endpos+1)
					FROM Split
					WHERE endpos > 0
			)
			SELECT 'Id' = ROW_NUMBER() OVER (ORDER BY (SELECT 1)),
				'Data' = SUBSTRING(@String,stpos,COALESCE(NULLIF(endpos,0),LEN(@String)+1)-stpos)
			FROM Split
		)
end
GO

-- Select all posts joining related comments where post match labels
declare @labelFilter varchar(50) = 'education'
select * 
from Post p
join Comment c on c.PostId = p.Id
where p.Labels like '%' + @labelFilter + '%'

-- Show members comment activities by labels (member name, label, comment count)
with Labels(Label) as 
(
	-- Create a distinct table of labels
	select distinct [Data] 
	from [dbo].[split]((SELECT STUFF((
	    SELECT '|' + Labels
		FROM Post
		FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '')), '|')
)
select 
	m.Id, 
	CONCAT(CONCAT(m.FirstName,' '), m.LastName) as Name,
	l.Label,
	COUNT(*) as [Comments]
from Member m
join Post p on p.CreatedBy = m.Id
join Labels l on p.Labels like '%' + l.Label + '%'
join Comment c on c.PostId = p.Id
group by m.Id, CONCAT(CONCAT(m.FirstName,' '), m.LastName), l.Label

-- Select all posts having more than 2 comments
select 
	p.id, 
	COUNT(*) as [Comments] 
from Post p
join Comment c on c.PostId = p.Id
group by p.id
having COUNT(*) > 2
order by [Comments] 

-- Create a temp table Lofasz to return posts and related comments

drop table #Lofasz

select p.Id, p.Content
into #Lofasz
from Post p
join Comment c on c.PostId = p.Id

-- Select first x records
select top(select 5) * from #Lofasz order by Id

-- Select first half of records ordered by post Id
select top 50 percent * from #Lofasz order by Id

