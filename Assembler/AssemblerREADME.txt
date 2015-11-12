README for using the Assembler file

1. Download 'Assembler.jar' file and put into new folder

2. Write assembly code using format described in 'Assembly Documentation'

3. Save assembly code with '.txt' extension and save in same folder as
   'Assembler.jar'

4. Run and compile assembly code to create machine code and hexidecimal
   represenatation file of machine code
   
   I.   Open Command Prompt or Terminal
   II.  'cd' into directory containing 'Assembler.jar' and assembly code
   III. Type following line into Command Prompt/Terminal to run Assembler:

   			java -jar Assembler.jar

   IV.  At this point user will prompted to input names of assembly code,
   		desired name for machine code file, and desired name for the
   		hexidecimal representation file. DO NOT include '.txt' or other
   		extension names here. Assembler automatically adds '.txt' to file.
   		Machine code and hexidecimal representation files will be created
   		or overwritten in the same directory.

   		NOTE:
   		Output to Command Prompt/Terminal will be numbered lines of 
   		assembly code. If there is no error, the last two lines will 
   		say that the two files were created successfully. If there is an
   		error, the last line of assembly code that was able to compile 
   		in Assembler will be the last line of output to CP/Terminal. The
   		line proceeding this will be the line that includes the error.

   		If CP/Terminal says that machine code was written but the 
   		hexidecimal code could not be written, then one of the lines of 
   		machine code was not 32 bits. Go into the machine code file and
   		find the line number that isn't 32 bits or has a 'null' value in
   		it. Match that line number with the line number from the output
   		into CP/Terminal to find the line with the error. 