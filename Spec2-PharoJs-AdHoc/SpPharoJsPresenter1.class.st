Class {
	#name : #SpPharoJsPresenter1,
	#superclass : #SpPresenter,
	#instVars : [
		'button2',
		'input1',
		'button1',
		'input2',
		'table',
		'tableButton1',
		'label1',
		'tableData',
		'numberInput1',
		'numberInput2'
	],
	#category : #'Spec2-PharoJs-AdHoc'
}

{ #category : #layout }
SpPharoJsPresenter1 class >> defaultLayout [

	| main row bottomRow tableControls |
	main := SpBoxLayout newTopToBottom.
	row := SpBoxLayout newLeftToRight.
	tableControls := SpBoxLayout newTopToBottom.
	tableControls add: #tableButton1.
	bottomRow := SpBoxLayout newLeftToRight.
	bottomRow
		add: #table;
		add: tableControls.
	row
		add: #input2;
		add: #button2.
	main
		add: #button1;
		add: #label1;
		add: #numberInput1;
		add: #numberInput2;
		add: #input1;
		add: row;
		add: bottomRow.
	^ main
]

{ #category : #initialization }
SpPharoJsPresenter1 >> button1Clicked [

	self inspect.
	"input adapter inspect"
]

{ #category : #initialization }
SpPharoJsPresenter1 >> button2Clicked [

	"Color random ifNotNil: [ :clr |"

	"input enabled: input isEnabled not"

	"	button2 color: clr.
		button2 label: clr asHexString."

	"input text: 'Button changed to color #' , clr asHexString."

	"	button2 label:"

	"input adapter selectionInterval displayString."

	"	'Selected: ' , input1 selectedText."

	input2 text: DateAndTime now asString.
	input2 color: Color random muchLighter 
]

{ #category : #initialization }
SpPharoJsPresenter1 >> connectPresenters [

	button1 action: [ self button1Clicked ].
	button2 action: [ self button2Clicked ].
	input1 whenTextChangedDo: [ :t | self input1TextChangedTo: t ].
	input1 whenSelectionChangedDo: [ :t | self input1SelectionChanged ].
	input2 whenTextChangedDo: [ :t | self input2TextChangedTo: t ].
	tableButton1 action: [ self tableButton1Clicked ].
	numberInput1 whenNumberChangedDo: [ :n |
		self numberInput1ChangedToNumber: n ]
]

{ #category : #initialization }
SpPharoJsPresenter1 >> initializePresenters [

	button1 := self newButton.
	button1
		label: 'Inspect presenter';
		color: Color yellow.
	label1 := self newLabel.
	label1 label: 'label1'.
	input1 := self newTextInput.
	input1 placeholder: 'input1 ... '.
	input2 := self newTextInput.
	input2 placeholder: 'input2 ...'.
	numberInput1 := self newNumberInput.
	self whenDisplayDo: [ numberInput1 number: 42 ].
	numberInput2 := self newNumberInput
		                beFloat;
		                digits: 3;
		                climbRate: 0.005;
		                minimum: 10.005;
		                maximum: 20.05.
	button2 := self newButton.
	button2
		label: 'Click me2';
		color: Color green lighter.
	self initializeTable.
	tableButton1 := self newButton.
	tableButton1
		label: 'select some random items';
		color: Color orange lighter
]

{ #category : #initialization }
SpPharoJsPresenter1 >> initializeTable [

	table := self newTable.
	table
		addColumn: (SpIndexTableColumn title: 'ID' evaluated: #id);
		addColumn: ((SpImageTableColumn
				  title: 'Icon'
				  evaluated: [ :aClass | self iconNamed: aClass systemIconName ])
				 width: 50;
				 displayAlignment: [ :each | SpColumnAlignment center ];
				 yourself);
		addColumn: (SpStringTableColumn title: 'Class' evaluated: #name);
		addColumn: ((SpStringTableColumn
				  title: 'Methods'
				  evaluated: [ :e | e numberOfMethods displayString ])
				 displayAlignment: [ :each | SpColumnAlignment right ];
				 yourself);
		addColumn: ((SpStringTableColumn
				  title: 'Instvars'
				  evaluated: [ :e | e instVarNames size displayString ])
				 displayAlignment: [ :each | SpColumnAlignment right ];
				 yourself);
		addColumn: ((SpCheckBoxTableColumn
				  title: 'has vars'
				  evaluated: [ :e | e instVarNames size > 0 ])
				 displayAlignment: [ :each | SpColumnAlignment center ];
				 yourself);
		items: self tableData;
		beMultipleSelection
]

{ #category : #initialization }
SpPharoJsPresenter1 >> input1SelectionChanged [
	button2 label: input1 selectedText.

	
]

{ #category : #initialization }
SpPharoJsPresenter1 >> input1TextChangedTo: t [

	input2 text: t.
	"input2 takeKeyboardFocus "
]

{ #category : #initialization }
SpPharoJsPresenter1 >> input2TextChangedTo: t [

	input1 text: t.

]

{ #category : #initialization }
SpPharoJsPresenter1 >> numberInput1ChangedToNumber: n [

	numberInput2 number: n squared
]

{ #category : #initialization }
SpPharoJsPresenter1 >> tableButton1Clicked [

	table selectIndexes: ((1 to: 3) collect: [ :e | self tableData size atRandom ])
]

{ #category : #initialization }
SpPharoJsPresenter1 >> tableData [

	tableData ifNil: [ tableData := Object withAllSubclasses first: 5 ].
	^ tableData
]
