select * 
FROM dbo.CovidDeaths
order by 3,4
where continent is not null;


--select * 
--FROM dbo.CovidVaccinations
--order by 3,4;

-- Let's select the data that we are going to be using
Select location, date, total_cases,new_cases,total_deaths,population
FROM dbo.CovidDeaths
where continent is not null;
order by 1,2;

--- Looking at the total cases vs. Total Deaths
--- shows likelihood of dying if you contract covid in your country
Select location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 As deathpercentage
FROM dbo.CovidDeaths 
where location like '%states%' and where continent is not null
order by 1,2;

--- total cases vs population
--- shows what percentage of population got covid

Select location, date, population,total_cases, (total_cases/population)*100 As PercentPopulationInfected
FROM dbo.CovidDeaths 
where location like '%states%' and where continent is not null
order by 1,2;

-- Looking at countries with highest infection rates compared to population

Select location, population, MAX(total_cases) As HighestInfectionCount, MAX((total_cases/population))*100 As PercentPopulationInfected
FROM dbo.CovidDeaths 
---where location like '%states%'
group by location, population
order by PercentPopulationInfected desc

-- showing countries with highest death count per population

Select location, MAX(Cast (Total_deaths As int)) As totaldeathcount
FROM dbo.CovidDeaths 
---where location like '%states%'
where continent is not null
group by location
order by totaldeathcount desc

---Lets break things down by continent
Select continent, MAX(Cast (Total_deaths As int)) As totaldeathcount
FROM dbo.CovidDeaths 
---where location like '%states%'
where continent is not null
group by continent
order by totaldeathcount desc

--showing the continents with the highest death count per population

Select continent, MAX(Cast (Total_deaths As int)) As totaldeathcount
FROM dbo.CovidDeaths 
---where location like '%states%'
where continent is not null
group by continent
order by totaldeathcount desc

--- Looking at total population vs vaccinations
--- Global Numbers

select SUM(new_cases)as total_cases,sum(cast(new_deaths as int))as total_deaths, SUM(cast(new_deaths as int))/SUM
(new_cases)*100 as deathpercentage
FROM dbo.CovidDeaths	
---where location like '%states%'  
where continent is not null
---group by date	
order by 1,2;

select * 
from dbo.CovidDeaths dea
join dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from dbo.CovidDeaths dea
join dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

select * 
from dbo.CovidDeaths dea
join dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(Convert(int,vac.new_vaccinations)) Over (partition by dea.location order by dea.location,dea.Date)
from dbo.CovidDeaths dea
join dbo.CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3











