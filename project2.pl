%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CS4337 Project 2
%
% Prolog scheduling backend.
%
% The required predicate is plan/1. The input facts are expected to be loaded
% from a separate file before or along with this project file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plan(Plan)
%
% Builds a valid work schedule in the form:
% plan(MorningSchedule, EveningSchedule, NightSchedule)
%
% Each shift schedule is a list of workstation(Station, Workers) structures.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plan(Plan) :-
    input_ready,
    all_employees(Employees),
    all_empty_slots(EmptySlots),
    valid_slot_limits(EmptySlots),
    fill_minimums(EmptySlots, Employees, MinimumFilledSlots, RemainingEmployees),
    assign_remaining_employees(RemainingEmployees, MinimumFilledSlots, FilledSlots),
    valid_slots(FilledSlots),
    slots_to_plan(FilledSlots, Plan).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Basic input and shift helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input_ready :-
    current_predicate(employee/1),
    current_predicate(workstation/3).

shift(morning).
shift(evening).
shift(night).

all_employees(Employees) :-
    current_predicate(employee/1),
    findall(Employee, employee(Employee), Employees).

all_workstations(Workstations) :-
    current_predicate(workstation/3),
    findall(workstation(Station, Min, Max), workstation(Station, Min, Max), Workstations).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Safe wrappers for optional predicates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

is_idle(Station, Shift) :-
    current_predicate(workstation_idle/2),
    workstation_idle(Station, Shift).

avoids_shift(Employee, Shift) :-
    current_predicate(avoid_shift/2),
    avoid_shift(Employee, Shift).

avoids_workstation(Employee, Station) :-
    current_predicate(avoid_workstation/2),
    avoid_workstation(Employee, Station).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eligibility helpers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

active_workstation(Station, Shift) :-
    current_predicate(workstation/3),
    workstation(Station, _, _),
    \+ is_idle(Station, Shift).

can_work_shift(Employee, Shift) :-
    current_predicate(employee/1),
    employee(Employee),
    shift(Shift),
    \+ avoids_shift(Employee, Shift).

can_work_station(Employee, Station) :-
    current_predicate(employee/1),
    current_predicate(workstation/3),
    employee(Employee),
    workstation(Station, _, _),
    \+ avoids_workstation(Employee, Station).

can_work(Employee, Shift, Station) :-
    can_work_shift(Employee, Shift),
    can_work_station(Employee, Station),
    active_workstation(Station, Shift).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Internal slot representation
%
% slot(Shift, Station, Min, Max, Workers)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

empty_slot(slot(Shift, Station, Min, Max, [])) :-
    current_predicate(workstation/3),
    shift(Shift),
    workstation(Station, Min, Max),
    active_workstation(Station, Shift).

all_empty_slots(Slots) :-
    findall(slot(Shift, Station, Min, Max, []),
            empty_slot(slot(Shift, Station, Min, Max, [])),
            Slots).

valid_slot_limits([]).

valid_slot_limits([slot(_, _, Min, Max, _)|Rest]) :-
    Min =< Max,
    valid_slot_limits(Rest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Minimum-first scheduling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

choose_workers(0, Employees, _, _, [], Employees).

choose_workers(Count, EmployeesIn, Shift, Station, [Employee|ChosenRest], EmployeesOut) :-
    Count > 0,
    select(Employee, EmployeesIn, RemainingEmployees),
    can_work(Employee, Shift, Station),
    NextCount is Count - 1,
    choose_workers(NextCount, RemainingEmployees, Shift, Station, ChosenRest, EmployeesOut).

fill_minimums([], Employees, [], Employees).

fill_minimums([slot(Shift, Station, Min, Max, [])|RestSlots],
              EmployeesIn,
              [slot(Shift, Station, Min, Max, Workers)|FilledRest],
              EmployeesOut) :-
    choose_workers(Min, EmployeesIn, Shift, Station, Workers, RemainingEmployees),
    fill_minimums(RestSlots, RemainingEmployees, FilledRest, EmployeesOut).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assigning remaining employees after minimums are satisfied
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

assign_remaining_employees(Employees, SlotsIn, SlotsOut) :-
    assign_all_employees(Employees, SlotsIn, SlotsOut).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Capacity validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

valid_slot(slot(_, _, Min, Max, Workers)) :-
    length(Workers, Count),
    Count >= Min,
    Count =< Max.

valid_slots([]).

valid_slots([Slot|Rest]) :-
    valid_slot(Slot),
    valid_slots(Rest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conversion from internal slots to required plan/3 format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

slot_to_workstation(slot(_, Station, _, _, Workers), workstation(Station, Workers)) :-
    Workers \= [].

slots_for_shift([], _, []).

slots_for_shift([slot(Shift, _, _, _, [])|Rest], Shift, Schedule) :-
    slots_for_shift(Rest, Shift, Schedule).

slots_for_shift([slot(Shift, Station, _, _, Workers)|Rest], Shift, [workstation(Station, Workers)|ScheduleRest]) :-
    Workers \= [],
    slots_for_shift(Rest, Shift, ScheduleRest).

slots_for_shift([slot(OtherShift, _, _, _, _)|Rest], Shift, Schedule) :-
    OtherShift \= Shift,
    slots_for_shift(Rest, Shift, Schedule).

slots_to_plan(Slots, plan(Morning, Evening, Night)) :-
    slots_for_shift(Slots, morning, Morning),
    slots_for_shift(Slots, evening, Evening),
    slots_for_shift(Slots, night, Night).