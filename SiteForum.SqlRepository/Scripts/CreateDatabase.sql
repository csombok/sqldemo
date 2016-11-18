USE [SiteForum]
GO

if not exists (Select 1 from sysobjects where name = 'Member' and [type]='U')
begin
	create table Member
	(
		Id int identity (1,1) primary key,
		FirstName nvarchar(50) not null,
		LastName nvarchar(50) not null,
		EmailAddress varchar(100) not null,
		PhoneNumber varchar(20)
		--constraint UNIQUE_EmailAddress unique (EmailAddress)
	)
	alter table Member
	add constraint UNIQUE_EmailAddress unique (EmailAddress)
end
GO

if not exists (Select 1 from sysobjects where name = 'Post' and [type]='U')
begin
	create table Post
	(
		Id int identity (1,1) primary key,
		CreatedBy int not null,
		Title nvarchar(100) not null,
		Content nvarchar(max) not null,
		TimeCreatedUTC DateTime not null,
		Labels varchar(500)
	)

	ALTER TABLE Post
	ADD CONSTRAINT FK_Post_Member FOREIGN KEY (CreatedBy)
	REFERENCES Member (Id)

end

GO

if not exists (Select 1 from sysobjects where name = 'Comment' and [type]='U')
begin
	create table Comment
	(
		Id int identity (1,1) primary key,
		CreatedBy int not null,
		PostId int not null,
		[Text] nvarchar(100) not null,
		TimeCreatedUTC DateTime not null,
	)

	ALTER TABLE Comment
	ADD CONSTRAINT FK_Comment_Post FOREIGN KEY (PostId)
	REFERENCES Post (Id)

	ALTER TABLE Comment
	ADD CONSTRAINT FK_Comment_Member FOREIGN KEY (CreatedBy)
	REFERENCES Member (Id)
end
GO

-- Create indexes
create index I_PostTimeCreatedUTC on Post (TimeCreatedUTC);
create index I_PostLabels on Post (Labels);
create index I_CommentTimeCreatedUTC on Comment (TimeCreatedUTC);
