/* cap input rows for the captured run */
options obs=100;

/* The highlighted dataset the viewer would receive from the Windows clipboard.
   Upstream the tool reads the name via `filename clp clipbrd` and puts it in the
   &argx macro variable; here we provide a small dataset and set &argx directly. */
data work.zipcode;
  length City $20 StateCode $2;
  input Zip Y X City $ State StateCode $;
datalines;
06830 41.03 -73.63 Greenwich 9 CT
10001 40.75 -73.99 NewYork 36 NY
02138 42.38 -71.12 Cambridge 25 MA
;
run;

%let argx = work.zipcode;   /* upstream: arrives from the clipboard via filename clp clipbrd */
