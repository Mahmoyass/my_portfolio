
--cleaning data in SQL Queries

select*
from dbo.[Nashville Housing]

--standdardize date format

select SaleDateConverted,CONVERT(Date,SaleDate)
from dbo.[Nashville Housing]

update [Nashville Housing]
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE [Nashville Housing]

ADD SaleDateConverted Date

update [Nashville Housing]
set SaleDateConverted = CONVERT(Date,SaleDate)

--populate property adress data

select PropertyAddress
from dbo.[Nashville Housing]
--where PropertyAddress IS NULL

select *
from dbo.[Nashville Housing]
order by ParcelID

select a.parcelID,a.propertyAddress,b.parcelID,b.propertyAddress 
from dbo.[Nashville Housing] a
JoiN dbo.[Nashville Housing] b
on a.parcelID = b.parcelID
AND a.[UniqueID]<> b.[UniqueID]
where a.propertyAddress IS NULL

update a
SET propertyAddress = ISNULL(a.propertyAddress,b.propertyAddress)
from dbo.[Nashville Housing] a
JoiN dbo.[Nashville Housing] b
on a.parcelID = b.parcelID
AND a.[UniqueID]<> b.[UniqueID]
where a.propertyAddress IS NULL

--breaking out Address into undividual columns (Address,city,state)

select propertyAddress
from dbo.[Nashville Housing]

select 
SUBSTRING(propertyAddress,1,CHARINDEX(',',propertyAddress)-1) as Address
 
from dbo.[Nashville Housing]

ALTER TABLE [Nashville Housing]
ADD propertySplitAddress Nvarchar (255);

update [Nashville Housing]
SET propertySplitAddress = sUBSTRING(propertyAddress,1,CHARINDEX(',',propertyAddress)-1) 

ALTER TABLE [Nashville Housing]
ADD propertySplitCity Nvarchar (255);

update [Nashville Housing]
SET propertySplitAddress = sUBSTRING(propertyAddress,CHARINDEX(',',propertyAddress)+1,LEN(propertyAddress))

select*
from dbo.[Nashville Housing]

select  ownerAddress
from dbo.[Nashville Housing]

select 
PARSENAME(REPLACE(ownerAddress,',' , '.') ,3)
,PARSENAME(REPLACE(ownerAddress, ',' , '.') ,2)
,PARSENAME(REPLACE(ownerAddress, ',' , '.') ,1)
from dbo.[Nashville Housing]

ALTER TABLE [Nashville Housing]
ADD ownerSplitAddress Nvarchar (255);

update [Nashville Housing]
SET ownerSplitAddress = PARSENAME(REPLACE(ownerAddress,',' , '.') ,3)

ALTER TABLE [Nashville Housing]
ADD ownerSplitCity Nvarchar (255);

update [Nashville Housing]
SET ownerSplitCity = PARSENAME(REPLACE(ownerAddress, ',' , '.') ,2)

ALTER TABLE [Nashville Housing]
ADD ownerSplitstate Nvarchar (255);

update [Nashville Housing]
SET ownerSplitstate  = PARSENAME(REPLACE(ownerAddress, ',' , '.') ,1)
 
 select*
 from dbo.[Nashville Housing]

 --change Y AND N TO YES AND NO IN "sold as vacant"field
 select distinct(soldAsvacant),COUNT(soldAsvacant)
  from dbo.[Nashville Housing]
  Group by soldAsvacant
  order by 2

  select soldAsvacant
 , CASE when soldAsvacant ='Y' then 'Yes'
       when soldAsvacant ='N' then 'No'
       ELSE soldAsvacant
       END
  from dbo.[Nashville Housing]

  update [Nashville Housing]
SET soldAsvacant = CASE when soldAsvacant ='Y' then 'Yes'
when soldAsvacant = 'N' THEN 'NO'
       ELSE soldAsvacant
	   END

--Remove Duplicates

WITH RownumCTE AS(
select *,
RoW_NUMBER() over(
PARTITION BY parcelID,
             propertyAddress,
			 Saleprice,
			 saledate,
			 LegalReference
			 ORDER BY
			 UniqueID
			) row_num

from  dbo.[Nashville Housing]
--ORDER BY parcelID
)
DELETE 
from RownumCTE
where row_num >1
--order by propertyAddress

WITH RownumCTE AS(
select *,
RoW_NUMBER() over(
PARTITION BY parcelID,
             propertyAddress,
			 Saleprice,
			 saledate,
			 LegalReference
			 ORDER BY
			 UniqueID
			) row_num

from  dbo.[Nashville Housing]
--ORDER BY parcelID
)
select* 
from RownumCTE
where row_num >1
--order by propertyAddress


--delete unused columns

select* 
from  dbo.[Nashville Housing]

ALTER TABLE dbo.[Nashville Housing]
DROP COLUMN  owneraddress,TaxDistrict,propertyAddress

ALTER TABLE dbo.[Nashville Housing]
DROP COLUMN  SaleDate

