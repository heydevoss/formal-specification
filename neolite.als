module neolite

-----------------------------------------------------------------------------------------------------------
-- SIGNATURES
-----------------------------------------------------------------------------------------------------------

sig Organization {
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

-----------------------------------------------------------------------------------------------------------
-- TESTS
-----------------------------------------------------------------------------------------------------------

assert testUniqueOrganization {
	one Organization
}

check testUniqueOrganization for 20

assert testOrganizationMustHaveSomeMember {
	all o: Organization | #(o.orgMembers) > 0
}

check testOrganizationMustHaveSomeMember for 20

assert testTeamMustHaveSomeMember {
	all t: Team | #(t.teamMembers) > 0
}

check testTeamMustHaveSomeMember for 20

assert testMemberMustBeOrganizationMember {
	all m: Member | #(m.~orgMembers) = 1
}

check testMemberMustBeOrganizationMember for 20

assert testTeamMustBePartOfOrganization {
	all t: Team | #(t.~teams) = 1
}

check testTeamMustBePartOfOrganization for 20

assert testRepositoryMustBePartOfOrganization {
	all r: Repository | #(r.~repositories) = 1
}

check testRepositoryMustBePartOfOrganization for 20

assert testOrganizationWithNoTeams {
	lone o: Organization | #(o.teams) = 0
}

check testOrganizationWithNoTeams for 20

pred show[]{}
run show for 10
