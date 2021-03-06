private
popupClasses
	| menu |
	
	package value ifNil: [ ^ self ].
	menu := MenuModel new
		addGroup: [ :g |
			g addItem: [ :item | 
				item 
					name: 'Add class';
					icon: Smalltalk ui icons smallAddIcon;
					action: [ abstractTool addClassIn: package value ] ] ];
		addGroup: [ :g || hierarchy |
			hierarchy := self buildPackageHierarchyFor: package value.
			hierarchy sortedElements do: [ :e |
				g addItem: [ :item | 
					item 
						name: (self buildTabbedNameOf: e in: hierarchy);
						icon: (self classIconFor: e) form;
						action: [ 
							(self browsedClass: e) ifTrue: [ self registerManualNavigation ] ] ] ] ];
		addGroup: [ :g || hierarchy |
			hierarchy := self buildPackageExtensionHierarchyFor: package value.
			hierarchy sortedElements do: [ :e |
				g addItem: [ :item | 
					item 
						name: (self buildTabbedNameOf: e in: hierarchy);
						icon: (self classIconFor: e) form;
						action: [ 
							(self browsedClass: e) ifTrue: [ self registerManualNavigation ] ] ] ] ].
			
	menu openWithSpecAt: classButton widget widget bottomLeft.
	menu applyTo: self.