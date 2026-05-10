plan(_) :- fail.

all_employees(Employees) :-
    findall(Employee, employee(Employee), Employees).