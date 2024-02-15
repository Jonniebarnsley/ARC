#!/bin/bash/

getExp()
{

    case $EXPT in
        0)gamma0=9618.9;UMV=2.058e+20;LRP=0.000716;PDDi=0.0196;WeertC=22301.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run001_control;EXPNUM=001;model=control;;
        1)gamma0=159188.5;UMV=7.97e+20;LRP=0.000527;PDDi=0.0168;WeertC=13110.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run002_control;EXPNUM=002;model=control;;
        2)gamma0=159188.5;UMV=2.366e+19;LRP=0.000396;PDDi=0.012;WeertC=16585.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run003_control;EXPNUM=003;model=control;;
        3)gamma0=471264.3;UMV=6.491e+20;LRP=0.000662;PDDi=0.0136;WeertC=31569.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run004_control;EXPNUM=004;model=control;;
        4)gamma0=159188.5;UMV=3.212e+20;LRP=0.000102;PDDi=0.0181;WeertC=39836.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run005_control;EXPNUM=005;model=control;;
        5)gamma0=86984.0;UMV=1.489e+20;LRP=0.000344;PDDi=0.0199;WeertC=28202.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run006_control;EXPNUM=006;model=control;;
        6)gamma0=159188.5;UMV=8.871e+20;LRP=2.1e-05;PDDi=0.0127;WeertC=44003.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run007_control;EXPNUM=007;model=control;;
        7)gamma0=86984.0;UMV=6.578e+20;LRP=0.000294;PDDi=0.0173;WeertC=50220.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run008_control;EXPNUM=008;model=control;;
        8)gamma0=86984.0;UMV=1.077e+20;LRP=0.000521;PDDi=0.0172;WeertC=58870.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run009_control;EXPNUM=009;model=control;;
        9)gamma0=159188.5;UMV=7.192e+19;LRP=0.000647;PDDi=0.0197;WeertC=14564.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run010_control;EXPNUM=010;model=control;;
        10)gamma0=9618.9;UMV=2.562e+20;LRP=0.000177;PDDi=0.0157;WeertC=57976.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run011_control;EXPNUM=011;model=control;;
        11)gamma0=86984.0;UMV=9.92e+20;LRP=0.000478;PDDi=0.0082;WeertC=44984.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run012_control;EXPNUM=012;model=control;;
        12)gamma0=86984.0;UMV=6.587e+20;LRP=9e-06;PDDi=0.0158;WeertC=37846.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run013_control;EXPNUM=013;model=control;;
        13)gamma0=21005.3;UMV=8.665e+20;LRP=0.000386;PDDi=0.0103;WeertC=28644.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run014_control;EXPNUM=014;model=control;;
        14)gamma0=86984.0;UMV=3.972e+20;LRP=0.000673;PDDi=0.0137;WeertC=11789.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run015_control;EXPNUM=015;model=control;;
        15)gamma0=21005.3;UMV=3.947e+18;LRP=0.000275;PDDi=0.0093;WeertC=55330.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run016_control;EXPNUM=016;model=control;;
        16)gamma0=86984.0;UMV=3.859e+20;LRP=0.00049;PDDi=0.0082;WeertC=46705.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run017_control;EXPNUM=017;model=control;;
        17)gamma0=21005.3;UMV=1.175e+19;LRP=0.000747;PDDi=0.0192;WeertC=33688.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run018_control;EXPNUM=018;model=control;;
        18)gamma0=159188.5;UMV=1.104e+20;LRP=0.000349;PDDi=0.0095;WeertC=35893.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run019_control;EXPNUM=019;model=control;;
        19)gamma0=9618.9;UMV=3.777e+20;LRP=0.000633;PDDi=0.0117;WeertC=13538.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run020_control;EXPNUM=020;model=control;;
        20)gamma0=159188.5;UMV=6.006e+20;LRP=0.000516;PDDi=0.0115;WeertC=40469.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run021_control;EXPNUM=021;model=control;;
        21)gamma0=471264.3;UMV=5.98e+20;LRP=0.000707;PDDi=0.0186;WeertC=57727.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run022_control;EXPNUM=022;model=control;;
        22)gamma0=14477.3;UMV=9.729e+20;LRP=0.000288;PDDi=0.0189;WeertC=48511.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run023_control;EXPNUM=023;model=control;;
        23)gamma0=9618.9;UMV=6.383e+19;LRP=0.000221;PDDi=0.014;WeertC=29227.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run024_control;EXPNUM=024;model=control;;
        24)gamma0=14477.3;UMV=7.759e+19;LRP=0.000132;PDDi=0.0089;WeertC=34257.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run025_control;EXPNUM=025;model=control;;
        25)gamma0=471264.3;UMV=9.41e+20;LRP=8.7e-05;PDDi=0.0099;WeertC=17147.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run026_control;EXPNUM=026;model=control;;
        26)gamma0=471264.3;UMV=2.644e+20;LRP=0.000165;PDDi=0.0183;WeertC=56722.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run027_control;EXPNUM=027;model=control;;
        27)gamma0=14477.3;UMV=1.941e+20;LRP=0.000445;PDDi=0.009;WeertC=36285.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run028_control;EXPNUM=028;model=control;;
        28)gamma0=14477.3;UMV=7.648e+20;LRP=7.8e-05;PDDi=0.0085;WeertC=41688.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run029_control;EXPNUM=029;model=control;;
        29)gamma0=14477.3;UMV=9.841e+20;LRP=0.000763;PDDi=0.0166;WeertC=61707.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run030_control;EXPNUM=030;model=control;;
        30)gamma0=471264.3;UMV=3.061e+20;LRP=0.0005;PDDi=0.0117;WeertC=30647.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run031_control;EXPNUM=031;model=control;;
        31)gamma0=471264.3;UMV=7.298e+20;LRP=0.000536;PDDi=0.0141;WeertC=25596.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run032_control;EXPNUM=032;model=control;;
        32)gamma0=9618.9;UMV=9.661e+20;LRP=0.000402;PDDi=0.0154;WeertC=47174.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run033_control;EXPNUM=033;model=control;;
        33)gamma0=14477.3;UMV=8.405e+20;LRP=0.000462;PDDi=0.0115;WeertC=9529.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run034_control;EXPNUM=034;model=control;;
        34)gamma0=9618.9;UMV=8.458e+20;LRP=0.000565;PDDi=0.0163;WeertC=56981.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run035_control;EXPNUM=035;model=control;;
        35)gamma0=159188.5;UMV=1.59e+20;LRP=0.000606;PDDi=0.0151;WeertC=22085.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run036_control;EXPNUM=036;model=control;;
        36)gamma0=14477.3;UMV=7.519e+20;LRP=0.000583;PDDi=0.0145;WeertC=58432.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run037_control;EXPNUM=037;model=control;;
        37)gamma0=159188.5;UMV=6.106e+20;LRP=0.000271;PDDi=0.0152;WeertC=26522.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run038_control;EXPNUM=038;model=control;;
        38)gamma0=159188.5;UMV=6.721e+20;LRP=0.000208;PDDi=0.0168;WeertC=38971.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run039_control;EXPNUM=039;model=control;;
        39)gamma0=9618.9;UMV=9.446e+20;LRP=4.5e-05;PDDi=0.0175;WeertC=42363.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run040_control;EXPNUM=040;model=control;;
        40)gamma0=9618.9;UMV=2.694e+20;LRP=0.000436;PDDi=0.0143;WeertC=20724.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run041_control;EXPNUM=041;model=control;;
        41)gamma0=21005.3;UMV=4.688e+20;LRP=0.000236;PDDi=0.017;WeertC=29623.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run042_control;EXPNUM=042;model=control;;
        42)gamma0=86984.0;UMV=6.34e+20;LRP=6e-06;PDDi=0.019;WeertC=31898.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run043_control;EXPNUM=043;model=control;;
        43)gamma0=21005.3;UMV=5.121e+20;LRP=8.2e-05;PDDi=0.0197;WeertC=33460.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run044_control;EXPNUM=044;model=control;;
        44)gamma0=471264.3;UMV=2.326e+20;LRP=0.000318;PDDi=0.0162;WeertC=25221.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run045_control;EXPNUM=045;model=control;;
        45)gamma0=14477.3;UMV=4.137e+20;LRP=0.000302;PDDi=0.0124;WeertC=40848.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run046_control;EXPNUM=046;model=control;;
        46)gamma0=86984.0;UMV=3.491e+20;LRP=0.000171;PDDi=0.015;WeertC=26819.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run047_control;EXPNUM=047;model=control;;
        47)gamma0=159188.5;UMV=8.715e+20;LRP=0.00018;PDDi=0.0179;WeertC=27430.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run048_control;EXPNUM=048;model=control;;
        48)gamma0=9618.9;UMV=2.984e+20;LRP=0.000243;PDDi=0.0097;WeertC=19271.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run049_control;EXPNUM=049;model=control;;
        49)gamma0=471264.3;UMV=1.855e+20;LRP=0.000203;PDDi=0.01;WeertC=18827.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run050_control;EXPNUM=050;model=control;;
        50)gamma0=159188.5;UMV=5.249e+20;LRP=0.000333;PDDi=0.0195;WeertC=43344.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run051_control;EXPNUM=051;model=control;;
        51)gamma0=14477.3;UMV=8.83e+20;LRP=0.000357;PDDi=0.0101;WeertC=10451.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run052_control;EXPNUM=052;model=control;;
        52)gamma0=86984.0;UMV=5.662e+20;LRP=0.000706;PDDi=0.0109;WeertC=7978.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run053_control;EXPNUM=053;model=control;;
        53)gamma0=471264.3;UMV=4.958e+20;LRP=0.000796;PDDi=0.0128;WeertC=45101.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run054_control;EXPNUM=054;model=control;;
        54)gamma0=471264.3;UMV=7.728e+20;LRP=0.000545;PDDi=0.0198;WeertC=37051.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run055_control;EXPNUM=055;model=control;;
        55)gamma0=14477.3;UMV=9.962e+19;LRP=0.000785;PDDi=0.0085;WeertC=21471.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run056_control;EXPNUM=056;model=control;;
        56)gamma0=21005.3;UMV=9.131e+20;LRP=5e-05;PDDi=0.0108;WeertC=26121.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run057_control;EXPNUM=057;model=control;;
        57)gamma0=471264.3;UMV=7.052e+20;LRP=0.000737;PDDi=0.0105;WeertC=24917.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run058_control;EXPNUM=058;model=control;;
        58)gamma0=9618.9;UMV=1.754e+20;LRP=0.000591;PDDi=0.0108;WeertC=53178.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run059_control;EXPNUM=059;model=control;;
        59)gamma0=86984.0;UMV=9.293e+20;LRP=0.000336;PDDi=0.0156;WeertC=60697.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run060_control;EXPNUM=060;model=control;;
        60)gamma0=14477.3;UMV=1.807e+20;LRP=0.000506;PDDi=0.015;WeertC=23639.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run061_control;EXPNUM=061;model=control;;
        61)gamma0=9618.9;UMV=5.885e+19;LRP=0.000549;PDDi=0.0186;WeertC=12674.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run062_control;EXPNUM=062;model=control;;
        62)gamma0=86984.0;UMV=5.832e+20;LRP=0.000108;PDDi=0.0118;WeertC=61164.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run063_control;EXPNUM=063;model=control;;
        63)gamma0=159188.5;UMV=1.294e+20;LRP=0.000777;PDDi=0.0131;WeertC=38413.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run064_control;EXPNUM=064;model=control;;
        64)gamma0=9618.9;UMV=1.35e+20;LRP=0.000375;PDDi=0.0175;WeertC=52662.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run065_control;EXPNUM=065;model=control;;
        65)gamma0=86984.0;UMV=5.061e+20;LRP=0.000625;PDDi=0.0177;WeertC=45626.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run066_control;EXPNUM=066;model=control;;
        66)gamma0=9618.9;UMV=5.583e+20;LRP=0.000729;PDDi=0.0134;WeertC=48255.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run067_control;EXPNUM=067;model=control;;
        67)gamma0=86984.0;UMV=8.245e+20;LRP=5.8e-05;PDDi=0.0098;WeertC=49759.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run068_control;EXPNUM=068;model=control;;
        68)gamma0=471264.3;UMV=6.213e+20;LRP=0.000469;PDDi=0.0189;WeertC=34680.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run069_control;EXPNUM=069;model=control;;
        69)gamma0=14477.3;UMV=6.848e+20;LRP=0.000509;PDDi=0.0107;WeertC=9071.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run070_control;EXPNUM=070;model=control;;
        70)gamma0=159188.5;UMV=7.481e+20;LRP=1.9e-05;PDDi=0.0084;WeertC=44382.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run071_control;EXPNUM=071;model=control;;
        71)gamma0=86984.0;UMV=4.324e+20;LRP=0.000154;PDDi=0.0166;WeertC=59922.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run072_control;EXPNUM=072;model=control;;
        72)gamma0=21005.3;UMV=7.176e+20;LRP=0.000616;PDDi=0.0194;WeertC=53711.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run073_control;EXPNUM=073;model=control;;
        73)gamma0=9618.9;UMV=2.81e+20;LRP=0.000373;PDDi=0.0105;WeertC=9925.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run074_control;EXPNUM=074;model=control;;
        74)gamma0=471264.3;UMV=7.396e+20;LRP=0.000725;PDDi=0.013;WeertC=39129.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run075_control;EXPNUM=075;model=control;;
        75)gamma0=159188.5;UMV=4.489e+20;LRP=0.000126;PDDi=0.0135;WeertC=14184.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run076_control;EXPNUM=076;model=control;;
        76)gamma0=14477.3;UMV=8.006e+20;LRP=0.000256;PDDi=0.0148;WeertC=52239.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run077_control;EXPNUM=077;model=control;;
        77)gamma0=21005.3;UMV=9.035e+20;LRP=0.000198;PDDi=0.0142;WeertC=8443.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run078_control;EXPNUM=078;model=control;;
        78)gamma0=21005.3;UMV=4.857e+20;LRP=0.000484;PDDi=0.014;WeertC=54630.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run079_control;EXPNUM=079;model=control;;
        79)gamma0=14477.3;UMV=5.352e+20;LRP=0.000283;PDDi=0.0154;WeertC=32866.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run080_control;EXPNUM=080;model=control;;
        80)gamma0=86984.0;UMV=2.872e+20;LRP=0.000113;PDDi=0.0131;WeertC=49360.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run081_control;EXPNUM=081;model=control;;
        81)gamma0=14477.3;UMV=1.582e+20;LRP=0.000229;PDDi=0.0163;WeertC=19891.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run082_control;EXPNUM=082;model=control;;
        82)gamma0=471264.3;UMV=9.823e+20;LRP=0.000792;PDDi=0.018;WeertC=24079.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run083_control;EXPNUM=083;model=control;;
        83)gamma0=159188.5;UMV=7.764e+20;LRP=0.000413;PDDi=0.0103;WeertC=15110.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run084_control;EXPNUM=084;model=control;;
        84)gamma0=9618.9;UMV=6.314e+20;LRP=0.000646;PDDi=0.0185;WeertC=55751.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run085_control;EXPNUM=085;model=control;;
        85)gamma0=21005.3;UMV=6.817e+20;LRP=0.000429;PDDi=0.0091;WeertC=10944.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run086_control;EXPNUM=086;model=control;;
        86)gamma0=21005.3;UMV=2.182e+20;LRP=6.3e-05;PDDi=0.0081;WeertC=17692.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run087_control;EXPNUM=087;model=control;;
        87)gamma0=9618.9;UMV=8.528e+20;LRP=0.000425;PDDi=0.0177;WeertC=41991.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run088_control;EXPNUM=088;model=control;;
        88)gamma0=159188.5;UMV=4.093e+19;LRP=3.1e-05;PDDi=0.0147;WeertC=16159.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run089_control;EXPNUM=089;model=control;;
        89)gamma0=14477.3;UMV=4.361e+20;LRP=0.000687;PDDi=0.0096;WeertC=30171.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run090_control;EXPNUM=090;model=control;;
        90)gamma0=21005.3;UMV=5.258e+20;LRP=0.000389;PDDi=0.0138;WeertC=40961.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run091_control;EXPNUM=091;model=control;;
        91)gamma0=471264.3;UMV=2.464e+20;LRP=0.000189;PDDi=0.0086;WeertC=15679.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run092_control;EXPNUM=092;model=control;;
        92)gamma0=14477.3;UMV=4.759e+20;LRP=6.9e-05;PDDi=0.0126;WeertC=51734.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run093_control;EXPNUM=093;model=control;;
        93)gamma0=471264.3;UMV=5.846e+20;LRP=0.000134;PDDi=0.0132;WeertC=11273.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run094_control;EXPNUM=094;model=control;;
        94)gamma0=21005.3;UMV=3.672e+20;LRP=0.000309;PDDi=0.0148;WeertC=62063.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run095_control;EXPNUM=095;model=control;;
        95)gamma0=86984.0;UMV=4.066e+20;LRP=0.000449;PDDi=0.0145;WeertC=54709.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run096_control;EXPNUM=096;model=control;;
        96)gamma0=159188.5;UMV=4.179e+20;LRP=0.000153;PDDi=0.0179;WeertC=32596.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run097_control;EXPNUM=097;model=control;;
        97)gamma0=14477.3;UMV=8.285e+20;LRP=0.00057;PDDi=0.0164;WeertC=54064.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run098_control;EXPNUM=098;model=control;;
        98)gamma0=159188.5;UMV=8.471e+19;LRP=0.000653;PDDi=0.0191;WeertC=20184.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run099_control;EXPNUM=099;model=control;;
        99)gamma0=471264.3;UMV=1.189e+20;LRP=0.000578;PDDi=0.0187;WeertC=8866.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run100_control;EXPNUM=100;model=control;;
        100)gamma0=471264.3;UMV=4.561e+20;LRP=0.000219;PDDi=0.0138;WeertC=23210.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run101_control;EXPNUM=101;model=control;;
        101)gamma0=9618.9;UMV=7.847e+20;LRP=0.00061;PDDi=0.0124;WeertC=60464.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run102_control;EXPNUM=102;model=control;;
        102)gamma0=21005.3;UMV=3.287e+20;LRP=0.00032;PDDi=0.0088;WeertC=18202.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run103_control;EXPNUM=103;model=control;;
        103)gamma0=21005.3;UMV=3.639e+20;LRP=0.000757;PDDi=0.0093;WeertC=56131.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run104_control;EXPNUM=104;model=control;;
        104)gamma0=159188.5;UMV=4.662e+20;LRP=0.000249;PDDi=0.0113;WeertC=46410.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run105_control;EXPNUM=105;model=control;;
        105)gamma0=471264.3;UMV=6.925e+20;LRP=0.000696;PDDi=0.0159;WeertC=21027.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run106_control;EXPNUM=106;model=control;;
        106)gamma0=21005.3;UMV=7.161e+20;LRP=0.000264;PDDi=0.0125;WeertC=47542.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run107_control;EXPNUM=107;model=control;;
        107)gamma0=21005.3;UMV=2.411e+20;LRP=0.000682;PDDi=0.0174;WeertC=37737.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run108_control;EXPNUM=108;model=control;;
        108)gamma0=14477.3;UMV=3.566e+20;LRP=0.000456;PDDi=0.0111;WeertC=30988.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run109_control;EXPNUM=109;model=control;;
        109)gamma0=9618.9;UMV=8.096e+20;LRP=0.000768;PDDi=0.0092;WeertC=50558.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run110_control;EXPNUM=110;model=control;;
        110)gamma0=86984.0;UMV=3.13e+19;LRP=0.000362;PDDi=0.0157;WeertC=43208.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run111_control;EXPNUM=111;model=control;;
        111)gamma0=86984.0;UMV=3.411e+20;LRP=0.000554;PDDi=0.0113;WeertC=35340.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run112_control;EXPNUM=112;model=control;;
        112)gamma0=14477.3;UMV=5.458e+20;LRP=0.000416;PDDi=0.0111;WeertC=36772.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_median_16km_384.2d.hdf5;EXPNAME=run113_control;EXPNUM=113;model=control;;
        113)gamma0=21005.3;UMV=8.984e+20;LRP=0.000141;PDDi=0.0183;WeertC=17604.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run114_control;EXPNUM=114;model=control;;
        114)gamma0=86984.0;UMV=5.686e+20;LRP=0.000638;PDDi=0.0121;WeertC=48839.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run115_control;EXPNUM=115;model=control;;
        115)gamma0=471264.3;UMV=2.146e+20;LRP=0.000667;PDDi=0.0161;WeertC=12164.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_pct_PIGL_gamma_calibration_16km_384.2d.hdf5;EXPNAME=run116_control;EXPNUM=116;model=control;;
        116)gamma0=21005.3;UMV=9.571e+20;LRP=0.000597;PDDi=0.0122;WeertC=28080.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run117_control;EXPNUM=117;model=control;;
        117)gamma0=9618.9;UMV=9.25e+20;LRP=3.9e-05;PDDi=0.0099;WeertC=22846.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run118_control;EXPNUM=118;model=control;;
        118)gamma0=21005.3;UMV=3.116e+20;LRP=0.000743;PDDi=0.012;WeertC=51297.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_95th_percentile_16km_384.2d.hdf5;EXPNAME=run119_control;EXPNUM=119;model=control;;
        119)gamma0=9618.9;UMV=4.374e+19;LRP=9.5e-05;PDDi=0.0169;WeertC=59500.0;DELTAT=coeff_gamma0_DeltaT_quadratic_non_local_5th_percentile_16km_384.2d.hdf5;EXPNAME=run120_control;EXPNUM=120;model=control;;
    esac
}
#for EXPT in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59; do
#for EXPT in 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119;
#do
# 10 biggest above weertc minimum, 10 middle, 10 biggest gainers, plus lowest weertman - run053 so add run053
#for EXPT in 99 36 106 41 38 56 101 48 83 32 47 28 54 96 9 113 39 44 119 25 120 63 93 72 81 71 60 40 95 65 53; do
#for EXPT in 4 22 26 27 31 45 50 55 58 69 75 92 94 100 116; do # runs using DELTAT=PIGL95 that Jamie hasn't already done 
#for EXPT in 9 25 28 36 38 39 40 41 44 47 48 53 56 60 63 65 71 72 81 93 95 96 99 113 119 120; do #redoing Jamies runs with incorrect DELTAT
#for EXPT in 1 2 3 5 6 7 8 10 11 12 13 14 15 16 17 18 19 20 21 23 24 29 30 33 34 35 37 42 43 46 49 51 52 57 59; do # completing 1-60 exlc Jamie's runs
#for EXPT in 61 62 64 66 67 68 70 73 74 76 77 78 79 80 82 84 85 86 87 88 89 90 91 97 98 102 103 104 105 107 108 109 110 111 112 114 115 117 118; do # completing 61-120 excl Jamie's runs
for EXPT in 1; do
    EXPT=$[$EXPT - 1]
    getExp
    LEV=2
    MODEL=$model
    NAME=AIS-BH-GIA-exp-${EXPNUM}.${LEV}lev
    INFILE=inputs.${NAME}
    CASEDIR=$EXPNAME/${EXPNAME}_${LEV}lev_ref
    mkdir -p $CASEDIR
    cp templates/surf_flux.py $CASEDIR/surf_flux.py
    cp templates/ismip_ramp.py $CASEDIR/ismip_ramp.py
    cp templates/python_timestepper.py $CASEDIR/python_timestepper.py
    JOBFILE=job.$NAME.sh
    JNAME=run${EXPNUM}_control
    initsmb=Init_SMB_${EXPNUM}.py
    pddname=PDD_RatioEC_control_${EXPNUM}.py
    wrapper=wrapper.${EXPNUM}.sh
    NCELLS=384
    TAGCAP=$(( LEV - 1 ))
    NCORES=24
    INFILERELAX=inputs.ant-relax-bmach-${EXPNUM}.${LEV}lev
    sed -e s/@PDDi/$PDDi/ -e s/@MODEL/$MODEL/ -e s/@LRP/$LRP/ templates/Init_SMB_control_template.py > $CASEDIR/$initsmb
    sed -e s/@PDDi/$PDDi/ -e s/@MODEL/$MODEL/ -e s/@LRP/$LRP/ templates/PDD_RatioEC_control.py > $CASEDIR/$pddname
    sed -e s/@NAME/$NAME/ -e s/@UMV/$UMV/ -e s/@DELTAT/$DELTAT/ -e s/@MODEL/$MODEL/ -e s/@TAGCAP/$TAGCAP/ -e s/@gamma0/$gamma0/ -e s/@BFC/bedFricCalculate_AIS-BH-GIA-exp-${EXPNUM}/ -e s/@NCELLS/$NCELLS/ -e s/@NCELLS/$NCELLS/ templates/inputs.template_control > $CASEDIR/$INFILE
    #sed -e s/@MODEL/$MODEL/ -e s/@PDDs/$PDDs/ -e s/@PDDi/$PDDi/ -e s/@LRT/$LRT/ -e s/@LRP/$LRP/ templates/PDD_RatioEC_template.py > $CASEDIR/$pddname
    sed -e s/@NAME/relax_${NAME}/ -e s/@TAGCAP/$TAGCAP/ -e s/@UMV/$UMV/ -e s/@NCELLS/$NCELLS/ -e s/@MODEL/$MODEL/ -e s/@gamma0/$gamma0/ -e s/@NCELLS/$NCELLS/ templates/inputs.ant_relax_template_cosmos > $CASEDIR/$INFILERELAX
    sed -e s/@JOB/$JOBFILE/ -e s/@INITSMB/$initsmb/ templates/wrapper.template > $CASEDIR/$wrapper
    sed -e s/@NCORES/$NCORES/ -e s/@NAME/$JNAME/ -e s/@INFILE/$INFILE/ -e s/@PDDNAME/$pddname/ -e s/@JOB/$JOBFILE/ templates/job.template.sh > $CASEDIR/$JOBFILE
    sed -e s/@NCORES/$NCORES/ -e s/@NAME/relax_${NAME}/ -e s/@INFILE/$INFILERELAX/ -e s/@wrapper/$wrapper/ templates/job.relax_template.sh > $CASEDIR/job.relax_${NAME}.sh
    sed -e s/@checkpoints/chk.${NAME}*/ templates/cleanup_template.sh > $CASEDIR/cleanup_${NAME}
    sed -e s/@WeertC/$WeertC/ templates/bedFricCalculate_template.py > $CASEDIR/bedFricCalculate_AIS-BH-GIA-exp-${EXPNUM}.py
done
