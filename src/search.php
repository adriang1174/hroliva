<?php
//Include Common Files @1-FD647395
define("RelativePath", ".");
define("PathToCurrentPage", "/");
define("FileName", "search.php");
include_once(RelativePath . "/Common.php");
include_once(RelativePath . "/Template.php");
include_once(RelativePath . "/Sorter.php");
include_once(RelativePath . "/Navigator.php");
//End Include Common Files

class clsRecordpropiedades { //propiedades Class @11-915B4767

//Variables @11-D6FF3E86

    // Public variables
    var $ComponentType = "Record";
    var $ComponentName;
    var $Parent;
    var $HTMLFormAction;
    var $PressedButton;
    var $Errors;
    var $ErrorBlock;
    var $FormSubmitted;
    var $FormEnctype;
    var $Visible;
    var $IsEmpty;

    var $CCSEvents = "";
    var $CCSEventResult;

    var $RelativePath = "";

    var $InsertAllowed = false;
    var $UpdateAllowed = false;
    var $DeleteAllowed = false;
    var $ReadAllowed   = false;
    var $EditMode      = false;
    var $ds;
    var $DataSource;
    var $ValidatingControls;
    var $Controls;
    var $Attributes;

    // Class variables
//End Variables

//Class_Initialize Event @11-324C52CB
    function clsRecordpropiedades($RelativePath, & $Parent)
    {

        global $FileName;
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->Visible = true;
        $this->Parent = & $Parent;
        $this->RelativePath = $RelativePath;
        $this->Errors = new clsErrors();
        $this->ErrorBlock = "Record propiedades/Error";
        $this->ReadAllowed = true;
        if($this->Visible)
        {
            $this->ComponentName = "propiedades";
            $this->Attributes = new clsAttributes($this->ComponentName . ":");
            $CCSForm = split(":", CCGetFromGet("ccsForm", ""), 2);
            if(sizeof($CCSForm) == 1)
                $CCSForm[1] = "";
            list($FormName, $FormMethod) = $CCSForm;
            $this->FormEnctype = "application/x-www-form-urlencoded";
            $this->FormSubmitted = ($FormName == $this->ComponentName);
            $Method = $this->FormSubmitted ? ccsPost : ccsGet;
            $this->Button_DoSearch = & new clsButton("Button_DoSearch", $Method, $this);
            $this->s_idZona = & new clsControl(ccsListBox, "s_idZona", "s_idZona", ccsInteger, "", CCGetRequestParam("s_idZona", $Method, NULL), $this);
            $this->s_idZona->DSType = dsTable;
            $this->s_idZona->DataSource = new clsDBConnection1();
            $this->s_idZona->ds = & $this->s_idZona->DataSource;
            $this->s_idZona->DataSource->SQL = "SELECT * \n" .
"FROM zonas {SQL_Where} {SQL_OrderBy}";
            list($this->s_idZona->BoundColumn, $this->s_idZona->TextColumn, $this->s_idZona->DBFormat) = array("idZona", "descripcion", "");
            $this->s_idOperacion = & new clsControl(ccsListBox, "s_idOperacion", "s_idOperacion", ccsInteger, "", CCGetRequestParam("s_idOperacion", $Method, NULL), $this);
            $this->s_idOperacion->DSType = dsTable;
            $this->s_idOperacion->DataSource = new clsDBConnection1();
            $this->s_idOperacion->ds = & $this->s_idOperacion->DataSource;
            $this->s_idOperacion->DataSource->SQL = "SELECT * \n" .
"FROM operaciones {SQL_Where} {SQL_OrderBy}";
            list($this->s_idOperacion->BoundColumn, $this->s_idOperacion->TextColumn, $this->s_idOperacion->DBFormat) = array("idOperacion", "descripcion", "");
            $this->s_idTipo = & new clsControl(ccsListBox, "s_idTipo", "s_idTipo", ccsInteger, "", CCGetRequestParam("s_idTipo", $Method, NULL), $this);
            $this->s_idTipo->DSType = dsTable;
            $this->s_idTipo->DataSource = new clsDBConnection1();
            $this->s_idTipo->ds = & $this->s_idTipo->DataSource;
            $this->s_idTipo->DataSource->SQL = "SELECT * \n" .
"FROM tipo_propiedad {SQL_Where} {SQL_OrderBy}";
            list($this->s_idTipo->BoundColumn, $this->s_idTipo->TextColumn, $this->s_idTipo->DBFormat) = array("idTipo", "descripcion", "");
            $this->s_dormitorios = & new clsControl(ccsListBox, "s_dormitorios", "s_dormitorios", ccsInteger, "", CCGetRequestParam("s_dormitorios", $Method, NULL), $this);
            $this->s_dormitorios->DSType = dsListOfValues;
            $this->s_dormitorios->Values = array(array("1", "1"), array("2", "2"), array("3", "3"), array("4", "4"));
            $this->s_idMoneda = & new clsControl(ccsListBox, "s_idMoneda", "s_idMoneda", ccsInteger, "", CCGetRequestParam("s_idMoneda", $Method, NULL), $this);
            $this->s_idMoneda->DSType = dsTable;
            $this->s_idMoneda->DataSource = new clsDBConnection1();
            $this->s_idMoneda->ds = & $this->s_idMoneda->DataSource;
            $this->s_idMoneda->DataSource->SQL = "SELECT * \n" .
"FROM moneda {SQL_Where} {SQL_OrderBy}";
            list($this->s_idMoneda->BoundColumn, $this->s_idMoneda->TextColumn, $this->s_idMoneda->DBFormat) = array("idMoneda", "descripcion", "");
            $this->s_valor = & new clsControl(ccsListBox, "s_valor", "s_valor", ccsText, "", CCGetRequestParam("s_valor", $Method, NULL), $this);
            $this->s_valor->DSType = dsTable;
            $this->s_valor->DataSource = new clsDBConnection1();
            $this->s_valor->ds = & $this->s_valor->DataSource;
            $this->s_valor->DataSource->SQL = "SELECT * \n" .
"FROM rango_valor {SQL_Where} {SQL_OrderBy}";
            list($this->s_valor->BoundColumn, $this->s_valor->TextColumn, $this->s_valor->DBFormat) = array("idRango", "valor", "");
            $this->s_valorhasta = & new clsControl(ccsListBox, "s_valorhasta", "s_valorhasta", ccsText, "", CCGetRequestParam("s_valorhasta", $Method, NULL), $this);
            $this->s_valorhasta->DSType = dsTable;
            $this->s_valorhasta->DataSource = new clsDBConnection1();
            $this->s_valorhasta->ds = & $this->s_valorhasta->DataSource;
            $this->s_valorhasta->DataSource->SQL = "SELECT * \n" .
"FROM rango_valor {SQL_Where} {SQL_OrderBy}";
            list($this->s_valorhasta->BoundColumn, $this->s_valorhasta->TextColumn, $this->s_valorhasta->DBFormat) = array("idRango", "valor", "");
        }
    }
//End Class_Initialize Event

//Validate Method @11-0DA62AF6
    function Validate()
    {
        global $CCSLocales;
        $Validation = true;
        $Where = "";
        $Validation = ($this->s_idZona->Validate() && $Validation);
        $Validation = ($this->s_idOperacion->Validate() && $Validation);
        $Validation = ($this->s_idTipo->Validate() && $Validation);
        $Validation = ($this->s_dormitorios->Validate() && $Validation);
        $Validation = ($this->s_idMoneda->Validate() && $Validation);
        $Validation = ($this->s_valor->Validate() && $Validation);
        $Validation = ($this->s_valorhasta->Validate() && $Validation);
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "OnValidate", $this);
        $Validation =  $Validation && ($this->s_idZona->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_idOperacion->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_idTipo->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_dormitorios->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_idMoneda->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_valor->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_valorhasta->Errors->Count() == 0);
        return (($this->Errors->Count() == 0) && $Validation);
    }
//End Validate Method

//CheckErrors Method @11-0132EAAC
    function CheckErrors()
    {
        $errors = false;
        $errors = ($errors || $this->s_idZona->Errors->Count());
        $errors = ($errors || $this->s_idOperacion->Errors->Count());
        $errors = ($errors || $this->s_idTipo->Errors->Count());
        $errors = ($errors || $this->s_dormitorios->Errors->Count());
        $errors = ($errors || $this->s_idMoneda->Errors->Count());
        $errors = ($errors || $this->s_valor->Errors->Count());
        $errors = ($errors || $this->s_valorhasta->Errors->Count());
        $errors = ($errors || $this->Errors->Count());
        return $errors;
    }
//End CheckErrors Method

//MasterDetail @11-ED598703
function SetPrimaryKeys($keyArray)
{
    $this->PrimaryKeys = $keyArray;
}
function GetPrimaryKeys()
{
    return $this->PrimaryKeys;
}
function GetPrimaryKey($keyName)
{
    return $this->PrimaryKeys[$keyName];
}
//End MasterDetail

//Operation Method @11-C84B2A90
    function Operation()
    {
        if(!$this->Visible)
            return;

        global $Redirect;
        global $FileName;

        if(!$this->FormSubmitted) {
            return;
        }

        if($this->FormSubmitted) {
            $this->PressedButton = "Button_DoSearch";
            if($this->Button_DoSearch->Pressed) {
                $this->PressedButton = "Button_DoSearch";
            }
        }
        $Redirect = "record.php";
        if($this->Validate()) {
            if($this->PressedButton == "Button_DoSearch") {
                $Redirect = "record.php" . "?" . CCMergeQueryStrings(CCGetQueryString("Form", array("Button_DoSearch", "Button_DoSearch_x", "Button_DoSearch_y")));
                if(!CCGetEvent($this->Button_DoSearch->CCSEvents, "OnClick", $this->Button_DoSearch)) {
                    $Redirect = "";
                }
            }
        } else {
            $Redirect = "";
        }
    }
//End Operation Method

//Show Method @11-420B788E
    function Show()
    {
        global $CCSUseAmp;
        global $Tpl;
        global $FileName;
        global $CCSLocales;
        $Error = "";

        if(!$this->Visible)
            return;

        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeSelect", $this);

        $this->s_idZona->Prepare();
        $this->s_idOperacion->Prepare();
        $this->s_idTipo->Prepare();
        $this->s_dormitorios->Prepare();
        $this->s_idMoneda->Prepare();
        $this->s_valor->Prepare();
        $this->s_valorhasta->Prepare();

        $RecordBlock = "Record " . $this->ComponentName;
        $ParentPath = $Tpl->block_path;
        $Tpl->block_path = $ParentPath . "/" . $RecordBlock;
        $this->EditMode = $this->EditMode && $this->ReadAllowed;
        if (!$this->FormSubmitted) {
        }

        if($this->FormSubmitted || $this->CheckErrors()) {
            $Error = "";
            $Error = ComposeStrings($Error, $this->s_idZona->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_idOperacion->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_idTipo->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_dormitorios->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_idMoneda->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_valor->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_valorhasta->Errors->ToString());
            $Error = ComposeStrings($Error, $this->Errors->ToString());
            $Tpl->SetVar("Error", $Error);
            $Tpl->Parse("Error", false);
        }
        $CCSForm = $this->EditMode ? $this->ComponentName . ":" . "Edit" : $this->ComponentName;
        $this->HTMLFormAction = $FileName . "?" . CCAddParam(CCGetQueryString("QueryString", ""), "ccsForm", $CCSForm);
        $Tpl->SetVar("Action", !$CCSUseAmp ? $this->HTMLFormAction : str_replace("&", "&amp;", $this->HTMLFormAction));
        $Tpl->SetVar("HTMLFormName", $this->ComponentName);
        $Tpl->SetVar("HTMLFormEnctype", $this->FormEnctype);

        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeShow", $this);
        $this->Attributes->Show();
        if(!$this->Visible) {
            $Tpl->block_path = $ParentPath;
            return;
        }

        $this->Button_DoSearch->Show();
        $this->s_idZona->Show();
        $this->s_idOperacion->Show();
        $this->s_idTipo->Show();
        $this->s_dormitorios->Show();
        $this->s_idMoneda->Show();
        $this->s_valor->Show();
        $this->s_valorhasta->Show();
        $Tpl->parse();
        $Tpl->block_path = $ParentPath;
    }
//End Show Method

} //End propiedades Class @11-FCB6E20C

//Initialize Page @1-E3D132EE
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
$TemplateFileName = "search.html";
$BlockToParse = "main";
$TemplateEncoding = "CP1252";
$ContentType = "text/html";
$PathToRoot = "./";
$Charset = $Charset ? $Charset : "windows-1252";
//End Initialize Page

//Before Initialize @1-E870CEBC
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeInitialize", $MainPage);
//End Before Initialize

//Initialize Objects @1-C502776E
$DBConnection1 = new clsDBConnection1();
$MainPage->Connections["Connection1"] = & $DBConnection1;
$Attributes = new clsAttributes("page:");
$MainPage->Attributes = & $Attributes;

// Controls
$propiedades = & new clsRecordpropiedades("", $MainPage);
$MainPage->propiedades = & $propiedades;

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

//Execute Components @1-4496EF1A
$propiedades->Operation();
//End Execute Components

//Go to destination page @1-7AFBFF0F
if($Redirect)
{
    $CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
    $DBConnection1->close();
    header("Location: " . $Redirect);
    unset($propiedades);
    unset($Tpl);
    exit;
}
//End Go to destination page

//Show Page @1-C2B4FE35
$propiedades->Show();
$Tpl->block_path = "";
$Tpl->Parse($BlockToParse, false);
if (!isset($main_block)) $main_block = $Tpl->GetVar($BlockToParse);
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeOutput", $MainPage);
if ($CCSEventResult) echo $main_block;
//End Show Page

//Unload Page @1-F2E7B0FD
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
$DBConnection1->close();
unset($propiedades);
unset($Tpl);
//End Unload Page


?>
