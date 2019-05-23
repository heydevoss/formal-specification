module neolite

sig organization {
	orgMembers: set Member,
	repositories: set Repository,
	teams: set Team
}

sig Member {}

sig Repository {}

sig Team {	
	teamMembers: set Member
}

-----------------------------------------------------------------------------------------------------------
-- FACTS
-----------------------------------------------------------------------------------------------------------

fact uniqueOrganization {
	one Organization
}

fact organizationMustHaveSomeMember {
	all o: Organization | some o.orgMembers
}

fact teamMustHaveSomeMember {
	all t: Team | some t.teamMembers
}

fact memberMustBeOrganizationMember {
	all m: Member | one m.~orgMembers
}

fact teamMustBePartOfOrganization {
	all t: Team | one t.~teams
}

fact repositoryMustBePartOfOrganization {
	all r: Repository | one r.~repositories
}

pred show[]{}
run show for 10
