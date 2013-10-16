<?php
//Include Common Files @1-0E2E0EBA
define("RelativePath", ".");
define("PathToCurrentPage", "/");
define("FileName", "usuarios_list.php");
include_once(RelativePath . "/Common.php");
include_once(RelativePath . "/Template.php");
include_once(RelativePath . "/Sorter.php");
include_once(RelativePath . "/Navigator.php");
//End Include Common Files

class clsGridusuarios { //usuarios class @2-D798D5ED

//Variables @2-E6258A20

    // Public variables
    var $ComponentType = "Grid";
    var $ComponentName;
    var $Visible;
    var $Errors;
    var $ErrorBlock;
    var $ds;
    var $DataSource;
    var $PageSize;
    var $IsEmpty;
    var $ForceIteration = false;
    var $HasRecord = false;
    var $SorterName = "";
    var $SorterDirection = "";
    var $PageNumber;
    var $RowNumber;
    var $ControlsVisible = array();

    var $CCSEvents = "";
    var $CCSEventResult;

    var $RelativePath = "";
    var $Attributes;

    // Grid Controls
    var $StaticControls;
    var $RowControls;
    var $Sorter_idlogin;
    var $Sorter_password;
    var $Sorter_idPerfil;
    var $Sorter_login;
//End Variables

//Class_Initialize Event @2-97F02D23
    function clsGridusuarios($RelativePath, & $Parent)
    {
        global $FileName;
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->ComponentName = "usuarios";
        $this->Visible = True;
        $this->Parent = & $Parent;
        $this->RelativePath = $RelativePath;
        $this->Errors = new clsErrors();
        $this->ErrorBlock = "Grid usuarios";
        $this->Attributes = new clsAttributes($this->ComponentName . ":");
        $this->DataSource = new clsusuariosDataSource($this);
        $this->ds = & $this->DataSource;
        $this->PageSize = CCGetParam($this->ComponentName . "PageSize", "");
        if(!is_numeric($this->PageSize) || !strlen($this->PageSize))
            $this->PageSize = 20;
        else
            $this->PageSize = intval($this->PageSize);
        if ($this->PageSize > 100)
            $this->PageSize = 100;
        if($this->PageSize == 0)
            $this->Errors->addError("<p>Form: Grid " . $this->ComponentName . "<br>Error: (CCS06) Invalid page size.</p>");
        $this->PageNumber = intval(CCGetParam($this->ComponentName . "Page", 1));
        if ($this->PageNumber <= 0) $this->PageNumber = 1;
        $this->SorterName = CCGetParam("usuariosOrder", "");
        $this->SorterDirection = CCGetParam("usuariosDir", "");

        $this->idlogin = & new clsControl(ccsLink, "idlogin", "idlogin", ccsInteger, "", CCGetRequestParam("idlogin", ccsGet, NULL), $this);
        $this->idlogin->Page = "usuarios_maint.php";
        $this->password = & new clsControl(ccsLabel, "password", "password", ccsText, "", CCGetRequestParam("password", ccsGet, NULL), $this);
        $this->idPerfil = & new clsControl(ccsLabel, "idPerfil", "idPerfil", ccsInteger, "", CCGetRequestParam("idPerfil", ccsGet, NULL), $this);
        $this->login = & new clsControl(ccsLabel, "login", "login", ccsText, "", CCGetRequestParam("login", ccsGet, NULL), $this);
        $this->usuarios_Insert = & new clsControl(ccsLink, "usuarios_Insert", "usuarios_Insert", ccsText, "", CCGetRequestParam("usuarios_Insert", ccsGet, NULL), $this);
        $this->usuarios_Insert->Parameters = CCGetQueryString("QueryString", array("idlogin", "ccsForm"));
        $this->usuarios_Insert->Page = "usuarios_maint.php";
        $this->Sorter_idlogin = & new clsSorter($this->ComponentName, "Sorter_idlogin", $FileName, $this);
        $this->Sorter_password = & new clsSorter($this->ComponentName, "Sorter_password", $FileName, $this);
        $this->Sorter_idPerfil = & new clsSorter($this->ComponentName, "Sorter_idPerfil", $FileName, $this);
        $this->Sorter_login = & new clsSorter($this->ComponentName, "Sorter_login", $FileName, $this);
        $this->Navigator = & new clsNavigator($this->ComponentName, "Navigator", $FileName, 10, tpSimple, $this);
        $this->Navigator->PageSizes = array("1", "5", "10", "25", "50");
    }
//End Class_Initialize Event

//Initialize Method @2-90E704C5
    function Initialize()
    {
        if(!$this->Visible) return;

        $this->DataSource->PageSize = & $this->PageSize;
        $this->DataSource->AbsolutePage = & $this->PageNumber;
        $this->DataSource->SetOrder($this->SorterName, $this->SorterDirection);
    }
//End Initialize Method

//Show Method @2-9CCC45BD
    function Show()
    {
        global $Tpl;
        global $CCSLocales;
        if(!$this->Visible) return;

        $this->RowNumber = 0;


        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeSelect", $this);


        $this->DataSource->Prepare();
        $this->DataSource->Open();
        $this->HasRecord = $this->DataSource->has_next_record();
        $this->IsEmpty = ! $this->HasRecord;
        $this->Attributes->Show();

        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeShow", $this);
        if(!$this->Visible) return;

        $GridBlock = "Grid " . $this->ComponentName;
        $ParentPath = $Tpl->block_path;
        $Tpl->block_path = $ParentPath . "/" . $GridBlock;


        if (!$this->IsEmpty) {
            $this->ControlsVisible["idlogin"] = $this->idlogin->Visible;
            $this->ControlsVisible["password"] = $this->password->Visible;
            $this->ControlsVisible["idPerfil"] = $this->idPerfil->Visible;
            $this->ControlsVisible["login"] = $this->login->Visible;
            while ($this->ForceIteration || (($this->RowNumber < $this->PageSize) &&  ($this->HasRecord = $this->DataSource->has_next_record()))) {
                $this->RowNumber++;
                if ($this->HasRecord) {
                    $this->DataSource->next_record();
                    $this->DataSource->SetValues();
                }
                $Tpl->block_path = $ParentPath . "/" . $GridBlock . "/Row";
                $this->idlogin->SetValue($this->DataSource->idlogin->GetValue());
                $this->idlogin->Parameters = CCGetQueryString("QueryString", array("ccsForm"));
                $this->idlogin->Parameters = CCAddParam($this->idlogin->Parameters, "idlogin", $this->DataSource->f("idlogin"));
                $this->password->SetValue($this->DataSource->password->GetValue());
                $this->idPerfil->SetValue($this->DataSource->idPerfil->GetValue());
                $this->login->SetValue($this->DataSource->login->GetValue());
                $this->Attributes->SetValue("rowNumber", $this->RowNumber);
                $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeShowRow", $this);
                $this->Attributes->Show();
                $this->idlogin->Show();
                $this->password->Show();
                $this->idPerfil->Show();
                $this->login->Show();
                $Tpl->block_path = $ParentPath . "/" . $GridBlock;
                $Tpl->parse("Row", true);
            }
        }
        else { // Show NoRecords block if no records are found
            $this->Attributes->Show();
            $Tpl->parse("NoRecords", false);
        }

        $errors = $this->GetErrors();
        if(strlen($errors))
        {
            $Tpl->replaceblock("", $errors);
            $Tpl->block_path = $ParentPath;
            return;
        }
        $this->Navigator->PageNumber = $this->DataSource->AbsolutePage;
        $this->Navigator->PageSize = $this->PageSize;
        if ($this->DataSource->RecordsCount == "CCS not counted")
            $this->Navigator->TotalPages = $this->DataSource->AbsolutePage + ($this->DataSource->next_record() ? 1 : 0);
        else
            $this->Navigator->TotalPages = $this->DataSource->PageCount();
        if ($this->Navigator->TotalPages <= 1) {
            $this->Navigator->Visible = false;
        }
        $this->usuarios_Insert->Show();
        $this->Sorter_idlogin->Show();
        $this->Sorter_password->Show();
        $this->Sorter_idPerfil->Show();
        $this->Sorter_login->Show();
        $this->Navigator->Show();
        $Tpl->parse();
        $Tpl->block_path = $ParentPath;
        $this->DataSource->close();
    }
//End Show Method

//GetErrors Method @2-B99CD0DF
    function GetErrors()
    {
        $errors = "";
        $errors = ComposeStrings($errors, $this->idlogin->Errors->ToString());
        $errors = ComposeStrings($errors, $this->password->Errors->ToString());
        $errors = ComposeStrings($errors, $this->idPerfil->Errors->ToString());
        $errors = ComposeStrings($errors, $this->login->Errors->ToString());
        $errors = ComposeStrings($errors, $this->Errors->ToString());
        $errors = ComposeStrings($errors, $this->DataSource->Errors->ToString());
        return $errors;
    }
//End GetErrors Method

} //End usuarios Class @2-FCB6E20C

class clsusuariosDataSource extends clsDBConnection1 {  //usuariosDataSource Class @2-3E421058

//DataSource Variables @2-6B99A97A
    var $Parent = "";
    var $CCSEvents = "";
    var $CCSEventResult;
    var $ErrorBlock;
    var $CmdExecution;

    var $CountSQL;
    var $wp;


    // Datasource fields
    var $idlogin;
    var $password;
    var $idPerfil;
    var $login;
//End DataSource Variables

//DataSourceClass_Initialize Event @2-832C60E0
    function clsusuariosDataSource(& $Parent)
    {
        $this->Parent = & $Parent;
        $this->ErrorBlock = "Grid usuarios";
        $this->Initialize();
        $this->idlogin = new clsField("idlogin", ccsInteger, "");
        
        $this->password = new clsField("password", ccsText, "");
        
        $this->idPerfil = new clsField("idPerfil", ccsInteger, "");
        
        $this->login = new clsField("login", ccsText, "");
        

    }
//End DataSourceClass_Initialize Event

//SetOrder Method @2-C69E5874
    function SetOrder($SorterName, $SorterDirection)
    {
        $this->Order = "";
        $this->Order = CCGetOrder($this->Order, $SorterName, $SorterDirection, 
            array("Sorter_idlogin" => array("idlogin", ""), 
            "Sorter_password" => array("password", ""), 
            "Sorter_idPerfil" => array("idPerfil", ""), 
            "Sorter_login" => array("login", "")));
    }
//End SetOrder Method

//Prepare Method @2-14D6CD9D
    function Prepare()
    {
        global $CCSLocales;
        global $DefaultDateFormat;
    }
//End Prepare Method

//Open Method @2-6675E640
    function Open()
    {
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeBuildSelect", $this->Parent);
        $this->CountSQL = "SELECT COUNT(*)\n\n" .
        "FROM usuarios";
        $this->SQL = "SELECT idlogin, password, idPerfil, login \n\n" .
        "FROM usuarios {SQL_Where} {SQL_OrderBy}";
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeExecuteSelect", $this->Parent);
        if ($this->CountSQL) 
            $this->RecordsCount = CCGetDBValue(CCBuildSQL($this->CountSQL, $this->Where, ""), $this);
        else
            $this->RecordsCount = "CCS not counted";
        $this->query($this->OptimizeSQL(CCBuildSQL($this->SQL, $this->Where, $this->Order)));
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterExecuteSelect", $this->Parent);
    }
//End Open Method

//SetValues Method @2-C1822DC0
    function SetValues()
    {
        $this->idlogin->SetDBValue(trim($this->f("idlogin")));
        $this->password->SetDBValue($this->f("password"));
        $this->idPerfil->SetDBValue(trim($this->f("idPerfil")));
        $this->login->SetDBValue($this->f("login"));
    }
//End SetValues Method

} //End usuariosDataSource Class @2-FCB6E20C

//Initialize Page @1-7BCB19B6
// Variables
$FileName = "";
$Redirect = "";
$Tpl = "";
$TemplateFileName = "";
$BlockToParse = "";
$ComponentName = "";
$Attributes = "";

// Events;
$CCSEvents = "";
$CCSEventResult = "";

$FileName = FileName;
$Redirect = "";
$TemplateFileName = "usuarios_list.html";
$BlockToParse = "main";
$TemplateEncoding = "CP1252";
$ContentType = "text/html";
$PathToRoot = "./";
$Charset = $Charset ? $Charset : "windows-1252";
//End Initialize Page

//Authenticate User @1-132EF5B6
CCSecurityRedirect("100", "");
//End Authenticate User

//Include events file @1-8DCE20FE
include_once("./usuarios_list_events.php");
//End Include events file

//Before Initialize @1-E870CEBC
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeInitialize", $MainPage);
//End Before Initialize

//Initialize Objects @1-B79557F3
$DBConnection1 = new clsDBConnection1();
$MainPage->Connections["Connection1"] = & $DBConnection1;
$Attributes = new clsAttributes("page:");
$MainPage->Attributes = & $Attributes;

// Controls
$usuarios = & new clsGridusuarios("", $MainPage);
$MainPage->usuarios = & $usuarios;
$usuarios->Initialize();

BindEvents();

$CCSEventResult = CCGetEvent($CCSEvents, "AfterInitialize", $MainPage);

if ($Charset) {
    header("Content-Type: " . $ContentType . "; charset=" . $Charset);
} else {
    header("Content-Type: " . $ContentType);
}
//End Initialize Objects

//Initialize HTML Template @1-E710DB26
$CCSEventResult = CCGetEvent($CCSEvents, "OnInitializeView", $MainPage);
$Tpl = new clsTemplate($FileEncoding, $TemplateEncoding);
$Tpl->LoadTemplate(PathToCurrentPage . $TemplateFileName, $BlockToParse, "CP1252");
$Tpl->block_path = "/$BlockToParse";
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeShow", $MainPage);
$Attributes->SetValue("pathToRoot", "");
$Attributes->Show();
//End Initialize HTML Template

//Go to destination page @1-270F92BD
if($Redirect)
{
    $CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
    $DBConnection1->close();
    header("Location: " . $Redirect);
    unset($usuarios);
    unset($Tpl);
    exit;
}
//End Go to destination page

//Show Page @1-46A904B7
$usuarios->Show();
$Tpl->block_path = "";
$Tpl->Parse($BlockToParse, false);
if (!isset($main_block)) $main_block = $Tpl->GetVar($BlockToParse);
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeOutput", $MainPage);
if ($CCSEventResult) echo $main_block;
//End Show Page

//Unload Page @1-1E5CD254
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
$DBConnection1->close();
unset($usuarios);
unset($Tpl);
//End Unload Page


?>
