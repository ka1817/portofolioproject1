--portfolio project
--a.Datewise likelihood of dying due to covid-totalcases vs TotalDeaths-in india
SELECT date,total_cases,total_deaths FROM "CovidDeaths" WHERE location like '%India%'
--b.total % of deaths out of entire population in india
SELECT (max(total_deaths)/avg(cast(population as integer))*100) as total_percentage FROM "CovidDeaths" WHERE location like '%India%'
--verify by setting into separately
select total_deaths,population from "CovidDeaths" WHERE location like '%India%'
--d.Country which having death as a % of population
select location,(max(total_deaths)/avg(cast(population as bigint))*100)as perc FROM "CovidDeaths"
GROUP BY location
order by perc DESC
--e.Total % of covid +ve cases in india
SELECT location,(max(total_cases)/avg(cast(population as bigint))*100) as perc FROM "CovidDeaths"
WHERE location like '%India%'
GROUP BY location 
--f.Total % of covid positive cases in world
SELECT location,(max(total_cases)/avg(cast(population as bigint))*100) as perc FROM "CovidDeaths"
GROUP BY location
ORDER BY perc DESC
--g.Continentwise +ve cases
select location,max(total_cases) as total_cases from "CovidDeaths" Where continent is null group by location
order by total_cases desc;
--h.continentwise deaths
select location,max(total_deaths) as total_deaths FROM "CovidDeaths" Where continent is null group by location
order by total_deaths desc;
--i.Daily newcases vs hospitalization vs icu_patients_india
select date,new_cases,hosp_patients,icu_patients from "CovidDeaths" 
where location like '%India%'
--j.countrywise age 65>
select "CovidDeaths".date,"CovidDeaths".location,"CovidVaccinations".aged_65_older from "CovidDeaths" 
JOIN "CovidVaccinations"
ON "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date
--k. Countrywise total vaccinated persons
select "CovidDeaths".location as country,(max("CovidVaccinations".people_fully_vaccinated)) as fully_vaccinated from "CovidDeaths" join "CovidVaccinations"
on "CovidDeaths".iso_code="CovidVaccinations".iso_code and "CovidDeaths".date="CovidVaccinations".date
where "CovidDeaths".continent is not null group by country
order by fully_vaccinated
