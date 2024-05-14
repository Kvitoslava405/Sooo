data = LOAD 'hdfs://sandbox-hdp.hortonworks.com:8020/uhadoop/downloaded-logs.csv' USING PigStorage(',') AS (
    latency:chararray,
    protocol:chararray,
    referer:chararray,
    remoteIp:chararray,
    requestMethod:chararray,
    requestSize:int,
    requestUrl:chararray,
    responseSize:int,
    serverIp:chararray,
    status:chararray,
    userAgent1:chararray,
    userAgent2:chararray,
    insertId:chararray,
    commit_sha:chararray,
    gcb_build_id:chararray,
    gcb_trigger_id:chararray,
    gcb_trigger_region:chararray,
    instanceId:chararray,
    managed_by:chararray,
    logName:chararray,
    receiveLocation:chararray,
    receiveTimestamp:chararray,
    configuration_name:chararray,
    location:chararray,
    project_id:chararray,
    revision_name:chararray,
    service_name:chararray,
    resource_type:chararray,
    severity:chararray,
    spanId:chararray,
    textPayload:chararray,
    timestamp:chararray,
    trace:chararray,
    traceSampled:chararray
);

clean_data = FOREACH data GENERATE requestMethod, status, latency, remoteIp, severity, timestamp, requestSize;

status_data = FOREACH (GROUP clean_data BY status) GENERATE 'Status: ' as format, group as name, ' = ' as equal, COUNT(clean_data) as count;

W = rank clean_data;
first_ten =  filter W by (rank_clean_data<10);

lat = FOREACH (GROUP clean_data ALL) GENERATE AVG(clean_data.requestSize);

sorted_data = ORDER clean_data BY status DESC;

DUMP first_ten;
