on findLastTargetIndex(targetItem, itemList)
	set lastIndex to 0
	repeat with i from (count of itemList) to 1 by -1
		if item i of itemList is targetItem then
			set lastIndex to i
			exit repeat
		end if
	end repeat
	return lastIndex
end findLastTargetIndex

tell application "System Settings"
	activate
	delay 1
	tell application "System Events"
		tell process "System Settings"
			set menuItemName to "Displays"
			set menuBarItemName to "View"
			set addButtonName to "Add"
			
			click menu item menuItemName of menu menuBarItemName of menu bar item menuBarItemName of menu bar 1
			delay 0.3
			tell group 1 of group 3 of splitter group 1 of group 1 of window menuItemName
				try
					delay 1
					click menu button 1
					set menuItems to name of menu items of menu 1 of menu button 1
					set targetIndex to (my findLastTargetIndex("Pelix Fatryjas", menuItems))
					delay 0.3
					click menu item targetIndex of menu 1 of menu button 1
				on error
					delay 0.5
					do shell script "afplay /System/Library/Sounds/Hero.aiff"
				end try
			end tell
		end tell
	end tell
end tell
delay 1

tell application "System Settings" to quit