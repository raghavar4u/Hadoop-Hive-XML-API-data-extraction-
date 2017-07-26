########################################################################
## -- XML API data to Hive tables 
########################################################################

-- ## OUTPUT of RESTFULL API 

<?xml version="1.0" encoding="UTF-8"?>
<Projects>
<Project endDate="2017-05-19T17:00:00" id="8P0S10" active="true" internalId="6235328" isProgram="false" lastUpdatedDate="2017-05-19T05:37:58" lastUpdatedBy="avbehera" createdDate="2017-05-19T03:54:53" createdBy="avbehera" managerId="avbehera" projectLeadId="priraut" startDate="2017-05-19T08:00:00">
<description>Test project for  learning purpose</description>
<objective>Objective text</objective>
<developmentPriority>0</developmentPriority>
<name>Test project_learning purpose - 8P0S10</name>
<programRank>0</programRank>
<pxeId>CP-####</pxeId>
</Project>
</Projects>

#################################################################################################################################################

Step @1 : -- Get the RESTFULL API out put using the credentials and store it in the XML_test2 text 

wget -S -q -O - http://wwwin-ppm-test-ws.cisco.com/ppmws/api/v2/projects/projectById/8P0S10 --user=ragthumm --password=******** > XML_test2.txt

Step @2 : -- ALL the output XML data has to store in the single column while creating the table 

--## XPATH or  xpath_string  is a internal function udf in hive to extract the data from XML code 

drop table CSC_VEMT_SFDC.XML_test ;

CREATE TABLE CSC_VEMT_SFDC.XML_test
(
xml_test string
);

load data local inpath '/users/hdpvemt/XML_test2.txt' into table CSC_VEMT_SFDC.XML_test; -- Location of the output stored 


select 
xpath_string(xml_test,'Projects/Project/department') as depeartment ,
xpath_string(xml_test,'Projects/Project/description') as description ,
xpath_string(xml_test,'Projects/Project/organization') as organization  
from CSC_VEMT_SFDC.XML_test;


select xpath_string(xml_test,'Projects/Project/id') from CSC_VEMT_SFDC.XML_test; -- Header tags will not work in this way since it is with in the projects and global for all the variables 

select xpath_string(xml_test,'Projects/Project/@id') from CSC_VEMT_SFDC.XML_test; -- if we use "@" it invoke the value from the XML tags 


#####################################################################################################################################################
