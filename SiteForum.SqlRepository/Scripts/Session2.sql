USE [SiteForum]
GO

-- Drop tables
if exists (Select 1 from sysobjects where name = 'Comment' and [type]='U')
begin
	drop table Comment
end
go

if exists (Select 1 from sysobjects where name = 'Post' and [type]='U')
begin
	drop table Post
end
go

if exists (Select 1 from sysobjects where name = 'Member' and [type]='U')
begin
	drop table Member
end
go

-- Create tables
create table Member
(
	Id int identity (1,1) primary key,
	FirstName nvarchar(20) not null,
	LastName nvarchar(20) not null,
	EmailAddress varchar(50) not null,
	PhoneNumber varchar(20)		
)

alter table Member
add constraint U_EmailAddress unique (EmailAddress)
GO

create table Post
(
	Id int identity (1,1) primary key,
	CreatedBy int not null references Member(Id),
	Title nvarchar(100) not null,
	Content nvarchar(max) not null,
	TimeCreatedUTC DateTime not null default getutcdate(),
	Labels varchar(500),
)	
GO

create table Comment
(
	Id int identity (1,1) primary key,
	CreatedBy int not null references Member(Id),
	PostId int not null references Post(Id),
	[Text] nvarchar(100) not null,
	TimeCreatedUTC DateTime not null,
)
GO

-- Create indexes
create index I_PostTimeCreatedUTC on Post (TimeCreatedUTC, Labels);
create index I_PostLabels on Post (Labels);
go

-- Insert test data
insert into Member (FirstName, LastName, EmailAddress, PhoneNumber)
values ('First1', 'Last1', 'Email1@gmail.com', 'Phone1')

insert into Member
values ('First2', 'Last2', 'Email2@gmail.com', 'Phone2')

insert into Member
select 'First2', 'Last2', 'Email4@gmail.com', 'Phone2'
union select 'First2', 'Last2', 'Email5@gmail.com', 'Phone2'
union select 'First2', 'Last2', 'Email6@gmail.com', 'Phone2'

-- Update existing data by using transaction
begin tran

	update Member
	set LastName = 'Last30'
	where Id = 3

	select * from Member

--commit

rollback

select * from Member