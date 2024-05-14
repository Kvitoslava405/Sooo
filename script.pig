data = LOAD 'hdfs://sandbox-hdp.hortonworks.com:8020/uhadoop/bootcamp5.csv' USING PigStorage(';') AS (
    index:int,
    age:int,
    gender:int,
    height:int,
    weight:float,
    ap_hi:int,
    ap_lo:int,
    cholesterol:int,
    gluc:int,
    smoke:int,
    alco:int,
    active:int,
    cardio:int
);
-- Обчислення середньої ваги для тих, хто займається спортом (active=1)
avg_weight_active = FOREACH (GROUP data BY active) {
    filtered_data = FILTER data BY active == 1;
    GENERATE group AS active_status, AVG(filtered_data.weight) AS average_weight;
};

-- Обчислення середньої ваги для тих, хто не займається спортом (active=0)
avg_weight_inactive = FOREACH (GROUP data BY active) {
    filtered_data = FILTER data BY active == 0;
    GENERATE group AS active_status, AVG(filtered_data.weight) AS average_weight;
};

DUMP avg_weight_active;
DUMP avg_weight_inactive;

male_data = FILTER data BY gender == 1 AND cardio == 0;
extra_data = FOREACH male_data GENERATE ((weight > 90) ? 1 : 0) as cond;
result = FOREACH (GROUP extra_data ALL) GENERATE AVG(extra_data.cond) AS av;
DUMP result;
