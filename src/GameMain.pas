program GameMain;
uses SwinGame, SysUtils;
const
	ARRAY_SIZE = 20;

type
	NumberArray = Array [0..19] of Integer;

procedure PopulateArray(var data : NumberArray);
var
	i: Integer;
begin
	for i := Low(data) to High(data) do 
		data[i] := Rnd(ScreenHeight());
end;
procedure ShowNumbersInList(var data: NumberArray);
var
	i: Integer;
begin
	ListClearItems('NumbersList');
	For i := Low(data) to High(data) do
		ListAddItem('NumbersList', IntToStr(data[i]));
end;
procedure PlotBars(var data: NumberArray);
var
	barWidth, i: Integer;
begin
	ClearScreen(ColorWhite);
	barWidth := Round((ScreenWidth() - PanelWidth('NumberPanel'))/ARRAY_SIZE);

	for i := Low(data) to High(data) do
		FillRectangle(ColorRed, barWidth * i, 600 - data[i], barWidth, data[i]);
	DrawInterface();
	RefreshScreen(60);
end;
procedure NumberSwap(var value1: Integer; var value2: Integer);
var
	tmp: Integer;
begin
	tmp := value1;
	value1 := value2;
	value2 := tmp;
end;
procedure BubbleSort(var data: NumberArray);
var
	i, j: Integer;	
begin
	for i:= High(data) downto Low(data) do
	begin
		for j := Low(data) to i - 1 do
			if (data[j] > data [j+1]) then
			begin
				NumberSwap(data[j+1], data[j]);
				ShowNumbersInList(data);
				PlotBars(data);
				Delay(100);
			end;
	end;
end;
procedure InsertionSort(var data: NumberArray);
var
	i, j: Integer; 
begin
	for i := Low(data) to High(data) - 1 do
	begin
		for j := i + 1 to High(data) do
			if (data[i] > data[j]) then
			begin
				NumberSwap(data[i], data[j]);
				ShowNumbersInList(data);
				PlotBars(data);
				Delay(100);
			end; 
	end;
end;
procedure DoInsertionSort();
var
	data : NumberArray;
begin
	PopulateArray(data);
	ShowNumbersInList(data);
	PlotBars(data);
	InsertionSort(data);
end;

procedure DoBubbleSort();
var
	data : NumberArray;
begin
	PopulateArray(data);
	ShowNumbersInList(data);
	PlotBars(data);
	BubbleSort(data);
end;

procedure Main();
begin
  OpenGraphicsWindow('Hello World', 800, 600);
  
  LoadResourceBundle( 'NumberBundle.txt' );
  
  GUISetForegroundColor( ColorBlack );
  GUISetBackgroundColor( ColorWhite );
  
  ShowPanel( 'NumberPanel' );
  
  ClearScreen(ColorWhite);
  repeat
  	ProcessEvents();
  	UpdateInterface();
  	DrawInterface();
  	RefreshScreen(60);
  	if ButtonClicked('InsertionSortButton') then
  		DoInsertionSort();
  	if ButtonClicked('BubbleSortButton') then
  		DoBubbleSort();
  until WindowCloseRequested();
  Delay(1000);
end;

begin
	Main();
end.