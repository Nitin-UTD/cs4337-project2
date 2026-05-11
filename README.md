# CS4337 Project 2

## Overview

This project implements a Prolog scheduling backend for CS4337 Project 2.

The main required predicate is:

```prolog
plan(Plan).
```

The program uses employee, workstation, idle workstation, avoid workstation, and avoid shift facts from a separate consulted Prolog input file. It generates a valid schedule in the required format:

```prolog
plan(MorningSchedule, EveningSchedule, NightSchedule)
```

Each shift schedule is a list of:

```prolog
workstation(Station, Workers)
```

## Files

- `project2.pl`  
  Main Prolog implementation. Defines `plan/1` and helper predicates for scheduling, validation, restrictions, and conversion to the required output format.

- `testing.pl`  
  Provided testing helper file. Includes predicates such as `no_work/2`, `double_work/2`, and `works_at/4`.

- `example-input-1.pl` through `example-input-5.pl`  
  Provided example input fact files.

- `example-output-1.txt` through `example-output-5.txt`  
  Provided example output files.

- `devlog.md`  
  Development log documenting planning, progress, testing, and reflections.

## How to Run

Open SWI-Prolog from the project directory.

Example:

```prolog
['example-input-1.pl'].
[project2].
plan(Plan).
```

To check whether at least one plan exists without printing a large schedule:

```prolog
once(plan(_)).
```

To use the provided testing helpers:

```prolog
['example-input-1.pl'].
[project2].
[testing].
plan(Plan), no_work(Plan, _).
plan(Plan), double_work(Plan, _).
```

For a correct plan, both of those checks should return:

```prolog
false.
```

## Notes

The project assumes that an input facts file is consulted before or along with `project2.pl`.

If `project2.pl` is loaded by itself without employee or workstation facts, `plan/1` safely fails instead of throwing an unknown predicate error.

The implementation uses an internal slot structure:

```prolog
slot(Shift, Station, Min, Max, Workers)
```

The scheduler first fills required minimum workers for each active workstation, then assigns remaining employees into available capacity. Finally, it converts the internal slot representation into the required `plan/3` format.