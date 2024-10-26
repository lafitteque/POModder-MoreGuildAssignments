extends "res://stages/loadout/AssignmentDisplay.gd"


func setAssignment(id:String, isChallengeMode := false):
	super.setAssignment(id,isChallengeMode)
	print(id)
	if assignment.goalvalue is PropertyCheck and assignment.goalvalue.property_key.ends_with("remainingtiles"):
		%GoalLabel.text = tr("assignment.goaltype.mineall")
