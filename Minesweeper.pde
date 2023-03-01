import de.bezier.guido.*;
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private int NUM_MINES = NUM_ROWS*4;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(1000, 800);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++)
      for (int c = 0; c < NUM_COLS; c++)
        buttons[r][c] = new MSButton(r,c);
    
    for (int i = 0; i < NUM_MINES; i++)
      setMines();
}
public void setMines()
{
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if (mines.contains(buttons[row][col]))
      setMines();
    else
      mines.add(buttons[row][col]);
      
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
  if (isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1]))
    numMines++;
  if (isValid(row-1, col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if (isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
  if (isValid(row, col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if (isValid(row, col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if (isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if (isValid(row+1, col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if (isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;
  return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width =1000/NUM_COLS;
        height = 1000/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
      clicked = true;
        if (mouseButton == RIGHT)
        {
          flagged = !flagged;   
          clicked = !clicked;
        }
        else if (mines.contains(this))
          displayLosingMessage();
        else if (countMines(myRow, myCol) > 0)
          myLabel = countMines(myRow, myCol)+"";
        else  
        {
        if (isValid(myRow, myCol-1)&&buttons[myRow][myCol-1].clicked==false)
      buttons[myRow][myCol-1].mousePressed();
    if (isValid(myRow+1, myCol)&&buttons[myRow+1][myCol].clicked==false)
      buttons[myRow+1][myCol].mousePressed();
    if (isValid(myRow-1, myCol)&&buttons[myRow-1][myCol].clicked==false)
      buttons[myRow-1][myCol].mousePressed();
    if (isValid(myRow, myCol+1)&&buttons[myRow][myCol+1].clicked==false)
      buttons[myRow][myCol+1].mousePressed();
        }
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
