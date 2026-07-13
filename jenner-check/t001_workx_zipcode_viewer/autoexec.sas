/* cap input rows for the captured run */
options obs=100;

/* Stand-in for sashelp.zipcode (same column shape: ZIP, Y=lat, X=lon, CITY,
   STATE fips, STATECODE), so the repo's viewer sample is self-contained here.
   Upstream this dataset lives in sashelp and is copied into the workx library
   assigned in the autoexec. */
data work.zipcode;
  length City $20 StateCode $2;
  input Zip Y X City $ State StateCode $;
datalines;
06830 41.03 -73.63 Greenwich 9 CT
10001 40.75 -73.99 NewYork 36 NY
02138 42.38 -71.12 Cambridge 25 MA
60601 41.88 -87.62 Chicago 17 IL
90001 33.97 -118.24 LosAngeles 6 CA
33101 25.78 -80.20 Miami 12 FL
98101 47.61 -122.33 Seattle 53 WA
75201 32.79 -96.80 Dallas 48 TX
;
run;
