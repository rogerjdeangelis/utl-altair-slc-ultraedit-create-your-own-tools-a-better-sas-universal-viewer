/* The repo's documented USAGE sample: copy a SAS dataset so the "xls" hotkey
   tool can open it in Excel for exploration/QC. Upstream:

       data workx.zipcode;
         set sashelp.zipcode;
       run;

   Here the copy target is a plain WORK dataset (workx is an autoexec-assigned
   permanent library upstream), then we inspect it the way the viewer would let
   you inspect it once it lands in Excel. */
data workx_zipcode;
  set work.zipcode;
run;

proc print data=workx_zipcode(obs=5);
  title "workx.zipcode — the dataset the viewer hotkey would open";
run;

proc means data=workx_zipcode n min max mean;
  var Y X;
run;
