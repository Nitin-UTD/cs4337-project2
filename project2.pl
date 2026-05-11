plan(_) :- fail.

shift(morning).
shift(evening).
shift(night).

all_employees(Employees) :-
    findall(Employee, employee(Employee), Employees).

all_workstations(Workstations) :-
    findall(workstation(Station, Min, Max), workstation(Station, Min, Max), Workstations).

active_workstation(Station, Shift) :-
    workstation(Station, _, _),
    \+ workstation_idle(Station, Shift).