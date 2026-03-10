# utl-altair-slc-ultraedit-create-your-own-tools-a-better-sas-universal-viewer
Altair slc ultraedit create your own tools a better sas universal viewer
    %let pgm=utl-altair-slc-ultraedit-create-your-own-tools-a-better-sas-universal-viewer;

    %stop_submission;

    Altair slc ultraedit create your own tools a better sas universal viewer

    This post shows how to get a SAS data set into Excel, using just hotkeys, so you can
    Use everything Excel offers to explore and QC that SAS dataset.
    This is a replacement for the sas universal viewer.
    Note: This allows you to use the much more powerfull slc language to build your tools instead of javascript..
    Any text or commands that you can highlight in the editor, log or output can be access by the slc.

    Before you can use this you need to setup the slc for ultraedit.
    see
    https://github.com/rogerjdeangelis/utl-altair-slc-configuration-and-ultraedit-setup

    Key steps
      1 create a slc config file
      2 create an autoexec file (must have an additional permanent work library assigned in your autoexec

    Too long to post on a list.
    see github
    https://github.com/rogerjdeangelis/utl-altair-slc-ultraedit-create-your-own-tools-a-better-sas-universal-viewer

    USAGE

       /*--- sample program in ultraedit editor ---*/
       /*--- I like to assign workx in my autoexec so I can example datasets created by previous submissions ---*/
       
       data workx.zipcode;
         set sashelp.zipcode;
       run;

       Highlight workx.zipcode
       cntl + c  (copy text to clipboard)
       cntl + shift + 1

       excel will appear with sas dataset work.zipcode

       Whats happening:
         When you highlight workx.zipcode and hit cntl-c, the text 'workx.zipcode is store in the windows clipboard.
        When you then hic cntl-shift-1
          1. slc reads the clipboard
          2. an slc program reads the dataset and displays the dataset in excel
             This opens up excel tools to analyze the slc data set
    CONTENTS

      1 ultraed1t version
      2 altair slc version
      3 Folders used
      4 slc tool code
      5 Tool configuation
      6 Assign hotkey
        I was unable to automatically close thr undrlying command window.
        Will need to manuallyclick  X in the upper right
            ---
        --- | |  X
            ---

    /*         _ _                      _ _ _                        _
    / |  _   _| | |_ _ __ __ _  ___  __| (_) |_  __   _____ _ __ ___(_) ___  _ __
    | | | | | | | __| `__/ _` |/ _ \/ _` | | __| \ \ / / _ \ `__/ __| |/ _ \| `_ \
    | | | |_| | | |_| | | (_| |  __/ (_| | | |_   \ V /  __/ |  \__ \ | (_) | | | |
    |_|  \__,_|_|\__|_|  \__,_|\___|\__,_|_|\__|   \_/ \___|_|  |___/_|\___/|_| |_|

    */
    ULTRAEDIT VERSION
    ----------
    UltraEdit Professional Text/Hex Editor
    Version 32.10.31
    444mb

    /*___          _ _        _            _                           _
    |___ \    __ _| | |_ __ _(_)_ __   ___| | ___ __   _____ _ __ ___(_) ___  _ __
      __) |  / _` | | __/ _` | | `__| / __| |/ __|\ \ / / _ \ `__/ __| |/ _ \| `_ \
     / __/  | (_| | | || (_| | | |    \__ \ | (__  \ V /  __/ |  \__ \ | (_) | | | |
    |_____|  \__,_|_|\__\__,_|_|_|    |___/_|\___|  \_/ \___|_|  |___/_|\___/|_| |_|

    */
    Copyright 2002-2025 World Programming, an Altair Company
    Altair SLC 2026 (05.26.01.00.000758)
    This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    /*____    __       _     _                                    _
    |___ /   / _| ___ | | __| | ___ _ __ ___   _   _ ___  ___  __| |
      |_ \  | |_ / _ \| |/ _` |/ _ \ `__/ __| | | | / __|/ _ \/ _` |
     ___) | |  _| (_) | | (_| |  __/ |  \__ \ | |_| \__ \  __/ (_| |
    |____/  |_|  \___/|_|\__,_|\___|_|  |___/  \__,_|___/\___|\__,_|

    */

    1. You need this in your autoexec
       libname workx "d:/wpswrkx" or any folder

    2. c:/slc/current.log

    3. c/wpsoto/xls.sas  (autocall library with sas viewer tool)

    4. You need to have excel installed (should work with libre office calc or google excel)

    5. d:/wrk for temp work directory

    /*  _         _        _              _                 _
    | || |    ___| | ___  | |_ ___   ___ | |   ___ ___   __| | ___
    | || |_  / __| |/ __| | __/ _ \ / _ \| |  / __/ _ \ / _` |/ _ \
    |__   _| \__ \ | (__  | || (_) | (_) | | | (_| (_) | (_| |  __/
       |_|   |___/_|\___|  \__\___/ \___/|_|  \___\___/ \__,_|\___|

    */

    /*--- save program in "c:/wpsoto/xls.sas" ---*/
    data _null_;
     input;
     file "c:/wpsoto/xls.sas";
     put _infile_;
    cards4;
    filename clp clipbrd ;

    data _null_;
       infile clp;
       input;
       argx=_infile_;
       call symputx("argx",argx);
       putlog argx=;
    run;quit;

    /*--- delete c:\slc\current.xlsx if exists ---*/
    data _null_;
        fname="tempfile";
        rc=filename(fname, "c:\slc\current.xlsx");
        put rc=;
        if rc = 0 and fexist(fname) then
           rc=fdelete(fname);
    rc=filename(fname);
    run;

    /*--- sas dataset to excel ---*/
    libname __xls excel "c:\slc\current.xlsx";
    data __xls.myxlsx;
        set &argx(obs=1000);
    run;quit;
    libname __xls clear;

    /*--- open in excel ---*/
    options noxwait noxsync;
    /* Open Excel */
    x "'C:\Program Files\Microsoft Office\root\Office16\excel.exe' c:\slc\current.xlsx";
    run;
    x "exit";
    ;;;;
    run;

    /*___    _              _                    __ _
    | ___|  | |_ ___   ___ | |   ___ ___  _ __  / _(_) __ _
    |___ \  | __/ _ \ / _ \| |  / __/ _ \| `_ \| |_| |/ _` |
     ___) | | || (_) | (_) | | | (_| (_) | | | |  _| | (_| |
    |____/   \__\___/ \___/|_|  \___\___/|_| |_|_| |_|\__, |
                                                      |___/
    */

    Top menu should

    FILE HOME EDIT FORMAT VIEW CODING PROJECT LAYOUT WINDOW ADVANCED
                                                            --------
    Click on advance -> user tools -> configure tools -> insert

    select 'New Tool 1' on the bottom.

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /* TOOL CONFIGURATION                                                                                                     */
    /*------------------------------------------------------------------------------------------------------------------------*/
    /*                                                                                                                        */
    /*  COMMAND OPTIONS OUTPUT                                                                                                */
    /*                                                                                                                        */
    /*  Menu Item Name                                                                                                        */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  | New Tool 1                                                                                                |         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  Command Line                                                                                                          */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  |                                                                                                           |         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  Working directory                                                                                                     */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  |                                                                                                           |         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  Toolbar biymap/icon (leave blank)                                                                                     */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  |                                                                                                           |         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  You should see 'New Tool 1'                                                                                           */
    /*                                                                                                                        */
    /*  New Tool 1 (should be hi-lightd in blue)                                                                              */
    /*                                                                                                                        */
    /*---------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /* ----   --------   -------   ------                                                                                     */
    /* |OK|   |CANCEL|   |APPLY|   |HELP|                                                                                     */
    /* ----   --------   -------   ------                                                                                     */
    /*                                                                                                                        */
    /**************************************************************************************************************************/


     REPACE 'NEW TOOL 1' with xls and enter paths below

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /* TOOL CONFIGURATION                                                                                                     */
    /*------------------------------------------------------------------------------------------------------------------------*/
    /*                                                                                                                        */
    /*  COMMAND OPTIONS OUTPUT                                                                                                */
    /*                                                                                                                        */
    /*  Menu Item Name                                                                                                        */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  | xls                                                                                                       |         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  Command Line                                                                                                          */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  |"C:\Program Files\Altair\SLC\2026\bin\wps.exe" "c:/wpsoto/xlr.sas" -log "c:\slc\current.log" -work "d:/wrk"|         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  Working directory                                                                                                     */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  | c:/slc                                                                                                    |         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  Toolbar biymap/icon (leave blank)                                                                                     */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*  |                                                                                                           |         */
    /*  -------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /*  You should see in the list og tools                                                                                   */
    /*                                                                                                                        */
    /*  New Tool 1                                                                                                            */
    /*  xls                                                                                                                   */
    /*                                                                                                                        */
    /*---------------------------------------------------------------------------------------------------------------         */
    /*                                                                                                                        */
    /* ----   --------   -------   ------                                                                                     */
    /* |OK|   |CANCEL|   |APPLY|   |HELP|                                                                                     */
    /* ----   --------   -------   ------                                                                                     */
    /*                                                                                                                        */
    /* Apply > Ok                                                                                                             */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*__                   _               _           _   _
     / /_     __ _ ___ ___(_) __ _ _ __   | |__   ___ | |_| | _____ _   _
    | `_ \   / _` / __/ __| |/ _` | `_ \  | `_ \ / _ \| __| |/ / _ \ | | |
    | (_) | | (_| \__ \__ \ | (_| | | | | | | | | (_) | |_|   <  __/ |_| |
     \___/   \__,_|___/___/_|\__, |_| |_| |_| |_|\___/ \__|_|\_\___|\__, |
                             |___/                                  |___/
    */

    FILE HOME EDIT FORMAT VIEW CODING PROJECT LAYOUT WINDOW ADVANCED
                                                            --------
      Click on advanced > settings (third icon from right)

      Click on Settings

        Navigate to

          Key Mappings

        Command:
          User Tool 1

        I kept the existing key
          Cntl + Shift + 1

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
