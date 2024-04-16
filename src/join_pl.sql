--Students
--1. Вывести общее количество студентов
select count(students.id)
from students;
--2. Вывести имя, почту и пол студента, айди группы которого равна 2
select s.first_name, s.email, s.gender
from students s
         inner join groups g on g.id = s.group_id
where group_id = 2;
--3. Вывести группу студента, айди которого равна 4
select group_name
from groups g
         join students s on s.group_id = g.id
where s.id = 4;
--4.Сгруппируйте студентов по gender и выведите общее количество gender
select count(gender), gender
from students
group by gender;
--5.Найдите студента с айди 8 и обновите его данные
update students
set first_name    = 'Nurkyz',
    last_name     = 'Zikirdinova',
    gender        = 'Female',
    email         = 'nurkyz@gmail.com',
    date_of_birth = '2004-07-04',
    group_id      = 1
where students.id = 8;
--6.Найдите самого старшего студента курса, айди курса которого равна 5
select min(date_of_birth)
from courses c
         inner join groups g on c.groups_id = g.id
         inner join students s on g.id = s.group_id
where c.id = 5;
--7.Добавьте unique constraint email в столбец таблицы students
alter table students
    add constraint unique_email unique (email);
--8.Добавьте check constraint gender в столбец таблицы mentors
alter table mentors
    add constraint check_gender check (gender in ('Male', 'Female'));
--9.Добавьте check constraint gender в столбец таблицы students
alter table students
    add constraint check_gender check (gender in ('Male', 'Female'));



--Mentors
-- 1. Вывести средний возраст всех менторов
-- no age
--2.Вывести имя, почту и специализацию ментора группы 'Java-9'
select mentors.first_name, mentors.email, mentors.specialization
from groups g
         inner join mentors on g.id = mentors.id
where group_name = 'Java 9';
-- 3. Вывести всех менторов, чей опыт превышает 1 год
select *
from mentors
where experience > 1;
-- 4.Вывести ментора у которого нет курса
select *
from courses
         inner join mentors m on courses.id = m.course_id
where course_id is null;
-- 5.Вывести айди, имя ментора и его студентов
select m.id, m.first_name, s.first_name
from mentors m
         inner join courses c on c.id = m.course_id
         inner join groups g on c.groups_id = g.id
         inner join students s on g.id = s.group_id;
--  6. Посчитать сколько студентов у каждого ментора, и вывести полное имя ментора и количество его студентов
select CONCAT(m.first_name, ' ', m.last_name) as full_name, COUNT(s.id) as student_count
from mentors m
         inner join students s on s.id = m.id
group by m.id, m.first_name, m.last_name;
-- 7. Вывести ментора у которого нет студентов
select *
from mentors m
         inner join courses c on m.course_id = c.id
         inner join groups g on c.groups_id = g.id
         inner join students s on g.id = s.group_id
where s.id is null;
-- 8. Вывести ментора у которого студентов больше чем 2
select count(s.id), m.first_name
from mentors m
         inner join courses c on m.course_id = c.id
         inner join groups g on c.groups_id = g.id
         inner join students s on g.id = s.group_id
group by m.first_name
having count(s.id) > 2;
-- 9. Вывести курсы ментора с айди 5
select *
from courses
         inner join mentors m on courses.id = m.course_id
where m.id = 5;
--10.Вывести все уроки ментора, айди которого равен 5
select *
from lessons
         inner join mentors m on lessons.course_id = m.course_id
where m.id = 5;


--Lessons
-- Вывести все уроки
select *
from lessons;
-- 2.Получить все уроки студента, айди которого равен 2
select *
from lessons l
         inner join courses c on c.id = l.course_id
         inner join groups g on c.groups_id = g.id
         inner join students s on g.id = s.group_id
where s.id = 2;
-- 3.Посчитать уроки каждой группы и вывести название группы и количество уроков, где количество уроков больше чем 2
select count(l.id) as count_of_lessons, g.group_name
from lessons l
         inner join courses c on l.course_id = c.id
         inner join groups g on c.groups_id = g.id
group by g.group_name
having count(l.id) > 2;
-- 4.Отсортировать уроки студента по названию, где айди студента равна 7
select *
from lessons
         inner join courses c on lessons.course_id = c.id
         inner join groups g on c.groups_id = g.id
         inner join students s on g.id = s.group_id
where s.id = 7;
-- 5.Получить все уроки курса, где название курса 'Python kids'
select *
from lessons
         inner join courses c on c.id = lessons.course_id
where course_name = 'Python kids';
-- 6.Получить все уроки ментора, айди которого равен 5
select *
from lessons
         inner join mentors m on lessons.course_id = m.course_id
where m.id = 5;