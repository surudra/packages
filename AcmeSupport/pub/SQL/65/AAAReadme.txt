UNZIP into C:\65       (please use folder names - to create subdirectories)
----------------------------------------------------------------------------
TO set up 15 students
(note:  delete all log files first)

1A. Run resetALLManyUsersFull.bat to drop/create the users and drop/create the tables 
     (both system and course tables will be loaded)
1B. If you need more space on Oracle then run resetALLManyUsersNoReport.bat to drop/create 
     the users and drop/create the tables (both system and course tables will be loaded).  The only
     table NOT created are the Reporting and Staging tables used in the Monitor's lowest
     panel.  This is not covered in the courses and will save you the load of a 2MB file into 
     each student database.
2.  IF the scripts do NOT work, check the Oracle Username/password.  The script assumes its SYSTEM/MANAGE 
    (found in the ".bat" files)
3. Make Oracle scale better:

In Enterprise Manager Console set:
open_cursors = 900 
processes = 300
Set PARALLEL_AUTOMATIC_TUNING = true

To set up 1 student (ISV6)

Same as above, but run resetALLOneUser.bat