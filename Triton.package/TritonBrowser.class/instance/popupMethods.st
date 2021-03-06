private
popupMethods
	| menu |
	
	protocol value ifNil: [ ^ self ].
	menu := MenuModel new
		addGroup: [ :g |
			g addItem: [ :item | 
				item 
					name: 'Add method';
					icon: Smalltalk ui icons smallAddIcon;
					action: [ self addMethod ] ].
			g addItem: [ :item | 
				item 
					name: 'Add class side method';
					icon: Smalltalk ui icons smallAddIcon;
					action: [ self halt ] ] ];
		addGroup: [ :g |
			((self browsedClass methodsInProtocol: protocol value) sorted: [:a :b | a selector <= b selector ]) do: [ :e |
				g addItem: [ :item | 
					item 
						name: e selector;
						action: [ 
							method value: e selector.
							classSide value: false.
							self registerManualNavigation ] ] ] ];
		addGroup: [ :g |
			((self browsedClass theMetaClass methodsInProtocol: protocol value) sorted: [:a :b | a selector <= b selector ]) do: [ :e |
				g addItem: [ :item | 
					item 
						name: e selector;
						action: [ 
							method value: e selector.
							classSide value: true.
							self registerManualNavigation ] ] ] ].
	
	menu applyTo: self.		
	menu openWithSpecAt: methodButton widget widget bottomLeft.
	text takeKeyboardFocus