create table Positions(
	Id int identity primary key,
	Position nvarchar(200),
	Dependency int
)

--self join

select p1.Position,p2.Position 'Dependency' from Positions p1
left join Positions p2
on p1.Dependency=p2.Id

--non-equal join

alter table Students
add Grade int

create table Grades(
	Id int identity primary key,
	MinGrade int,
	MaxGrade int,
	Letter char
)

select Firstname,Surname,Email,Age,Grade,Letter from Students s
join Grades gr
on s.Grade Between gr.MinGrade AND gr.MaxGrade


--cross join

create table Sizes(
	Id int identity primary key,
	Size nvarchar(5)
)

create table Product(
	Id int identity primary key,
	Name nvarchar(100)
)

select Name,Size from Product
cross join Sizes

select distinct Firstname from Students

select Count(Firstname) 'Student Count'  from Students

select Count(distinct Firstname) from Students

select Firstname,COUNT(Firstname) 'Name Count' from Students
Group by Firstname
having COUNT(Firstname)>1

create table OldStudent(
	Id int identity primary key,
	Firstname nvarchar(100),
	Surname nvarchar(100)
)

select Firstname,Surname from Students
union
select Firstname,Surname from OldStudent

select Firstname,Surname from Students
union all
select Firstname,Surname from OldStudent

select Firstname,Surname from Students
except
select Firstname,Surname from OldStudent

select Firstname,Surname from OldStudent
except
select Firstname,Surname from Students

select Firstname,Surname from Students
intersect
select Firstname,Surname from OldStudent

create table GroupStudents(
	Id int identity primary key,
	GroupsId int references Groups(Id),
	StudentsId int references Students(Id)
)

create view usv_GetAllInfoStudents
as
select Firstname,Surname,Email,Age,Grade,g.Name 'Group',MaxCount,gt.Name 'Type',Letter from Students s

join GroupStudents gs
on s.Id=gs.StudentsId

join Groups g
on g.Id=gs.GroupsId

join GroupTypes gt
on gt.Id=g.GroupTypesId

join Grades gr
on s.Grade Between gr.MinGrade AND gr.MaxGrade

select * from usv_GetAllInfoStudents
