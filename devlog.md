# Development Log

## 2026-05-05 Session 1 - Setup and Planning

### Thoughts so far
I am starting CS4337 Project 2. This project is about writing a Prolog backend that generates a work schedule. The main predicate I need to implement is plan/1. The input facts will describe employees, workstations, idle workstation shifts, employees who should avoid certain workstations, and employees who should avoid certain shifts.

The required output is a plan/3 structure with three schedules: morning, evening, and night. Each shift schedule should contain workstation/2 structures, where each workstation has a list of employees assigned to it.

The most important rules are that every employee must work exactly one workstation for exactly one shift, workstation minimum and maximum limits must be respected, idle workstations should not appear in a shift schedule, and employee restrictions must be followed.

### Plan for this session
For this first session, I plan to set up the local Git repository, create the development log, make the initial commit, create a GitHub repository, connect the local repository to GitHub, and push the first commit. After that, I will begin adding the provided project files in the next step.


## 2026-05-05 Session 1 - GitHub Setup Update

### Progress made
I initialized the local Git repository, created the main branch, made the first commit with the development log, created a private GitHub repository, connected the local repository to the GitHub remote, and successfully pushed the first commit.

### Notes
The GitHub remote is set to:
https://github.com/Nitin-UTD/cs4337-project2.git

The local branch main is now tracking origin/main. This means future commits can be pushed with git push.

### Next step
Next, I plan to add the provided Project 2 files, including the testing file, example input files, and example output files. After that, I will begin creating the first Prolog project file.
