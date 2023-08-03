CREATE database COVID_project;
USE COVID_project;
SELECT *
FROM covid_deaths;

-- selecting data needed
SELECT Location,date,total_cases,new_cases,total_deaths,population
FROM covid_deaths;

-- looking at total cases vs total deaths
-- shows likelihoodto die due to COVID
SELECT Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS Death_percentage
FROM covid_deaths
WHERE location like "%states%";

-- looking at tota cases vs population
-- shows what percentage die due to COVID
SELECT Location,date,total_cases,total_deaths,population,(total_cases/population)*100 AS Death_percentage
FROM covid_deaths
WHERE location like "%states%";

-- looking at countries with highest infection rate
SELECT Location,population, MAX(total_cases) AS Highest_infectionRate,MAX((total_cases/population)*100) AS PercentPopulationInfected
FROM covid_deaths
GROUP BY location,population
ORDER BY PercentPopulationInfected DESC;

-- showing continents with highest death count per population
SELECT continent, MAX(cast(total_deaths as signed)) AS TotalDeathCount
FROM covid_deaths
WHERE continent is not NUll
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Global numbers
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths AS signed)) as total_deaths,SUM(cast(new_deaths AS signed))/SUM(new_cases)*100 AS Death_percentage -- total_cases,total_deaths,(total_deaths/total_cases)*100 AS Death_percentage
FROM covid_deaths
WHERE continent is not null;
-- GROUP BY date;

-- looking at total population vs vaccination
-- USE CTE
with PopvsVac(continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition By dea.location ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated 
FROM covid_deaths as dea
JOIN covid_vaccination as vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent is not null
)
SELECT *,(RollingPeopleVaccinated/Population)*100
FROM PopvsVac;

-- TEmp Table
CREATE table PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
);
Insert into PercentPopulationVaccinated
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition By dea.location ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated 
FROM covid_deaths as dea
JOIN covid_vaccination as vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent is not null;

SELECT *,(RollingPeopleVaccinated/Population)*100
FROM PercentPopulationVaccinated;