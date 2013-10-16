<?php
//Include Common Files @1-ACEA7A8D
define("RelativePath", ".");
define("PathToCurrentPage", "/");
define("FileName", "propiedades_list.php");
include_once(RelativePath . "/Common.php");
include_once(RelativePath . "/Template.php");
include_once(RelativePath . "/Sorter.php");
include_once(RelativePath . "/Navigator.php");
//End Include Common Files

class clsRecordpropiedadesSearch { //propiedadesSearch Class @2-4F50A3E6

//Variables @2-D6FF3E86

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

//Class_Initialize Event @2-E7AFFB1D
    function clsRecordpropiedadesSearch($RelativePath, & $Parent)
    {

        global $FileName;
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->Visible = true;
        $this->Parent = & $Parent;
        $this->RelativePath = $RelativePath;
        $this->Errors = new clsErrors();
        $this->ErrorBlock = "Record propiedadesSearch/Error";
        $this->ReadAllowed = true;
        if($this->Visible)
        {
            $this->ComponentName = "propiedadesSearch";
            $this->Attributes = new clsAttributes($this->ComponentName . ":");
            $CCSForm = split(":", CCGetFromGet("ccsForm", ""), 2);
            if(sizeof($CCSForm) == 1)
                $CCSForm[1] = "";
            list($FormName, $FormMethod) = $CCSForm;
            $this->FormEnctype = "application/x-www-form-urlencoded";
            $this->FormSubmitted = ($FormName == $this->ComponentName);
            $Method = $this->FormSubmitted ? ccsPost : ccsGet;
            $this->Button_DoSearch = & new clsButton("Button_DoSearch", $Method, $this);
            $this->s_descripcion = & new clsControl(ccsTextBox, "s_descripcion", "s_descripcion", ccsText, "", CCGetRequestParam("s_descripcion", $Method, NULL), $this);
            $this->s_valor = & new clsControl(ccsTextBox, "s_valor", "s_valor", ccsText, "", CCGetRequestParam("s_valor", $Method, NULL), $this);
            $this->s_tipo = & new clsControl(ccsListBox, "s_tipo", "s_tipo", ccsInteger, "", CCGetRequestParam("s_tipo", $Method, NULL), $this);
            $this->s_tipo->DSType = dsTable;
            $this->s_tipo->DataSource = new clsDBConnection1();
            $this->s_tipo->ds = & $this->s_tipo->DataSource;
            $this->s_tipo->DataSource->SQL = "SELECT * \n" .
"FROM tipo_propiedad {SQL_Where} {SQL_OrderBy}";
            list($this->s_tipo->BoundColumn, $this->s_tipo->TextColumn, $this->s_tipo->DBFormat) = array("idTipo", "descripcion", "");
        }
    }
//End Class_Initialize Event

//Validate Method @2-5F65C6B6
    function Validate()
    {
        global $CCSLocales;
        $Validation = true;
        $Where = "";
        $Validation = ($this->s_descripcion->Validate() && $Validation);
        $Validation = ($this->s_valor->Validate() && $Validation);
        $Validation = ($this->s_tipo->Validate() && $Validation);
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "OnValidate", $this);
        $Validation =  $Validation && ($this->s_descripcion->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_valor->Errors->Count() == 0);
        $Validation =  $Validation && ($this->s_tipo->Errors->Count() == 0);
        return (($this->Errors->Count() == 0) && $Validation);
    }
//End Validate Method

//CheckErrors Method @2-7B58B356
    function CheckErrors()
    {
        $errors = false;
        $errors = ($errors || $this->s_descripcion->Errors->Count());
        $errors = ($errors || $this->s_valor->Errors->Count());
        $errors = ($errors || $this->s_tipo->Errors->Count());
        $errors = ($errors || $this->Errors->Count());
        return $errors;
    }
//End CheckErrors Method

//MasterDetail @2-ED598703
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

//Operation Method @2-6900252C
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
        $Redirect = "propiedades_list.php";
        if($this->Validate()) {
            if($this->PressedButton == "Button_DoSearch") {
                $Redirect = "propiedades_list.php" . "?" . CCMergeQueryStrings(CCGetQueryString("Form", array("Button_DoSearch", "Button_DoSearch_x", "Button_DoSearch_y")));
                if(!CCGetEvent($this->Button_DoSearch->CCSEvents, "OnClick", $this->Button_DoSearch)) {
                    $Redirect = "";
                }
            }
        } else {
            $Redirect = "";
        }
    }
//End Operation Method

//Show Method @2-F9787DC0
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

        $this->s_tipo->Prepare();

        $RecordBlock = "Record " . $this->ComponentName;
        $ParentPath = $Tpl->block_path;
        $Tpl->block_path = $ParentPath . "/" . $RecordBlock;
        $this->EditMode = $this->EditMode && $this->ReadAllowed;
        if (!$this->FormSubmitted) {
        }

        if($this->FormSubmitted || $this->CheckErrors()) {
            $Error = "";
            $Error = ComposeStrings($Error, $this->s_descripcion->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_valor->Errors->ToString());
            $Error = ComposeStrings($Error, $this->s_tipo->Errors->ToString());
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
        $this->s_descripcion->Show();
        $this->s_valor->Show();
        $this->s_tipo->Show();
        $Tpl->parse();
        $Tpl->block_path = $ParentPath;
    }
//End Show Method

} //End propiedadesSearch Class @2-FCB6E20C

class clsGridpropiedades { //propiedades class @6-9DCFE072

//Variables @6-437E4B3A

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
    var $Sorter_id;
    var $Sorter_idZona;
    var $Sorter_idOperacion;
    var $Sorter_idTipo;
    var $Sorter_descripcion;
    var $Sorter_dormitorios;
    var $Sorter_valor;
    var $Sorter_activo;
    var $Sorter_orden;
//End Variables

//Class_Initialize Event @6-2CBB7D46
    function clsGridpropiedades($RelativePath, & $Parent)
    {
        global $FileName;
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->ComponentName = "propiedades";
        $this->Visible = True;
        $this->Parent = & $Parent;
        $this->RelativePath = $RelativePath;
        $this->Errors = new clsErrors();
        $this->ErrorBlock = "Grid propiedades";
        $this->Attributes = new clsAttributes($this->ComponentName . ":");
        $this->DataSource = new clspropiedadesDataSource($this);
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
        $this->SorterName = CCGetParam("propiedadesOrder", "");
        $this->SorterDirection = CCGetParam("propiedadesDir", "");

        $this->id = & new clsControl(ccsLink, "id", "id", ccsText, "", CCGetRequestParam("id", ccsGet, NULL), $this);
        $this->id->Page = "propiedades_maint.php";
        $this->idZona = & new clsControl(ccsLabel, "idZona", "idZona", ccsText, "", CCGetRequestParam("idZona", ccsGet, NULL), $this);
        $this->idOperacion = & new clsControl(ccsLabel, "idOperacion", "idOperacion", ccsText, "", CCGetRequestParam("idOperacion", ccsGet, NULL), $this);
        $this->idTipo = & new clsControl(ccsLabel, "idTipo", "idTipo", ccsText, "", CCGetRequestParam("idTipo", ccsGet, NULL), $this);
        $this->descripcion = & new clsControl(ccsLabel, "descripcion", "descripcion", ccsText, "", CCGetRequestParam("descripcion", ccsGet, NULL), $this);
        $this->dormitorios = & new clsControl(ccsLabel, "dormitorios", "dormitorios", ccsInteger, "", CCGetRequestParam("dormitorios", ccsGet, NULL), $this);
        $this->valor = & new clsControl(ccsLabel, "valor", "valor", ccsText, "", CCGetRequestParam("valor", ccsGet, NULL), $this);
        $this->activo = & new clsControl(ccsLabel, "activo", "activo", ccsInteger, "", CCGetRequestParam("activo", ccsGet, NULL), $this);
        $this->orden = & new clsControl(ccsLabel, "orden", "orden", ccsInteger, "", CCGetRequestParam("orden", ccsGet, NULL), $this);
        $this->Link1 = & new clsControl(ccsLink, "Link1", "Link1", ccsText, "", CCGetRequestParam("Link1", ccsGet, NULL), $this);
        $this->Link1->Page = "attach.php";
        $this->moneda = & new clsControl(ccsLabel, "moneda", "moneda", ccsText, "", CCGetRequestParam("moneda", ccsGet, NULL), $this);
        $this->propiedades_Insert = & new clsControl(ccsLink, "propiedades_Insert", "propiedades_Insert", ccsText, "", CCGetRequestParam("propiedades_Insert", ccsGet, NULL), $this);
        $this->propiedades_Insert->Parameters = CCGetQueryString("QueryString", array("id", "ccsForm"));
        $this->propiedades_Insert->Page = "propiedades_maint.php";
        $this->Sorter_id = & new clsSorter($this->ComponentName, "Sorter_id", $FileName, $this);
        $this->Sorter_idZona = & new clsSorter($this->ComponentName, "Sorter_idZona", $FileName, $this);
        $this->Sorter_idOperacion = & new clsSorter($this->ComponentName, "Sorter_idOperacion", $FileName, $this);
        $this->Sorter_idTipo = & new clsSorter($this->ComponentName, "Sorter_idTipo", $FileName, $this);
        $this->Sorter_descripcion = & new clsSorter($this->ComponentName, "Sorter_descripcion", $FileName, $this);
        $this->Sorter_dormitorios = & new clsSorter($this->ComponentName, "Sorter_dormitorios", $FileName, $this);
        $this->Sorter_valor = & new clsSorter($this->ComponentName, "Sorter_valor", $FileName, $this);
        $this->Sorter_activo = & new clsSorter($this->ComponentName, "Sorter_activo", $FileName, $this);
        $this->Sorter_orden = & new clsSorter($this->ComponentName, "Sorter_orden", $FileName, $this);
        $this->Navigator = & new clsNavigator($this->ComponentName, "Navigator", $FileName, 10, tpSimple, $this);
        $this->Navigator->PageSizes = array("1", "5", "10", "25", "50");
    }
//End Class_Initialize Event

//Initialize Method @6-90E704C5
    function Initialize()
    {
        if(!$this->Visible) return;

        $this->DataSource->PageSize = & $this->PageSize;
        $this->DataSource->AbsolutePage = & $this->PageNumber;
        $this->DataSource->SetOrder($this->SorterName, $this->SorterDirection);
    }
//End Initialize Method

//Show Method @6-E54FBD9C
    function Show()
    {
        global $Tpl;
        global $CCSLocales;
        if(!$this->Visible) return;

        $this->RowNumber = 0;

        $this->DataSource->Parameters["urls_valor"] = CCGetFromGet("s_valor", NULL);
        $this->DataSource->Parameters["urls_tipo"] = CCGetFromGet("s_tipo", NULL);
        $this->DataSource->Parameters["urls_descripcion"] = CCGetFromGet("s_descripcion", NULL);

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
            $this->ControlsVisible["id"] = $this->id->Visible;
            $this->ControlsVisible["idZona"] = $this->idZona->Visible;
            $this->ControlsVisible["idOperacion"] = $this->idOperacion->Visible;
            $this->ControlsVisible["idTipo"] = $this->idTipo->Visible;
            $this->ControlsVisible["descripcion"] = $this->descripcion->Visible;
            $this->ControlsVisible["dormitorios"] = $this->dormitorios->Visible;
            $this->ControlsVisible["valor"] = $this->valor->Visible;
            $this->ControlsVisible["activo"] = $this->activo->Visible;
            $this->ControlsVisible["orden"] = $this->orden->Visible;
            $this->ControlsVisible["Link1"] = $this->Link1->Visible;
            $this->ControlsVisible["moneda"] = $this->moneda->Visible;
            while ($this->ForceIteration || (($this->RowNumber < $this->PageSize) &&  ($this->HasRecord = $this->DataSource->has_next_record()))) {
                $this->RowNumber++;
                if ($this->HasRecord) {
                    $this->DataSource->next_record();
                    $this->DataSource->SetValues();
                }
                $Tpl->block_path = $ParentPath . "/" . $GridBlock . "/Row";
                $this->id->SetValue($this->DataSource->id->GetValue());
                $this->id->Parameters = CCGetQueryString("QueryString", array("ccsForm"));
                $this->id->Parameters = CCAddParam($this->id->Parameters, "id", $this->DataSource->f("idPropiedad"));
                $this->idZona->SetValue($this->DataSource->idZona->GetValue());
                $this->idOperacion->SetValue($this->DataSource->idOperacion->GetValue());
                $this->idTipo->SetValue($this->DataSource->idTipo->GetValue());
                $this->descripcion->SetValue($this->DataSource->descripcion->GetValue());
                $this->dormitorios->SetValue($this->DataSource->dormitorios->GetValue());
                $this->valor->SetValue($this->DataSource->valor->GetValue());
                $this->activo->SetValue($this->DataSource->activo->GetValue());
                $this->orden->SetValue($this->DataSource->orden->GetValue());
                $this->Link1->Parameters = CCGetQueryString("QueryString", array("ccsForm"));
                $this->Link1->Parameters = CCAddParam($this->Link1->Parameters, "id", $this->DataSource->f("idPropiedad"));
                $this->moneda->SetValue($this->DataSource->moneda->GetValue());
                $this->Attributes->SetValue("rowNumber", $this->RowNumber);
                $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeShowRow", $this);
                $this->Attributes->Show();
                $this->id->Show();
                $this->idZona->Show();
                $this->idOperacion->Show();
                $this->idTipo->Show();
                $this->descripcion->Show();
                $this->dormitorios->Show();
                $this->valor->Show();
                $this->activo->Show();
                $this->orden->Show();
                $this->Link1->Show();
                $this->moneda->Show();
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
        $this->propiedades_Insert->Show();
        $this->Sorter_id->Show();
        $this->Sorter_idZona->Show();
        $this->Sorter_idOperacion->Show();
        $this->Sorter_idTipo->Show();
        $this->Sorter_descripcion->Show();
        $this->Sorter_dormitorios->Show();
        $this->Sorter_valor->Show();
        $this->Sorter_activo->Show();
        $this->Sorter_orden->Show();
        $this->Navigator->Show();
        $Tpl->parse();
        $Tpl->block_path = $ParentPath;
        $this->DataSource->close();
    }
//End Show Method

//GetErrors Method @6-B5546326
    function GetErrors()
    {
        $errors = "";
        $errors = ComposeStrings($errors, $this->id->Errors->ToString());
        $errors = ComposeStrings($errors, $this->idZona->Errors->ToString());
        $errors = ComposeStrings($errors, $this->idOperacion->Errors->ToString());
        $errors = ComposeStrings($errors, $this->idTipo->Errors->ToString());
        $errors = ComposeStrings($errors, $this->descripcion->Errors->ToString());
        $errors = ComposeStrings($errors, $this->dormitorios->Errors->ToString());
        $errors = ComposeStrings($errors, $this->valor->Errors->ToString());
        $errors = ComposeStrings($errors, $this->activo->Errors->ToString());
        $errors = ComposeStrings($errors, $this->orden->Errors->ToString());
        $errors = ComposeStrings($errors, $this->Link1->Errors->ToString());
        $errors = ComposeStrings($errors, $this->moneda->Errors->ToString());
        $errors = ComposeStrings($errors, $this->Errors->ToString());
        $errors = ComposeStrings($errors, $this->DataSource->Errors->ToString());
        return $errors;
    }
//End GetErrors Method

} //End propiedades Class @6-FCB6E20C

class clspropiedadesDataSource extends clsDBConnection1 {  //propiedadesDataSource Class @6-0FC356A5

//DataSource Variables @6-0A4452CC
    var $Parent = "";
    var $CCSEvents = "";
    var $CCSEventResult;
    var $ErrorBlock;
    var $CmdExecution;

    var $CountSQL;
    var $wp;


    // Datasource fields
    var $id;
    var $idZona;
    var $idOperacion;
    var $idTipo;
    var $descripcion;
    var $dormitorios;
    var $valor;
    var $activo;
    var $orden;
    var $moneda;
//End DataSource Variables

//DataSourceClass_Initialize Event @6-4501AC91
    function clspropiedadesDataSource(& $Parent)
    {
        $this->Parent = & $Parent;
        $this->ErrorBlock = "Grid propiedades";
        $this->Initialize();
        $this->id = new clsField("id", ccsText, "");
        
        $this->idZona = new clsField("idZona", ccsText, "");
        
        $this->idOperacion = new clsField("idOperacion", ccsText, "");
        
        $this->idTipo = new clsField("idTipo", ccsText, "");
        
        $this->descripcion = new clsField("descripcion", ccsText, "");
        
        $this->dormitorios = new clsField("dormitorios", ccsInteger, "");
        
        $this->valor = new clsField("valor", ccsText, "");
        
        $this->activo = new clsField("activo", ccsInteger, "");
        
        $this->orden = new clsField("orden", ccsInteger, "");
        
        $this->moneda = new clsField("moneda", ccsText, "");
        

    }
//End DataSourceClass_Initialize Event

//SetOrder Method @6-B37938E9
    function SetOrder($SorterName, $SorterDirection)
    {
        $this->Order = "";
        $this->Order = CCGetOrder($this->Order, $SorterName, $SorterDirection, 
            array("Sorter_id" => array("id", ""), 
            "Sorter_idZona" => array("idZona", ""), 
            "Sorter_idOperacion" => array("idOperacion", ""), 
            "Sorter_idTipo" => array("idTipo", ""), 
            "Sorter_descripcion" => array("descripcion", ""), 
            "Sorter_dormitorios" => array("dormitorios", ""), 
            "Sorter_valor" => array("valor", ""), 
            "Sorter_activo" => array("activo", ""), 
            "Sorter_orden" => array("orden", "")));
    }
//End SetOrder Method

//Prepare Method @6-0082B2B7
    function Prepare()
    {
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->wp = new clsSQLParameters($this->ErrorBlock);
        $this->wp->AddParameter("1", "urls_valor", ccsText, "", "", $this->Parameters["urls_valor"], "", false);
        $this->wp->AddParameter("2", "urls_tipo", ccsInteger, "", "", $this->Parameters["urls_tipo"], "", false);
        $this->wp->AddParameter("3", "urls_descripcion", ccsText, "", "", $this->Parameters["urls_descripcion"], "", false);
        $this->wp->Criterion[1] = $this->wp->Operation(opContains, "valor", $this->wp->GetDBValue("1"), $this->ToSQL($this->wp->GetDBValue("1"), ccsText),false);
        $this->wp->Criterion[2] = $this->wp->Operation(opContains, "idTipo", $this->wp->GetDBValue("2"), $this->ToSQL($this->wp->GetDBValue("2"), ccsInteger),false);
        $this->wp->Criterion[3] = $this->wp->Operation(opContains, "id", $this->wp->GetDBValue("3"), $this->ToSQL($this->wp->GetDBValue("3"), ccsText),false);
        $this->Where = $this->wp->opAND(
             false, $this->wp->opAND(
             false, 
             $this->wp->Criterion[1], 
             $this->wp->Criterion[2]), 
             $this->wp->Criterion[3]);
    }
//End Prepare Method

//Open Method @6-0086848D
    function Open()
    {
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeBuildSelect", $this->Parent);
        $this->CountSQL = "SELECT COUNT(*)\n\n" .
        "FROM propiedades";
        $this->SQL = "SELECT id, idZona, idOperacion, idTipo, descripcion, dormitorios, valor, activo, orden, idMoneda, idPropiedad \n\n" .
        "FROM propiedades {SQL_Where} {SQL_OrderBy}";
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeExecuteSelect", $this->Parent);
        if ($this->CountSQL) 
            $this->RecordsCount = CCGetDBValue(CCBuildSQL($this->CountSQL, $this->Where, ""), $this);
        else
            $this->RecordsCount = "CCS not counted";
        $this->query($this->OptimizeSQL(CCBuildSQL($this->SQL, $this->Where, $this->Order)));
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterExecuteSelect", $this->Parent);
    }
//End Open Method

//SetValues Method @6-4F913CE0
    function SetValues()
    {
        $this->id->SetDBValue($this->f("id"));
        $this->idZona->SetDBValue($this->f("idZona"));
        $this->idOperacion->SetDBValue($this->f("idOperacion"));
        $this->idTipo->SetDBValue($this->f("idTipo"));
        $this->descripcion->SetDBValue($this->f("descripcion"));
        $this->dormitorios->SetDBValue(trim($this->f("dormitorios")));
        $this->valor->SetDBValue($this->f("valor"));
        $this->activo->SetDBValue(trim($this->f("activo")));
        $this->orden->SetDBValue(trim($this->f("orden")));
        $this->moneda->SetDBValue($this->f("idMoneda"));
    }
//End SetValues Method

} //End propiedadesDataSource Class @6-FCB6E20C

//Include Page implementation @46-76E73C39
include_once(RelativePath . "/menu1.php");
//End Include Page implementation

//Initialize Page @1-C05AEF02
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
$TemplateFileName = "propiedades_list.html";
$BlockToParse = "main";
$TemplateEncoding = "CP1252";
$ContentType = "text/html";
$PathToRoot = "./";
$Charset = $Charset ? $Charset : "windows-1252";
//End Initialize Page

//Authenticate User @1-ED81712F
CCSecurityRedirect("", "acc_denegado.php");
//End Authenticate User

//Include events file @1-4D310CE3
include_once("./propiedades_list_events.php");
//End Include events file

//Before Initialize @1-E870CEBC
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeInitialize", $MainPage);
//End Before Initialize

//Initialize Objects @1-21C16E50
$DBConnection1 = new clsDBConnection1();
$MainPage->Connections["Connection1"] = & $DBConnection1;
$Attributes = new clsAttributes("page:");
$MainPage->Attributes = & $Attributes;

// Controls
$propiedadesSearch = & new clsRecordpropiedadesSearch("", $MainPage);
$propiedades = & new clsGridpropiedades("", $MainPage);
$menu1 = & new clsmenu1("", "menu1", $MainPage);
$menu1->Initialize();
$MainPage->propiedadesSearch = & $propiedadesSearch;
$MainPage->propiedades = & $propiedades;
$MainPage->menu1 = & $menu1;
$propiedades->Initialize();

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

//Execute Components @1-7D310FD7
$propiedadesSearch->Operation();
$menu1->Operations();
//End Execute Components

//Go to destination page @1-0500AA38
if($Redirect)
{
    $CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
    $DBConnection1->close();
    header("Location: " . $Redirect);
    unset($propiedadesSearch);
    unset($propiedades);
    $menu1->Class_Terminate();
    unset($menu1);
    unset($Tpl);
    exit;
}
//End Go to destination page

//Show Page @1-F2A93199
$propiedadesSearch->Show();
$propiedades->Show();
$menu1->Show();
$Tpl->block_path = "";
$Tpl->Parse($BlockToParse, false);
if (!isset($main_block)) $main_block = $Tpl->GetVar($BlockToParse);
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeOutput", $MainPage);
if ($CCSEventResult) echo $main_block;
//End Show Page

//Unload Page @1-399BB0E4
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
$DBConnection1->close();
unset($propiedadesSearch);
unset($propiedades);
$menu1->Class_Terminate();
unset($menu1);
unset($Tpl);
//End Unload Page


?>
