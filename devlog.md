# Development Log - CS4337 Project 2

## 2026-05-05 3:15 PM --- Project Overview and Initial Plan

### Project Overview
This project requires building a Prolog scheduling backend for an imaginary web application.
The program will use facts from separate Prolog input files to create a valid work schedule.
The main predicate that must be implemented is `plan/1`.

The schedule should be returned as a `plan/3` structure. The three parts of the structure
represent the morning, evening, and night shifts in that order. Each shift schedule should be
a list of `workstation/2` structures, where the first value is the workstation and the second
value is the list of employees assigned to that workstation.

### What I Know
- The project is written in Prolog.
- The main predicate required is `plan/1`.
- The input facts are stored in separate `.pl` files and will be consulted with the project code.
- The input facts can include employees, workstations, idle workstations, workstation restrictions, and shift restrictions.
- `employee/1` represents each employee.
- `workstation/3` represents a workstation with its minimum and maximum number of employees.
- `workstation_idle/2` represents a workstation that should not be used during a certain shift.
- `avoid_workstation/2` represents a workstation an employee should not work at.
- `avoid_shift/2` represents a shift an employee should not work.
- Every employee must be scheduled exactly once.
- No employee should work more than one workstation or more than one shift.
- Workstation minimum and maximum limits must be followed.
- Idle workstations should not appear in that shift's schedule.
- Employees should not be assigned to restricted workstations or restricted shifts.
- If no valid schedule can be created, `plan/1` should fail.
- The program does not need to print anything.
- The provided `testing.pl` file can help check for missing employee assignments and duplicate employee assignments.

### Plan
1. Set up the local Git repository and development log.
2. Create a private GitHub repository and connect it as the remote.
3. Push the initial repository setup to GitHub.
4. Add the provided Project 2 files, including testing and example input/output files.
5. Create the main Prolog implementation file, likely named `project2.pl`.
6. Add a basic placeholder version of `plan/1` so the file loads safely.
7. Add helper predicates for collecting all employees.
8. Add helper predicates for collecting all workstations.
9. Add helper predicates for the three shifts: morning, evening, and night.
10. Add logic for detecting whether a workstation is active or idle during a shift.
11. Add logic for checking whether an employee can work a certain shift.
12. Add logic for checking whether an employee can work a certain workstation.
13. Combine the shift and workstation checks into one employee eligibility predicate.
14. Build an internal assignment structure for assigning employees to shifts and stations.
15. Generate assignments for all employees.
16. Make sure each employee is assigned exactly once.
17. Group assignments by shift.
18. Group assignments by workstation inside each shift.
19. Convert the internal assignments into the required `plan(Morning, Evening, Night)` format.
20. Add minimum and maximum workstation capacity validation.
21. Make sure idle workstations do not appear in the final schedule.
22. Test the program with the provided example input files.
23. Use `testing.pl` to check for employees with no work and employees assigned more than once.
24. Fix any issues found during testing.
25. Clean up indentation and formatting.
26. Add helpful comments after the logic is working.
27. Add a README file with file descriptions and command-line run instructions.
28. Finalize the devlog with a session reflection.
29. Push the final version to GitHub.
30. Make sure the working tree is clean.
31. Zip the entire repository for submission.

-------------------------------------------------------------------------------------------------------------

## 2026-05-05 8:04 PM --- Session 1 - Setup and Planning

### Thoughts so far
I am starting CS4337 Project 2. This project is about writing a Prolog backend that generates a work schedule. The main predicate I need to implement is plan/1. The input facts will describe employees, workstations, idle workstation shifts, employees who should avoid certain workstations, and employees who should avoid certain shifts.

The required output is a plan/3 structure with three schedules: morning, evening, and night. Each shift schedule should contain workstation/2 structures, where each workstation has a list of employees assigned to it.

The most important rules are that every employee must work exactly one workstation for exactly one shift, workstation minimum and maximum limits must be respected, idle workstations should not appear in a shift schedule, and employee restrictions must be followed.

### Plan for this session
For this first session, I plan to set up the local Git repository, create the development log, make the initial commit, create a GitHub repository, connect the local repository to GitHub, and push the first commit. After that, I will begin adding the provided project files in the next step.

-------------------------------------------------------------------------------------------------------------

## 2026-05-05 8:47 PM --- Session 1 - GitHub Setup Update

### Progress made
I initialized the local Git repository, created the main branch, made the first commit with the development log, created a private GitHub repository, connected the local repository to the GitHub remote, and successfully pushed the first commit.

### Notes
The GitHub remote is set to:
https://github.com/Nitin-UTD/cs4337-project2.git

The local branch main is now tracking origin/main. This means future commits can be pushed with git push.

### Next step
Next, I plan to add the provided Project 2 files, including the testing file, example input files, and example output files. After that, I will begin creating the first Prolog project file.
