protocol
draw
	| size rtNodes edges |
	
	view elements do: [ :e | view removeElement: e ].
	
	size := timeline size.
	rtNodes := Array new: size.
	edges := Array new: size - 1.
	timeline nodesDoWithIndex: [ :n :i | 
			| rtNode |
			rtNode := RTElement new
				+
					(RTEllipse new
						size: (self sizeFor: n);
						color: (self colorFor: n)).
			rtNode model: n.
			rtNode translateBy: (self translateValue) + (((i - 1) * self distanceBetweenNodes) @ 0).
			rtNode
				on: TRMouseEnter
				do: [ :e | self popupFor: rtNode event: e ].
			rtNodes at: i put: rtNode.
			i > 1
				ifTrue: [ 
					| edge |
					edge := RTEdge from: (rtNodes at: i - 1) to: rtNode.
					edge + (RTLine new color: (self colorForLink: n sourceLink)).
					edge 
						on: TRMouseEnter
						do: [ :e | self popupForEdge: edge node: n event: e ].
					edges at: i - 1 put: edge ] ].
	
	edges do: [ :e | view add: e ].
	rtNodes do: [ :e | view add: e ].
	
	self moveCamera.
	canvas signalUpdate.