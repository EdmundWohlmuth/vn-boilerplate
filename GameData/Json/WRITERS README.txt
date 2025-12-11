Some notes on creating Dialogues:

1. The pre-exisiting dialogues are a great resource to refrence

2. the last number in a dialogue to be played must have one of the following:
  a. "Options": true,
     "Options_Num": (your int here),
     "Option_(option int)_Name": (String that the button option will use),
     "Go_To_Text_(option int)": (String that correlates to the dialogue to use)
    
  b.  "Goto": true,
      "Goto_Text": (String that correlates to the dialogue to goto)
      
  c. "End_Chapter": true,
     "Chapter_Index": (your int here)
     "Goto_Text:: (String that correlates to the dialogue to goto)

3. You can have as many (hyperbole, you can only have ten (10)) options as 
   you want, just be sure they follow the correct naming scheme
  
4. Example Dialogue, with notes after the #
  {
    "TEST_DIALOGUE": # Name of this dialogue chain
    {
      "0": # Dialogue number, like any good program we start at 0
      {
      "Name": "FELUNA", # This text is put at the top where the character's name goes
      "Text": "I would be funny but this is a [color=blue] L E A R N I N G[/color] experience.", # the main body of the dialogue box, note the use of BBCode with [color=][/color]
      "Face": 1, # sprite / animation / whatever the character will use
      
      "Goto": true, # Denotes that once this ends it will find a dialogue in this JSON by the String provided below
      "Goto_Text": "TEST_DIALOGUE_2" # This is the string provided, it MUST be in this json file, otherwise use "End_Chapter"=true
      },
      
      # Now here's an example without the notes - although, note in the code this would never be reached
      #  because above we would go to "TEST_DIALOGUE_2" when it finishes
      
      "1": 
      {
      "Name": "FELUNA",
      "Text": "Isn't learning [color=red]fun[/color]...?",
      "Face": 1,
      
      "Options": true,
      "Options_Num": 3,
      
      "Option_0_Name": "Option 1",
      "Go_To_Text_0": "TEST_2",
      
      "Option_1_Name": "Option 2",
      "Go_To_Text_1": "TEST_3",
      
      "Option_2_Name": "Option 3",
      "Go_To_Text_2": "TEST_4",  
      }
    }
  
  # EXAMPLE FINISHED
