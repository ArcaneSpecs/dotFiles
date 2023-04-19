# Keys
<C>      means ctrl
<S>      means shift
<A>      means alt
<CR>     means enter
<leader> means space
<ESC>    means escape

# Word wrap
<leader>w       # Toggle word wrap
:set wrap!      # Toggle word wrap (! means toggle a boolean value, just :set wrap will set it to true, regardless of current state)

# Navigation

## Filetree navigation
j k # Up and down
l   # Open file
g?  # Open all hotkeys for filetree

Usually ? opens help menu on anything

## Undotree (tree like view of last edits and changes, all undos are non linear and you can go back to 
old revision at any time, hence why the undotree name)
<leader>u
?            # for help

## Basic movement
j k l h 
f       # Find next character in line
F       # same as f but backwards

## Quickly replacing stuff 
ci"       # Change inside quotes (you can kinda be anywhere in the quotes and it will work)
ci(       # Change inside parenthesis
di(       # Just delete inside parenthesis
di"       # or quotes or anything really
%         # Jump to matching bracket or block or parenthesis or whatever 
          # (using right shift in vim is usually the play, as it's alot easier most of the time)


// Works with any brackets, try it here
void testFunction(int argc, char** argv) 
{
    for (int i = 0; i < argc; i++) 
    {
        printf("Hello world %d", i)
    }
}

## Panel movement (left, down, up, right)
<C>h <C>j <C>k <C>l

## Split panels
<C>w s      # Horizontal split
<C>w v      # Vertical split

## Moving back to last positions
<C>o    # Go back 
<C>i    # GO forward

## Moving in the file 
gg         # Go to the top of the file
G          # Go to the bottom of the file

## Moves the view of the file
zz         # Center the current line
zt         # Move the current line to the top of the screen
zb         # Move the current line to the bottom of the screen
           # Note that there is a buffer of like 8 lines so that you can always see the context of the current line

## Line numbers
Relative line numbers are on by default and can be used to move around the file easily
by looking at the number of lines away from the current line you can do stuff like:
5yy         # Yank (copy) the next 5 lines
or 10dd     # Delete the next 10 lines


## Move by word
w e b

# Insert mode 
i      # Insert at the current position (left side of the cursor)
I      # Insert at the beginning of the line
A      # Append to the end of the line
a      # Append to the current position (a bit different that just doing i as this appends to the right side of the cursor and i inserts to the left side of the cursor)
o      # Insert a new line below the current line
O      # Insert a new line above the current line (really useful for insertion and making empty lines)
       # you can insert alot of empty lines quick by doing O<ESC>yy and then spam p or do something like 5p to paste 5 empty lines


# Visual select mode
v
V     # Select whole lines
<C>v  # Select blocks

After block select you can use I to insert stuff and then <ESC> to confirm,
if you make a mistake just u and it will undo all inserts 


# Copy and paste
y       # To Copy selection
p       # To Paste
yy      # To copy a line
P       # paste on top of the current line (this is the one that you use the most)

# Delete
dd         # Delete line
x          # Delete character
dw         # Delete word
d5w        # Delete 5 words

# Undo and redo
u                # Undo
<C>r             # Redo
<leader>u        # undo tree view

# Search
<leader>f       # Search for a file
<leader>F       # Search file contents
/               # Search in the file (press n to go to next match and N to go to previous match)
?               # Same as / but backwards (if you do / and press n and N it will toggle this automatically so it's almost never used)
:set hlsearch!  # Toggle search highlighting if it's annoying


# Search and replace
After search <C>q for panel that has search results listed (move normally with <C>j and <C>k to access and enter to jump to search)
After <C>q you can :cdo s/old_text/new_text/g to replace all the old_text with new_text in all the files in the search results

:wa to save all buffers after replacing

# Buffers
Buffers are like tabs in other text editors (can be seen on the top)
buffers are essentially open files, but they can be used to open multiple files in the same window or separate windows
like you can <C>w s to split the window and open a new file in the new window or just scroll the same buffer in two 
separate windows

H L              # Move to left or right buffer (shift + h or shift + l)
<leader>c        # Close buffer (without saving)
<leader>w        # Save buffer (saves the file)

# Config
if you press <leader> (space) you can see many of the shortcuts that are defined in the config
this is done by using whichkey nvim plugin 
if you do <leader>vc           # Go to alpha and then select configuration (alpha is kinda like a main menu)
you can see all the configuration *.lua files
<leader>f to search files or gd to hop into file when hovering over one in init.lua etc. or use the file tree (<leader>e)
config files are located in lua/user folder when you open configuration folder with <leader>vc
you can change anything at any time and then save the file (buffer) with either :w or <leader>w and then :so (sources the current buffer and applies the changes, or restart nvim)

## Use :help to get help on any command or feature
:help whatever_you_want_to_know_about 


# Motions
# Like we did in Delete section 
d5w      # Deletes next 5 words
These are called motions (the w here is a motion)
you can combine motions with operators (like d, c, y, >, <, =, !, g~)
or let's say d$        # Deletes to the end of the line (shortcut is D)
or 22x                 # Deletes next 22 characters 
or 16j                 # Moves 16 lines down

# Nieche and fun stuff

## You can use vim as a calculator
:echo (1+1)   # Prints 2
:echo sqrt(49)  # Prints 7.0
or anything more complex

## Adding and subtracting
<C>a       # To add one to a number (can be like 20<C>a to add 20 to it)
<C>x       # To subtract one to a number (can be like 20<C>x to subtract 20 from it)

## Macros 
q then any other key you want to start recording macro to

let's say qq records macro to q
go to insert mode with i and type something "hello" or what ever, esc and go down once with j or o for new line, press q to end the macro recording
and then to use the macro do @q or 20@q to use it 20 times (q here is the key that you recorded the macro to, but it could be anything, like g for example)

now 5@q should print hello 5 times in separate lines if you do it under this
NOTE: might need to be kinda quick with the @q part as @ opens register view with whichkey popup


