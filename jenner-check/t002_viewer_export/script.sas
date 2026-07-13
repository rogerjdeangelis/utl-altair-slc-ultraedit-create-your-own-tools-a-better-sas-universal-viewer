/* The portable core of the repo's "xls" viewer program. Upstream it deletes any
   stale output, then writes the highlighted dataset out for viewing:

       data _null_;
           fname="tempfile";
           rc=filename(fname, "c:\slc\current.xlsx");
           put rc=;
           if rc = 0 and fexist(fname) then rc=fdelete(fname);
       rc=filename(fname);
       run;

       libname __xls excel "c:\slc\current.xlsx";
       data __xls.myxlsx;
           set &argx(obs=1000);
       run;

   The clipboard device, the Excel libname and the x-command that launches Excel
   are Windows/PC-only; the file-existence guard (filename/fexist/fdelete) and the
   `set &argx(obs=1000)` copy are portable, so the Excel target is swapped for a
   CSV target and the rest of the logic runs unchanged. */

/* --- delete any stale output, exactly as upstream --- */
data _null_;
    fname="tempfile";
    rc=filename(fname, "current.csv");
    put rc=;
    if rc = 0 and fexist(fname) then
       rc=fdelete(fname);
rc=filename(fname);
run;

/* --- write the highlighted dataset out for viewing (obs=1000 as upstream) --- */
proc export data=&argx(obs=1000)
    outfile="current.csv"
    dbms=csv replace;
run;
