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

-------------------------------------------------------------------------------------------------------------

## 2026-05-05 9:10 PM --- Session 2 - Adding Provided Project Files

### Thoughts so far
The local Git repository and GitHub remote are both set up and working. The devlog now has a project overview, a list of what I know about the assignment, and an overall plan for completing the project.

Before writing the actual Prolog solution, I want to add the provided Project 2 files to the repository. These files will help me test the program as I build it. The provided testing file is especially useful because it includes helper predicates for checking whether an employee has no work or is assigned more than once.

### Plan for this session
- Add the provided `testing.pl` file
- Add all five example input `.pl` files
- Add all five example output `.txt` files
- Check Git status to make sure only the correct files are being added
- Commit the provided project files
- Add an end-of-session devlog reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-05 9:22 PM --- Session 2 - Provided Files Added

### Progress made
I added the provided Project 2 files to the repository. This included the testing helper file, five example input files, and five example output files. I checked the directory listing and Git status before committing to make sure only the correct Project 2 files were included.

### Notes
The repository now has the provided examples needed for testing the scheduling logic once `project2.pl` is created.

### Next step
Next, I plan to create the main `project2.pl` file and add a small placeholder version of `plan/1`. This will let me confirm that SWI-Prolog can load the project file before building the real scheduling logic.

-------------------------------------------------------------------------------------------------------------

## 2026-05-07 7:51 PM --- Session 3 - Creating Initial Prolog File

### Thoughts so far
The repository now contains the provided Project 2 testing file and example input/output files. The setup work is complete, so I can begin creating the actual Prolog implementation file.

Before writing the full scheduling logic, I want to start with a small placeholder version of `plan/1`. This will let me confirm that the project file loads correctly in SWI-Prolog before I add more complicated helper predicates. Since the project requires `plan/1` to fail when no valid schedule can be created, a temporary failing placeholder is a safe first step.

### Plan for this session
- Create the main `project2.pl` file
- Add a temporary placeholder definition for `plan/1`
- Load `project2.pl` in SWI-Prolog
- Confirm that querying `plan(Plan).` returns `false`
- Commit the initial Prolog file
- Add an end-of-session reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-07 8:20 PM --- Session 3 - Initial Prolog File Created

### Progress made
I created the main `project2.pl` file and added a temporary placeholder version of `plan/1`. The placeholder currently fails on purpose, but it confirms that the required predicate name exists and that the project file can be loaded by SWI-Prolog.

I also installed SWI-Prolog on my Windows machine because the `swipl` command was not recognized at first. After installing it and reopening the terminal, `swipl --version` worked correctly.

### Notes
The initial placeholder was tested by loading `project2.pl` inside SWI-Prolog using `[project2].` and then querying `plan(Plan).`. The file loaded successfully and the query returned `false`, which matches the current placeholder behavior.

This is not the final scheduling logic yet. It is only a safe starting point before adding helper predicates.

### Next step
Next, I plan to start adding simple helper predicates. The first helper will collect all employees from the consulted input facts using `findall/3`, then I will test it with one of the provided example input files.

-------------------------------------------------------------------------------------------------------------

## 2026-05-08 11:11 AM --- Session 4 - Employee Collection Helper

### Thoughts so far
The main Prolog file now exists and loads correctly in SWI-Prolog. The current `plan/1` predicate is only a placeholder, so the next step is to start adding small helper predicates that will eventually support the full scheduling logic.

The first useful helper is for collecting all employees from the consulted input facts. Since the project input files define employees using `employee/1`, I can use Prolog's `findall/3` predicate to gather every employee into a list.

### Plan for this session
- Add an `all_employees/1` helper predicate
- Keep the temporary `plan/1` placeholder unchanged for now
- Load one example input file together with `project2.pl`
- Test that `all_employees(Employees).` returns a list of employees
- Commit the new helper predicate
- Add an end-of-session reflection
- Push the session progress to GitHub