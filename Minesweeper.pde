import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);
  // make the manager
  Interactive.make( this );

  //your code to declare and initialize buttons goes here

  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++)
  {
    for (int c = 0; c < NUM_COLS; c++)
      buttons[r][c] = new MSButton(r, c);
  }


  setBombs();
}
public void setBombs()
{
  while (bombs.size() < NUM_BOMBS)
  {
    int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_COLS);
    if (!bombs.contains(r) && !bombs.contains(c))
    { 
      bombs.add(buttons[r][c]);
      
    }
  }
}
public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  int notbomb = 0;
  for (int r = 0; r < NUM_ROWS; r++)
  {
    for (int c = 0; c < NUM_COLS; c++)
    {
      if (buttons[r][c].isClicked() == true && buttons[r][c].isMarked() == false)
      {
        notbomb++;
      }
    }
  }
  if (notbomb == NUM_ROWS*NUM_COLS - NUM_BOMBS)
  {
    return true;
  }
  return false;
}
public void displayLosingMessage()
{
  for (int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      buttons[r][c].clicked = true;
    }
  }
  buttons[10][6].setLabel("Y");
  buttons[10][7].setLabel("o");
  buttons[10][8].setLabel("u");
  buttons[10][9].setLabel("");
  buttons[10][10].setLabel("L");
  buttons[10][11].setLabel("o");
  buttons[10][12].setLabel("s");
  buttons[10][13].setLabel("e");
}
public void displayWinningMessage()
{
  buttons[10][6].setLabel("Y");
  buttons[10][7].setLabel("o");
  buttons[10][8].setLabel("u");
  buttons[10][9].setLabel("");
  buttons[10][10].setLabel("W");
  buttons[10][11].setLabel("i");
  buttons[10][12].setLabel("n");
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT)
    {
      marked = !marked;
      if (marked == false)
      {
        clicked = false;
      }
    } else if (bombs.contains(this))
    {
      displayLosingMessage();
    } else if (countBombs(r, c) > 0)
    {
      label = "" + countBombs(r, c);
    } else {
      if (isValid(r, c-1) && buttons[r][c-1].isClicked()==false)
        buttons[r][c-1].mousePressed();
      if (isValid(r-1, c) && buttons[r-1][c].isClicked()==false)
        buttons[r-1][c].mousePressed();
      if (isValid(r+1, c) && buttons[r+1][c].isClicked()==false)
        buttons[r+1][c].mousePressed();
      if (isValid(r, c+1) && buttons[r][c+1].isClicked()==false)
        buttons[r][c+1].mousePressed();
      if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked()==false)
        buttons[r-1][c-1].mousePressed();
      if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked()==false)
        buttons[r-1][c+1].mousePressed();
      if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked()==false)
        buttons[r+1][c+1].mousePressed();
      if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked()==false)
        buttons[r+1][c-1].mousePressed();
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if ((r >=0 && r <20) && (c>=0 && c < 20))
    {
      return true;
    }
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;

    if (isValid(row-1, col) && (bombs.contains(buttons[row-1][col])))
    {
      numBombs ++;
    }
    if (isValid(row+1, col) && (bombs.contains(buttons[row+1][col])))
    {
      numBombs ++;
    }
    if (isValid(row, col-1) && (bombs.contains(buttons[row][col-1])))
    {
      numBombs ++;
    }
    if (isValid(row, col+1) && (bombs.contains(buttons[row][col+1])))
    {
      numBombs ++;
    }
    if (isValid(row+1, col+1) && (bombs.contains(buttons[row+1][col+1])))
    {
      numBombs ++;
    }
    if (isValid(row+1, col-1) && (bombs.contains(buttons[row+1][col-1])))
    {
      numBombs ++;
    }
    if (isValid(row-1, col+1) && (bombs.contains(buttons[row-1][col+1])))
    {
      numBombs ++;
    }
    if (isValid(row-1, col-1) && (bombs.contains(buttons[row-1][col-1])))
    {
      numBombs ++;
    }
    return numBombs;
  }
}