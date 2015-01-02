package assembler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;
import assembler.AssemblerCode;


/*
 * This class is the main entry point for the program
 * 
 * NOTES:
 * 	~ Be sure to have "AssemblerCode" and "binToHex" 
 * 		in the package and imported into this class
 * 
 * 	~ User will be prompted to input  name of Assembly code file,
 * 		Machine Code file you would like to create/overwrite,
 * 		and the Hex representation file to create/overwrite
 * 		
 * 		- The Assembly code file MUST be a .txt file (or I will try
 * 		  to convert it to one and it might not work)
 * 
 * 		- When inputting the file names to the command prompt
 * 		  DO NOT include the ".txt" extension - I include it 
 * 		  internally
 * 
 * 		- the Assembly Code file must be INSIDE the Assembler 
 * 		  package but OUTSIDE the src folder where the .java 
 * 		  files are located
 * 
 * 		- The Machine Code file must be in the same folder as your
 * 		  Assembly Code if you wish to write a hex conversion file. 
 * 		  Change the location on line 95 and only change the part 
 * 		  between the "  ". 
 * 
 *  ~ In "binToHex" you also must change the location of the file
 *  	being written to. This is on line 15. This location can be
 *  	anywhere you'd like.
 * 
 * 
 */
public class AssemblerMain {
	
	/**
	 * Main entry point of the program
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException 
	{	
		AssemblerCode a = new AssemblerCode();
		String[] files = new String[3];	// index 0: machine, index 1: assembly, index 2: hex rep
		a.buildTables();
		files = a.loadFile(); 		    // Prompt console and load in Assembly Code file (.txt) - 1st index is machine file, 2nd is assembly file
		String machineName = files[0];
		String hexRepName  = files[2];
		a.lineNumber(false);
		
		// Do the first pass through the file
		Scanner s = null;
		try 
		{
			s = new Scanner(new File(files[1]));
		} 
		
		catch (FileNotFoundException e) {
			e.printStackTrace();}
		
		while(s.hasNextLine()){
			String nextLine = s.nextLine();
			System.out.println("*" + nextLine);
			a.passOne(nextLine);	
			
		}
		s.close();
		
		
		//a.debugLabels();
		a.printLabels();
		
		//Do the second pass through the file									
		// reset the line count
		a.lineNumber(false);
		
		try 
		{
			s = new Scanner(new File(files[1]));
		} 
		
		catch (FileNotFoundException e) {
			e.printStackTrace();}
		
		try {
			
			// This makes a new Machine Code File or Overwrites the old file
			File file = new File(files[0]);
 
			// if file doesn't exist, then create it
			if (!file.exists()) {
				file.createNewFile();
			}
 
			// make a new file writer and line writer
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			
			// make a new scanner of the Assembly Code file to scan line by line
			try 
			{
				s = new Scanner(new File(files[1]));
			} 
			
			catch (FileNotFoundException e) {
				e.printStackTrace();}
			String line = "";
			
			System.out.println("\n\nAssembly Code:");
			// move through each line in the Assembly Code file
			while(s.hasNextLine()){
				
				// write the instruction from passTwo to the file
				line = s.nextLine();
				String nextLine = a.passTwo(line);
				if (nextLine.length()>0){					// if it isn't a blank line write the machine code
					bw.write(nextLine);
					bw.newLine();	
				}
			}
			s.close();
			bw.close();
 
			System.out.println("\n"+machineName + " written");
			
			binToHex.main(args, machineName, hexRepName);
 
		} 
		
		catch (IOException e) {
			e.printStackTrace();
		}
	}
}






