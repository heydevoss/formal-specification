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

fact singleOrganization {
	one Organization
}

fact organizationHasMembers {
	all o: Organization | some o.orgMembers
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

fact TeamsAndMembersBondedToSameOrganization {
	all t: Team, m: Member | BondingTeamsAndMembersToOrganization[t, m]
}

-----------------------------------------------------------------------------------------------------------
-- Predicates
-----------------------------------------------------------------------------------------------------------

pred BondingTeamsAndMembersToOrganization [t: Team, m: Member] {
	(m in t.teamMembers) <=> (m.~orgMembers = t.~teams)
}

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

fun getTeamMembers [o: Organization] : set Team {
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

assert testSingleOrganization {
	#Organization = 1
}

assert testOrganizationHasMembers {
	all o: Organization | #(getOrganizationMembers[o]) > 0
}

assert testTeamsHaveMembers {
	all t: Team | #(getTeamMembers[t]) > 0
}

assert testRepositoriesBondedToOrganization {
	all r: Repository | #(r.~repositories) = 1
}

assert testMembersBondedToOrganization {
	all m: Member | #(m.~orgMembers) = 1
}

assert testTeamsBondedToOrganization {
	all t: Team | #(t.~teams) = 1
}

assert testOrganizationCanHaveNoTeams {
	all o: Organization | #(getOrganizationMembers[o]) >= 0
}

assert testOrganizationCanHaveNoRepositories {
	all o: Organization | #(getOrganizationRepositories[o]) >= 0
}

assert testTeamsCanHaveNoMembers {
	all t: Team | #(getTeamMembers[t]) >= 0
}

assert testTeamsAndMembersBondedToSameOrganization {
	all t: Team, m: Member | (m in t.teamMembers) => (m.~orgMembers = t.~teams)
	all t: Team, m: Member | (m.~orgMembers = t.~teams) => (m in t.teamMembers)
}

-----------------------------------------------------------------------------------------------------------
-- Checks
-----------------------------------------------------------------------------------------------------------

check testSingleOrganization for 20
check testOrganizationHasMembers for 20
check testTeamsHaveMembers for 20
check testRepositoriesBondedToOrganization for 20
check testMembersBondedToOrganization for 20
check testTeamsBondedToOrganization for 20
check testOrganizationCanHaveNoTeams for 20
check testOrganizationCanHaveNoRepositories for 20
check testTeamsCanHaveNoMembers for 20
check testTeamsAndMembersBondedToSameOrganization for 20

-----------------------------------------------------------------------------------------------------------
-- Show
-----------------------------------------------------------------------------------------------------------

run show for 20
