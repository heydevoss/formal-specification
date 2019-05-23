module neolite

-----------------------------------------------------------------------------------------------------------
-- Signatures
-----------------------------------------------------------------------------------------------------------

sig Organization {
	repositories: set Repository,
	orgMembers: set Member,
	teams: set Team
}

sig Team {
	teamMembers: set Member
}

sig Repository { }

sig Member { }

-----------------------------------------------------------------------------------------------------------
-- Facts
-----------------------------------------------------------------------------------------------------------

fact uniqueOrganization {
	one Organization
}

fact organizationHasMembers {
	all o: Organization | some o.orgMembers
}

fact teamsHaveMembers {
	all t: Team | some t.teamMembers
}

fact repositoriesBondedToOrganization {
	all r: Repository | one r.~repositories
}

fact membersBondedToOrganization {
	all m: Member | one m.~orgMembers
}

fact teamsBondedToOrganization {
	all t: Team | one t.~teams
}

-----------------------------------------------------------------------------------------------------------
-- Predicates
-----------------------------------------------------------------------------------------------------------

pred show[] { }

-----------------------------------------------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------------------------------------------

fun getOrganizationRepositories [o: Organization] : set Repository {
    Repository & o.repositories
}

fun getOrganizationMembers [o: Organization] : set Member {
    Member & o.orgMembers
}

fun getOrganizationTeams [o: Organization] : set Team {
    Team & o.teams
}

fun getTeamMembers [t: Team] : set Member {
	Member & t.teamMembers
}

fun getNonTeamMembers [t: Team] : set Member {
	Member - t.teamMembers
}

-----------------------------------------------------------------------------------------------------------
-- Asserts
-----------------------------------------------------------------------------------------------------------

assert testUniqueOrganization {
	one Organization
}

assert testOrganizationMustHaveSomeMember {
	all o: Organization | #(o.orgMembers) > 0
}



assert testTeamMustHaveSomeMember {
	all t: Team | #(t.teamMembers) > 0
}

assert testMemberMustBeOrganizationMember {
	all m: Member | #(m.~orgMembers) = 1
}

assert testTeamMustBePartOfOrganization {
	all t: Team | #(t.~teams) = 1
}

assert testRepositoryMustBePartOfOrganization {
	all r: Repository | #(r.~repositories) = 1
}

assert testOrganizationWithNoTeams {
	lone o: Organization | #(o.teams) = 0
}

-----------------------------------------------------------------------------------------------------------
-- Checks
-----------------------------------------------------------------------------------------------------------

check testUniqueOrganization for 20
check testOrganizationMustHaveSomeMember for 20
check testTeamMustHaveSomeMember for 20
check testMemberMustBeOrganizationMember for 20
check testTeamMustBePartOfOrganization for 20
check testRepositoryMustBePartOfOrganization for 20
check testOrganizationWithNoTeams for 20

-----------------------------------------------------------------------------------------------------------
-- Show
-----------------------------------------------------------------------------------------------------------

run show for 10
