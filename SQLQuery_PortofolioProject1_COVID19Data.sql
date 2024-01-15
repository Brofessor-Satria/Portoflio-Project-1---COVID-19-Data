--SELECT *
--FROM CovidDeaths
--ORDER BY 3,4

--SELECT *
--FROM CovidVaccinations
--ORDER BY 3,4

--Showing the Data

--SELECT location, date, total_cases, total_deaths, population
--FROM Deaths
--ORDER BY 1,2

--Looking at Death to Cases Percentage
--SELECT location, date, total_cases, total_deaths, (CAST (total_deaths as int)*100 / CAST (total_cases as int)) AS Death_Percentage
--FROM Deaths
--WHERE total_cases IS NOT NULL
--ORDER BY 1,2

--SELECT location, date, total_cases, total_deaths, (total_deaths) / (total_cases)*100 AS Death_Percentage
--FROM Deaths
--ORDER BY 1,2

--SELECT location, population, MAX(total_deaths) as Max_Deaths, MAX((CAST (total_deaths as int)*100 / population)) AS Death_Percentage
--FROM Deaths
--WHERE total_cases IS NOT NULL
--GROUP BY location, population
--ORDER BY 4 DESC

--SELECT continent, MAX(total_deaths) as Max_Deaths
--FROM Deaths
--WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY 2 DESC

--SELECT SUM(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)*100/sum(new_cases) AS Percentage_
--FROM Deaths
--WHERE continent IS NOT NULL

--SELECT dea.location, dea.date, dea.continent, vac.new_vaccinations,
--SUM (Convert(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.date) AS SUM_NEWVAC
--FROM Deaths dea
--Join Vaccinations vac
--	ON dea.date = vac.date
--	and dea.location = vac.location
--WHERE dea.continent is not null
--ORDER BY dea.location, dea.date

DROP TABLE IF EXISTS #PopvsVac
CREATE TABLE #PopvsVac 
(location varchar(100),
date datetime,
continent varchar(100),
population numeric,
new_vac numeric,
rollingpeoplevaccinated numeric)

INSERT INTO #PopvsVac
SELECT dea.location, dea.date, dea.continent, population, new_vaccinations, 
SUM (Convert(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.date) AS SUM_NEWVAC
FROM Deaths dea
Join Vaccinations vac
	ON dea.date = vac.date
	and dea.location = vac.location
WHERE dea.continent is not null

SELECT *, rollingpeoplevaccinated/population AS RollperPop
FROM #PopvsVac




