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

-------------------------------------------------------------------------------------------------------------

## 2026-05-08 12:42 PM --- Session 4 - Employee Helper Tested

### Progress made
I added the first real helper predicate, `all_employees/1`, to `project2.pl`. This helper uses `findall/3` to collect all employees from the currently consulted input facts into one list.

I tested the helper with `example-input-1.pl` and confirmed that it returned a list of employees. This is an important first step because the final scheduling logic will need to assign every employee exactly once.

### Notes
I initially tried loading the example input file with `[example-input-1].`, but SWI-Prolog treated the hyphens in the file name incorrectly. The correct way to load files with hyphens is to put the file name in quotes, like `['example-input-1.pl'].`.

After loading the input file correctly, `[project2].` loaded successfully and `all_employees(Employees).` returned the expected employee list.

### Next step
Next, I plan to add a helper predicate for collecting workstation information. This should gather each workstation along with its minimum and maximum worker limits so the final schedule can later check capacity requirements.

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 12:21 PM --- Session 5 - Workstation Collection Helper

### Thoughts so far
The project file now has a working `all_employees/1` helper. I tested it with `example-input-1.pl`, and it successfully collected the employees from the consulted input facts.

The next helper I need is for collecting workstation information. The input files define workstations using `workstation/3`, where the first value is the workstation name or number, the second value is the minimum number of employees, and the third value is the maximum number of employees. This information will be needed later when checking whether each workstation has a valid number of assigned workers.

### Plan for this session
- Add an `all_workstations/1` helper predicate
- Use `findall/3` to collect each `workstation(Station, Min, Max)` fact
- Load `example-input-1.pl` with `project2.pl`
- Test that `all_workstations(Workstations).` returns the expected workstation list
- Commit the workstation helper
- Add an end-of-session reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 1:00 PM --- Session 5 - Workstation Helper Tested

### Progress made
I added the `all_workstations/1` helper predicate to `project2.pl`. This helper uses `findall/3` to collect every `workstation(Station, Min, Max)` fact from the consulted input file into a list.

I tested it using `example-input-1.pl` and confirmed that it returned the expected workstation list: workstation 1 with limits 2 to 4, workstation 2 with limits 5 to 9, and workstation 3 with limits 1 to 1.

### Notes
This helper will be important later because the final schedule must check that each active workstation has at least its minimum number of workers and no more than its maximum number of workers.

The test also confirmed again that loading files with hyphens requires quotes, such as `['example-input-1.pl'].`.

### Next step
Next, I plan to add a helper for the three valid shifts: morning, evening, and night. After that, I can begin checking whether a workstation is active or idle during a specific shift.

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 4:27 PM --- Session 6 - Shift Helper

### Thoughts so far
The project now has helper predicates for collecting employees and workstations from the consulted input facts. Both helpers were tested with `example-input-1.pl` and returned the expected lists.

The next piece of scheduling information is the set of valid shifts. The project only uses three shifts: morning, evening, and night. Adding a small `shift/1` helper will make later predicates easier to write because other parts of the program can ask Prolog for each valid shift.

### Plan for this session
- Add a `shift/1` helper predicate
- Define the three valid shifts: morning, evening, and night
- Load `project2.pl` in SWI-Prolog
- Test that `shift(Shift).` generates all three shifts
- Commit the shift helper
- Add an end-of-session reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 4:58 PM --- Session 6 - Shift Helper Tested

### Progress made
I added the `shift/1` helper predicate to `project2.pl`. It defines the three valid shifts used by the project: morning, evening, and night.

I tested the helper in SWI-Prolog by loading `project2.pl` and querying `shift(Shift).`. The query successfully generated all three shifts.

### Notes
While testing, I accidentally triggered Prolog's action prompt after the first answer. I learned that when Prolog gives one answer and waits, typing `;` asks it to search for the next possible answer. After using `;` correctly, Prolog returned morning, evening, and night as expected.

This helper will be useful later when generating possible shift assignments for employees.

### Next step
Next, I plan to add logic for checking whether a workstation is active during a shift. This will use the `workstation_idle/2` facts so that idle workstations do not appear in the final schedule.

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 6:00 PM --- Session 7 - Active Workstation Helper

### Thoughts so far
The project now has helpers for collecting employees, collecting workstations, and generating the three valid shifts. These are basic building blocks for the scheduling logic.

The next requirement to handle is idle workstations. The project input can include `workstation_idle/2` facts, which mean that a workstation should not be used during a certain shift. Before assigning employees to workstations, I need a helper that can tell whether a workstation is active during a specific shift.

### Plan for this session
- Add an `active_workstation/2` helper predicate
- Use `workstation/3` to confirm that the station exists
- Use `workstation_idle/2` to reject stations that are idle during a shift
- Test with `example-input-1.pl`, where workstation 3 is idle in the morning
- Confirm that workstation 3 is not active in the morning but is active during other shifts
- Commit the active workstation helper
- Add an end-of-session reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 6:19 PM --- Session 7 - Active Workstation Helper Tested

### Progress made
I added the `active_workstation/2` helper predicate to `project2.pl`. This helper checks that a workstation exists using `workstation/3` and then confirms that it is not idle during the given shift using `workstation_idle/2`.

I tested the helper with `example-input-1.pl`. In that example, workstation 3 is idle during the morning shift. The query `active_workstation(3, morning).` correctly returned false, while `active_workstation(3, evening).` returned true. I also queried `active_workstation(Station, morning).`, and it returned only workstations 1 and 2.

### Notes
This helper directly supports one of the project requirements: the final schedule should not contain workstations that are idle during a shift. This will be used later when building shift schedules and assigning employees.

The `\+` operator is being used as negation-as-failure, which works well here because a workstation is active when Prolog cannot prove that it is idle during that shift.

### Next step
Next, I plan to add helper predicates for employee restrictions. The next part of the project is checking whether an employee can work a shift and whether an employee can work at a workstation.

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 6:45 PM --- Session 8 - Employee Eligibility Helpers

### Thoughts so far
The project now has helpers for collecting employees, collecting workstations, listing valid shifts, and checking whether a workstation is active during a shift. The active workstation helper was tested with `example-input-1.pl` and correctly filtered out workstation 3 during the morning shift.

The next requirement is to handle employee restrictions. The input files can include `avoid_shift/2` facts for shifts an employee cannot work and `avoid_workstation/2` facts for workstations an employee cannot work at. Before building full assignments, I need helper predicates that can check these restrictions.

### Plan for this session
- Add a `can_work_shift/2` helper predicate
- Add a `can_work_station/2` helper predicate
- Use negation-as-failure to reject avoided shifts and avoided workstations
- Test the helpers with `example-input-1.pl`
- Confirm that Daniel cannot work night
- Confirm that Ophelia cannot work workstations 1 or 3
- Commit the employee eligibility helpers
- Add an end-of-session reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 7:10 PM --- Session 8 - Employee Eligibility Helpers Tested

### Progress made
I added two employee eligibility helper predicates to `project2.pl`: `can_work_shift/2` and `can_work_station/2`.

The `can_work_shift/2` helper checks that an employee exists, that the shift is valid, and that the employee is not listed in an `avoid_shift/2` fact for that shift. The `can_work_station/2` helper checks that an employee exists, that the workstation exists, and that the employee is not listed in an `avoid_workstation/2` fact for that workstation.

I tested these helpers using `example-input-1.pl`. Daniel correctly could not work the night shift, but could work the morning shift. Ophelia correctly could not work workstations 1 or 3, but could work workstation 2.

### Notes
These helpers are important because the final schedule must avoid assigning employees to restricted shifts or restricted workstations.

At this point, several basic building blocks are working: employee collection, workstation collection, shift generation, active workstation checking, and employee restriction checking.

### Next step
Next, I plan to combine the shift and workstation checks into a single helper predicate for valid employee assignments. After that, I can start generating assignment structures for employees.

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 7:27 PM --- Session 9 - Assignment Building Helpers

### Thoughts so far
The project now has several tested helper predicates: collecting employees, collecting workstations, listing shifts, checking active workstations, and checking employee shift/workstation restrictions.

The next major goal is to start building the internal assignment system. Before creating the final `plan/3` structure, it will be easier to create internal assignment slots for each active workstation during each shift and then place employees into those slots.

### Plan for this session
- Add a combined `can_work/3` helper that checks shift, workstation, and active workstation rules together
- Test `can_work/3` with known restrictions from `example-input-1.pl`
- Add a helper to build empty assignment slots for every active workstation during every shift
- Test that morning slots exclude idle workstation 3 in `example-input-1.pl`
- Add a helper for assigning one employee to one valid slot
- Test a simple one-employee assignment
- Commit each feature separately
- Add an end-of-session reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-09 10:44 PM --- Session 9 - Assignment Building Helpers Tested

### Progress made
This session added several assignment-related helper predicates to `project2.pl`.

First, I added `can_work/3`, which combines shift eligibility, workstation eligibility, and active workstation checking into one predicate. I tested it with `example-input-1.pl`, and it correctly rejected Daniel on the night shift, rejected Ophelia at restricted workstations, allowed Ophelia at workstation 2, and rejected workstation 3 during the morning shift.

Next, I added empty assignment slot helpers. These create internal `slot(Shift, Station, Min, Max, Workers)` structures for every active workstation during every valid shift. I tested this with `example-input-1.pl` and confirmed that workstation 3 was excluded from the morning slots because it is idle in the morning.

Then I added helpers for assigning one employee to a slot, assigning one employee across a list of slots, and assigning all employees recursively. These helpers successfully placed employees into valid slots while respecting shift restrictions, workstation restrictions, and maximum workstation capacity.

### Notes
The internal slot structure is not the final required output format. It is only an intermediate format that makes assignment and validation easier.

The current code can assign employees to slots, but it does not yet check whether every workstation has at least its minimum number of workers. It also does not yet convert the slot list into the final required `plan(Morning, Evening, Night)` structure.

During testing, I also made a small typo when typing `all_empty_slots/1`, but SWI-Prolog suggested the correct predicate name and the corrected query worked.

### Next step
Next, I plan to add validation logic for workstation minimum and maximum worker counts. After that, I will convert the internal slot representation into the required final plan structure.

-------------------------------------------------------------------------------------------------------------

## 2026-05-10 4:00 PM --- Session 10 - Validation and Real Plan Logic

### Thoughts so far
The project now has internal assignment helpers that can place employees into valid shift and workstation slots. The current logic respects shift restrictions, workstation restrictions, idle workstations, and maximum workstation capacity while assigning employees.

The next major task is to turn this partial assignment system into a complete `plan/1` implementation. The current `plan/1` predicate is still only a placeholder, so I need to add validation and conversion logic before replacing it with the real version.

### Plan for this session
- Add safer wrapper predicates for optional restriction facts
- Update the existing helpers to use the safe wrappers
- Add validation for workstation minimum and maximum worker counts
- Add conversion from internal `slot/5` structures into the required `workstation/2` schedule format
- Build the final `plan(Morning, Evening, Night)` structure
- Replace the temporary failing `plan/1` placeholder with real scheduling logic
- Test `plan(Plan).` with `example-input-1.pl`
- Commit each major code block separately
- Add an end-of-session reflection
- Push the session progress to GitHub

-------------------------------------------------------------------------------------------------------------

## 2026-05-10 8:12 PM --- Session 10 - Validation and Plan Logic Tested

### Progress made
This session completed the main scheduling logic for `plan/1`.

I first added safe wrapper predicates for optional facts such as `workstation_idle/2`, `avoid_shift/2`, and `avoid_workstation/2`. This helps avoid errors if a test file does not define one of those predicates.

Next, I added validation helpers for workstation capacity. These helpers check that each slot has at least the required minimum number of workers and no more than the maximum number of workers.

After that, I added conversion helpers to turn the internal `slot(Shift, Station, Min, Max, Workers)` structure into the final required `plan(Morning, Evening, Night)` format using `workstation(Station, Workers)` entries.

I initially tried a direct plan generation approach that assigned all employees first and checked minimums at the end, but it was too slow because Prolog had to search through too many invalid possibilities. I replaced it with a minimum-first strategy that fills each workstation's required minimum first, then assigns remaining employees afterward. This made `once(plan(_)).` return quickly.

### Testing completed
I tested the program with all five provided example input files.

- `example-input-1.pl` returned a valid plan and passed checks for no missing work, no double work, Ophelia's workstation restrictions, Daniel's night shift restriction, and workstation 3 being idle in the morning.
- `example-input-2.pl` correctly returned `false` because one workstation has a minimum greater than its maximum.
- `example-input-3.pl` returned a valid plan and passed Daniel's morning and evening shift restrictions.
- `example-input-4.pl` returned a valid plan and passed Iris's workstation restrictions, Sarah's night shift restriction, and Ulysses's morning shift restriction.
- `example-input-5.pl` returned a valid plan and passed Ophelia's morning shift restriction.

### Notes
The repeated names printed during some tests came from the provided `testing.pl` file, not from my project code. The important part is that the final query results returned `false` for invalid conditions like `no_work/2`, `double_work/2`, and restricted assignments.

The main logic now appears to satisfy the major project requirements. The next step is to clean up the code, add helpful comments, write the README, and prepare the final submission.

### Next step
Next, I plan to do final cleanup. This includes improving formatting if needed, adding comments, creating `README.md`, doing one more clean test run, checking Git status, pushing to GitHub, and preparing the zip file for submission.

-------------------------------------------------------------------------------------------------------------

## 2026-05-10 8:35 PM --- Session 10B - Missing Input Guard

### Thoughts so far
After completing the main plan logic, I tested loading only `project2.pl` without first consulting an example input file. This caused an unknown procedure error for `employee/1`, because the employee facts come from the separate input files.

The project prompt assumes that a facts file will be consulted with the project code, but I still want the program to behave more safely if the input facts have not been loaded yet. Instead of throwing an error, `plan/1` should simply fail when the required input predicates are missing.

### Plan for this session
- Add an `input_ready/0` helper predicate
- Update `plan/1` so it only runs when required input predicates exist
- Add guards around employee and workstation collection helpers
- Test that loading only `project2.pl` makes `plan(Plan).` return false instead of an error
- Retest with `example-input-1.pl` to make sure the real scheduling logic still works
- Commit and push the fix

-------------------------------------------------------------------------------------------------------------

## 2026-05-10 8:50 PM --- Session 10B - Missing Input Guard Tested

### Progress made
I added an input readiness guard to `project2.pl`. The new `input_ready/0` helper checks that the required input predicates, especially `employee/1` and `workstation/3`, exist before `plan/1` tries to generate a schedule.

I also added guards around employee and workstation collection helpers so that the program fails cleanly instead of throwing an unknown procedure error if the input facts have not been loaded.

### Testing completed
I tested loading only `project2.pl` and then querying `plan(Plan).`. Before this fix, that caused an unknown procedure error for `employee/1`. After the fix, the query returned `false`, which is safer behavior.

I also retested normal behavior by loading `example-input-1.pl` before `project2.pl`, then running `once(plan(_)).`. The query returned `true`, so the real scheduling logic still works when the required facts are loaded.

### Notes
The project prompt assumes that the facts file will be consulted with the project code, but this guard makes the program more robust in case the grader or user accidentally loads only `project2.pl`.

### Next step
Next, I plan to do final cleanup, add comments, write the README, run a final test, push to GitHub, and prepare the zip file for submission.

-------------------------------------------------------------------------------------------------------------

## 2026-05-10 9:30 PM --- Session 11 - Final Cleanup and Submission Prep

### Thoughts so far
The main scheduling logic for `plan/1` is now working. The program was tested with all five provided example input files. The valid examples returned schedules, and the impossible example correctly returned false.

I also added an input readiness guard so that loading only `project2.pl` and querying `plan(Plan).` fails safely instead of throwing an unknown predicate error.

The current code satisfies the major project requirements: every employee is assigned exactly once, workstation minimum and maximum limits are checked, idle workstations are avoided, restricted workstations are avoided, and restricted shifts are avoided.

### Plan for this session
- Add comments to `project2.pl` explaining the major helper predicates
- Make sure the code is formatted clearly
- Add a `README.md` file explaining the project files and how to run the program
- Run a final quick test
- Add final devlog notes
- Check that Git status is clean
- Push the final version to GitHub
- Prepare the repository zip file for submission

-------------------------------------------------------------------------------------------------------------

## 2026-05-10 11:28 PM --- Session 11 - Final Cleanup Completed

### Progress made
I completed the final cleanup for the project. I added clear comments to `project2.pl` explaining the major sections of the program, including the main `plan/1` predicate, input helpers, eligibility checks, internal slot representation, minimum-first scheduling, capacity validation, and conversion to the required `plan/3` format.

I also added a `README.md` file explaining the project overview, the purpose of each file, how to run the program, how to use the provided testing helpers, and notes about the internal slot structure.

### Testing completed
I ran a final quick test by loading `example-input-1.pl`, loading `project2.pl`, and running `once(plan(_)).`. The query returned true, confirming that the final cleaned version still generates a valid plan.

Earlier testing also confirmed that all five provided examples behave correctly, including the impossible case returning false.

### Notes
The repository now contains the source code, provided examples, testing file, README, and development log. The commit history and devlog show the project being developed in multiple sessions with testing after each major feature.

### Next step
The final step is to make sure Git status is clean, push the final version to GitHub, and zip the entire repository folder for submission.

