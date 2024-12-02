# for now, from exercise 1
class_name AttackCommand
extends Command


func execute(_character:Character) -> Status:
	print('attacked')
	return Status.DONE
