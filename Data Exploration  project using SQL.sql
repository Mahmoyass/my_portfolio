select*
from dbo.Coviddeaths
order by 3,4

--select*
--from dbo.Covidvaccination
--order by 3,4

--select data that we are going to be using 

select location,date,total_cases,new_cases,total_deaths,population
from dbo.Coviddeaths 
order by 1,2

--looking at total cases vs total deaths

ALTER TABLE  dbo.Coviddeaths 
ALTER column total_deaths int
ALTER TABLE  dbo.Coviddeaths 
ALTER column total_cases int

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as precentage
from dbo.Coviddeaths
where location like '%states%'
order by 1,2


--looking at total cases vs population


select location,date,total_cases,population,(total_cases/population)*100 as Deathsprecentage
from dbo.Coviddeaths
--where location like '%states%'
order by 1,2

--looking at countries with highest infection rate cpmpared to population


select location,population,MAX(total_cases) as highestinfectioncount ,MAX(total_cases/population)*100 as precentagepopulationinfected
from dbo.Coviddeaths
--where location like '%states%'
Group by location,population
order by 1,2

select location,population,MAX(total_cases) as highestinfectioncount ,MAX(total_cases/population)*100 as precentagepopulationinfected
from dbo.Coviddeaths
--where location like '%states%'
Group by location,population
order by precentagepopulationinfected desc


--showing countries with highest death count per population


select location,MAX(total_deaths) as TotalDeathcount
from dbo.Coviddeaths
--where location like '%states%'
Group by location,population
order by TotalDeathcount desc


select location,MAX(cast(total_deaths as int)) as TotalDeathcount
from dbo.Coviddeaths
--where location like '%states%'
Group by location,population
order by TotalDeathcount desc


select*
from dbo.Coviddeaths
where continent is not null
order by 3,4

select location,MAX(cast(total_deaths as int)) as TotalDeathcount
from dbo.Coviddeaths
where continent is not null
--where location like '%states%'
Group by location,population
order by TotalDeathcount desc

--let's  break things down by continent

select location,MAX(cast(total_deaths as int)) as TotalDeathcount
from dbo.Coviddeaths
where continent is  null
--where location like '%states%'
Group by location
order by TotalDeathcount desc


--showing continents with the hiest death count per population


select continent,MAX(cast(total_deaths as int)) as TotalDeathcount
from dbo.Coviddeaths
where continent is not null
--where location like '%states%'
Group by continent
order by TotalDeathcount desc

--Global numbers

select location,date,total_cases,population,(total_cases/population)*100 as Deathsprecentage
from dbo.Coviddeaths
--where location like '%states%'
where continent is not null
order by 1,2



select date,sum(new_cases),SUM(cast(new_deaths as int))--,total_cases,population,(total_cases/population)*100 as Deathsprecentage
from dbo.Coviddeaths
--where location like '%states%'
where continent is not null
group by date
order by 1,2


select date,sum(new_cases),SUM(cast(new_deaths as int))--,total_cases,population,(total_cases/population)*100 as Deathsprecentage
from dbo.Coviddeaths
--where location like '%states%'
where continent is not null
group by date
order by 1,2



select date,sum(new_cases),SUM(cast(new_deaths as int)),sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathsprecentage
from dbo.Coviddeaths
--where location like '%states%'
where continent is not null
group by date
order by 1,2



select sum(new_cases)as total_cases,SUM(cast(new_deaths as int))as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathsprecentage
from dbo.Coviddeaths
--where location like '%states%'
where continent is not null
--group by date
order by 1,2

--looking at total population vs vaccinations

select dea.continent ,dea.location,dea.date,dea.population,vac.new_vaccinations
from dbo.Coviddeaths dea
join dbo.Covidvaccination vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3


select dea.continent ,dea.location,dea.date,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
from dbo.Coviddeaths dea
join dbo.Covidvaccination vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3

--temp table

Create table #percentpopulationvaccinated
(
continent nvarchar(225),
location nvarchar(225),
date datetime,
population numeric,
new_vaccinations numeric,
rollingpeoplevaccinated numeric
)
insert into 

select dea.continent ,dea.location,dea.date,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
from dbo.Coviddeaths dea
join dbo.Covidvaccination vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3


--creating view to store data for later visualizations
create view #percentpopulationvaccinated as


select dea.continent ,dea.location,dea.date,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as rollingpeoplevaccinated
from dbo.Coviddeaths dea
join dbo.Covidvaccination vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
