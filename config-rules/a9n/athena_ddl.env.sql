CREATE EXTERNAL TABLE `$TRAIL_TABLE_NAME`(
  `eventversion` string COMMENT 'from deserializer', 
  `useridentity` struct<type:string,principalid:string,arn:string,accountid:string,invokedby:string,accesskeyid:string,username:string,sessioncontext:struct<attributes:struct<mfaauthenticated:string,creationdate:string>,sessionissuer:struct<type:string,principalid:string,arn:string,accountid:string,username:string>,ec2roledelivery:string,webidfederationdata:map<string,string>>> COMMENT 'from deserializer', 
  `eventtime` string COMMENT 'from deserializer', 
  `eventsource` string COMMENT 'from deserializer', 
  `eventname` string COMMENT 'from deserializer', 
  `awsregion` string COMMENT 'from deserializer', 
  `sourceipaddress` string COMMENT 'from deserializer', 
  `useragent` string COMMENT 'from deserializer', 
  `errorcode` string COMMENT 'from deserializer', 
  `errormessage` string COMMENT 'from deserializer', 
  `requestparameters` string COMMENT 'from deserializer', 
  `responseelements` string COMMENT 'from deserializer', 
  `additionaleventdata` string COMMENT 'from deserializer', 
  `requestid` string COMMENT 'from deserializer', 
  `eventid` string COMMENT 'from deserializer', 
  `resources` array<struct<arn:string,accountid:string,type:string>> COMMENT 'from deserializer', 
  `eventtype` string COMMENT 'from deserializer', 
  `apiversion` string COMMENT 'from deserializer', 
  `readonly` string COMMENT 'from deserializer', 
  `recipientaccountid` string COMMENT 'from deserializer', 
  `serviceeventdetails` string COMMENT 'from deserializer', 
  `sharedeventid` string COMMENT 'from deserializer', 
  `vpcendpointid` string COMMENT 'from deserializer', 
  `tlsdetails` struct<tlsversion:string,ciphersuite:string,clientprovidedhostheader:string> COMMENT 'from deserializer')
COMMENT 'CloudTrail table for caravanacloud-logs bucket'
ROW FORMAT SERDE 
  'org.apache.hive.hcatalog.data.JsonSerDe' 
STORED AS INPUTFORMAT 
  'com.amazon.emr.cloudtrail.CloudTrailInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
's3://$TRAIL_BUCKET/$TRAIL_PREFIX/AWSLogs/$ACCOUNT_ID/CloudTrail'
TBLPROPERTIES (
  'classification'='cloudtrail', 
  'transient_lastDdlTime'='1698576657');