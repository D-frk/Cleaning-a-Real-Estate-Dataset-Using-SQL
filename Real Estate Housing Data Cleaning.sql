SELECT *
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]

SELECT SaleDate,CONVERT(DATE,SaleDate)
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]

UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing]
SET SaleDate=CONVERT(DATE,SaleDate)

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing]
ADD SaleDateConverted DATE

UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing]
SET SaleDateConverted = CONVERT(DATE,SaleDate)

SELECT *
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]
--WHERE PropertyAddress is NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress,b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Data Cleaning in SQL].dbo.[Nashville Housing] a
JOIN [Data Cleaning in SQL].dbo.[Nashville Housing] b
ON a.ParcelID=b.ParcelID
AND a.UniqueID<>b.UniqueID
WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Data Cleaning in SQL].dbo.[Nashville Housing] a
JOIN [Data Cleaning in SQL].dbo.[Nashville Housing] b
ON a.ParcelID=b.ParcelID
AND a.UniqueID<>b.UniqueID
WHERE a.PropertyAddress is null

SELECT PropertyAddress
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]

SELECT
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) AS Address
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing]
ADD PropertySplitAddress VARCHAR(255)

 UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing]
SET PropertySplitAddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing]
ADD PropertySplitCity VARCHAR(255)

UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing]
SET PropertySplitCity=SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

SELECT *
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]

SELECT OwnerAddress,
PARSENAME(REPLACE(OwnerAddress,',' , '.'), 3) AS OwnerAddress1,
PARSENAME(REPLACE(OwnerAddress,',' , '.'), 2) AS CITY,
PARSENAME(REPLACE(OwnerAddress,',' , '.'), 1) AS STATE
FROM [Data Cleaning in SQL].dbo.[Nashville Housing];

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing]
ADD OwnerAddress1 VARCHAR(255)

 UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing]
SET OwnerAddress1=PARSENAME(REPLACE(OwnerAddress,',' , '.'), 3)

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing]
ADD OwnerCity VARCHAR(255)

UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing]
SET OwnerCity=PARSENAME(REPLACE(OwnerAddress,',' , '.'), 2)

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing ]
ADD OwnerState VARCHAR(255)

UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing]
SET OwnerState=PARSENAME(REPLACE(OwnerAddress,',' , '.'), 1)

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing]
DROP COLUMN State

ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing]
DROP COLUMN City

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
END
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]

UPDATE [Data Cleaning in SQL].dbo.[Nashville Housing ]
SET SoldAsVacant= CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
END

WITH RowNumCTE AS (
SELECT *,
     ROW_NUMBER() OVER (
	 PARTITION BY ParcelID,
	 PropertyAddress,
	 SalePrice,
	 LegalReference
	 ORDER BY UniqueID
     ) Row_Num
FROM [Data Cleaning in SQL].dbo.[Nashville Housing]
--ORDER BY ParcelID
)

--I DELETED THE DUPLICATED VOLUMES BEFORE THE NEXT "SELECT" BELOW BY REPLACING THE BELOW "SELECT" WITH DELETE
SELECT *
FROM RowNumCTE
WHERE Row_Num > 1
--ORDER BY PropertyAddress

SELECT *
FROM [Data Cleaning in SQL].dbo.[Nashville Housing] 


ALTER TABLE [Data Cleaning in SQL].dbo.[Nashville Housing] 
DROP COLUMN PropertyAddress,SaleDate,OwnerAddress,TaxDistrict







