module neolite

sig organization {
	members: set Member,
	repositories: set Repository,
	teams: set Team
}

sig Member {}

sig Repository {}

sig Team {	
	members: set Member
}
