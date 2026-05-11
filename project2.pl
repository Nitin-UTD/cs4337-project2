plan(_) :- fail.

shift(morning).
shift(evening).
shift(night).

all_employees(Employees) :-
    findall(Employee, employee(Employee), Employees).

all_workstations(Workstations) :-
    findall(workstation(Station, Min, Max), workstation(Station, Min, Max), Workstations).

is_idle(Station, Shift) :-
    current_predicate(workstation_idle/2),
    workstation_idle(Station, Shift).

avoids_shift(Employee, Shift) :-
    current_predicate(avoid_shift/2),
    avoid_shift(Employee, Shift).

avoids_workstation(Employee, Station) :-
    current_predicate(avoid_workstation/2),
    avoid_workstation(Employee, Station).

active_workstation(Station, Shift) :-
    workstation(Station, _, _),
    \+ is_idle(Station, Shift).

can_work_shift(Employee, Shift) :-
    employee(Employee),
    shift(Shift),
    \+ avoids_shift(Employee, Shift).

can_work_station(Employee, Station) :-
    employee(Employee),
    workstation(Station, _, _),
    \+ avoids_workstation(Employee, Station).

can_work(Employee, Shift, Station) :-
    can_work_shift(Employee, Shift),
    can_work_station(Employee, Station),
    active_workstation(Station, Shift).

empty_slot(slot(Shift, Station, Min, Max, [])) :-
    shift(Shift),
    workstation(Station, Min, Max),
    active_workstation(Station, Shift).

all_empty_slots(Slots) :-
    findall(slot(Shift, Station, Min, Max, []),
            empty_slot(slot(Shift, Station, Min, Max, [])),
            Slots).

assign_employee_to_slot(Employee,
                        slot(Shift, Station, Min, Max, Workers),
                        slot(Shift, Station, Min, Max, [Employee|Workers])) :-
    can_work(Employee, Shift, Station),
    length(Workers, Count),
    Count < Max.

assign_employee(Employee, [Slot|Rest], [NewSlot|Rest]) :-
    assign_employee_to_slot(Employee, Slot, NewSlot).

assign_employee(Employee, [Slot|Rest], [Slot|NewRest]) :-
    assign_employee(Employee, Rest, NewRest).

assign_all_employees([], Slots, Slots).

assign_all_employees([Employee|RestEmployees], SlotsIn, SlotsOut) :-
    assign_employee(Employee, SlotsIn, UpdatedSlots),
    assign_all_employees(RestEmployees, UpdatedSlots, SlotsOut).

valid_slot(slot(_, _, Min, Max, Workers)) :-
    length(Workers, Count),
    Count >= Min,
    Count =< Max.

valid_slots([]).

valid_slots([Slot|Rest]) :-
    valid_slot(Slot),
    valid_slots(Rest).

slot_to_workstation(slot(_, Station, _, _, Workers), workstation(Station, Workers)) :-
    Workers \= [].

slots_for_shift([], _, []).

slots_for_shift([slot(Shift, Station, Min, Max, Workers)|Rest], Shift, [workstation(Station, Workers)|ScheduleRest]) :-
    slot_to_workstation(slot(Shift, Station, Min, Max, Workers), workstation(Station, Workers)),
    slots_for_shift(Rest, Shift, ScheduleRest).

slots_for_shift([slot(OtherShift, _, _, _, _)|Rest], Shift, Schedule) :-
    OtherShift \= Shift,
    slots_for_shift(Rest, Shift, Schedule).

slots_to_plan(Slots, plan(Morning, Evening, Night)) :-
    slots_for_shift(Slots, morning, Morning),
    slots_for_shift(Slots, evening, Evening),
    slots_for_shift(Slots, night, Night).