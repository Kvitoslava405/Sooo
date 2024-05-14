data = LOAD 'bootcamp5.csv' USING PigStorage(';') AS (
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

-- Виведення результатів
DUMP avg_weight_active;
DUMP avg_weight_inactive;
