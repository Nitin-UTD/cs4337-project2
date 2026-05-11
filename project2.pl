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

can_work_shift(Employee, Shift) :-
    employee(Employee),
    shift(Shift),
    \+ avoid_shift(Employee, Shift).

can_work_station(Employee, Station) :-
    employee(Employee),
    workstation(Station, _, _),
    \+ avoid_workstation(Employee, Station).

can_work(Employee, Shift, Station) :-
    can_work_shift(Employee, Shift),
    can_work_station(Employee, Station),
    active_workstation(Station, Shift).