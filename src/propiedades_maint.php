<?php
//Include Common Files @1-50F6BA3D
define("RelativePath", ".");
define("PathToCurrentPage", "/");
define("FileName", "propiedades_maint.php");
include_once(RelativePath . "/Common.php");
include_once(RelativePath . "/Template.php");
include_once(RelativePath . "/Sorter.php");
include_once(RelativePath . "/Navigator.php");
//End Include Common Files

//Include Page implementation @2-76E73C39
include_once(RelativePath . "/menu1.php");
//End Include Page implementation

class clsRecordpropiedades { //propiedades Class @3-915B4767

//Variables @3-D6FF3E86

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

//Class_Initialize Event @3-ACB8B978
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
        $this->DataSource = new clspropiedadesDataSource($this);
        $this->ds = & $this->DataSource;
        $this->InsertAllowed = true;
        $this->UpdateAllowed = true;
        $this->DeleteAllowed = true;
        $this->ReadAllowed = true;
        if($this->Visible)
        {
            $this->ComponentName = "propiedades";
            $this->Attributes = new clsAttributes($this->ComponentName . ":");
            $CCSForm = split(":", CCGetFromGet("ccsForm", ""), 2);
            if(sizeof($CCSForm) == 1)
                $CCSForm[1] = "";
            list($FormName, $FormMethod) = $CCSForm;
            $this->EditMode = ($FormMethod == "Edit");
            $this->FormEnctype = "application/x-www-form-urlencoded";
            $this->FormSubmitted = ($FormName == $this->ComponentName);
            $Method = $this->FormSubmitted ? ccsPost : ccsGet;
            $this->Button_Insert = & new clsButton("Button_Insert", $Method, $this);
            $this->Button_Update = & new clsButton("Button_Update", $Method, $this);
            $this->Button_Delete = & new clsButton("Button_Delete", $Method, $this);
            $this->id = & new clsControl(ccsTextBox, "id", "Id", ccsText, "", CCGetRequestParam("id", $Method, NULL), $this);
            $this->id->Required = true;
            $this->idZona = & new clsControl(ccsListBox, "idZona", "Id Zona", ccsInteger, "", CCGetRequestParam("idZona", $Method, NULL), $this);
            $this->idZona->DSType = dsTable;
            $this->idZona->DataSource = new clsDBConnection1();
            $this->idZona->ds = & $this->idZona->DataSource;
            $this->idZona->DataSource->SQL = "SELECT * \n" .
"FROM zonas {SQL_Where} {SQL_OrderBy}";
            list($this->idZona->BoundColumn, $this->idZona->TextColumn, $this->idZona->DBFormat) = array("idZona", "descripcion", "");
            $this->idZona->Required = true;
            $this->idOperacion = & new clsControl(ccsListBox, "idOperacion", "Id Operacion", ccsInteger, "", CCGetRequestParam("idOperacion", $Method, NULL), $this);
            $this->idOperacion->DSType = dsTable;
            $this->idOperacion->DataSource = new clsDBConnection1();
            $this->idOperacion->ds = & $this->idOperacion->DataSource;
            $this->idOperacion->DataSource->SQL = "SELECT * \n" .
"FROM operaciones {SQL_Where} {SQL_OrderBy}";
            list($this->idOperacion->BoundColumn, $this->idOperacion->TextColumn, $this->idOperacion->DBFormat) = array("idOperacion", "descripcion", "");
            $this->idOperacion->Required = true;
            $this->idTipo = & new clsControl(ccsListBox, "idTipo", "Id Tipo", ccsInteger, "", CCGetRequestParam("idTipo", $Method, NULL), $this);
            $this->idTipo->DSType = dsTable;
            $this->idTipo->DataSource = new clsDBConnection1();
            $this->idTipo->ds = & $this->idTipo->DataSource;
            $this->idTipo->DataSource->SQL = "SELECT * \n" .
"FROM tipo_propiedad {SQL_Where} {SQL_OrderBy}";
            list($this->idTipo->BoundColumn, $this->idTipo->TextColumn, $this->idTipo->DBFormat) = array("idTipo", "descripcion", "");
            $this->idTipo->Required = true;
            $this->descripcion = & new clsControl(ccsTextArea, "descripcion", "Descripcion", ccsText, "", CCGetRequestParam("descripcion", $Method, NULL), $this);
            $this->descripcion->Required = true;
            $this->dormitorios = & new clsControl(ccsTextBox, "dormitorios", "Dormitorios", ccsInteger, "", CCGetRequestParam("dormitorios", $Method, NULL), $this);
            $this->valor = & new clsControl(ccsTextBox, "valor", "Valor", ccsText, "", CCGetRequestParam("valor", $Method, NULL), $this);
            $this->valor_num = & new clsControl(ccsTextBox, "valor_num", "Valor Num", ccsFloat, "", CCGetRequestParam("valor_num", $Method, NULL), $this);
            $this->idMoneda = & new clsControl(ccsListBox, "idMoneda", "Id Moneda", ccsInteger, "", CCGetRequestParam("idMoneda", $Method, NULL), $this);
            $this->idMoneda->DSType = dsTable;
            $this->idMoneda->DataSource = new clsDBConnection1();
            $this->idMoneda->ds = & $this->idMoneda->DataSource;
            $this->idMoneda->DataSource->SQL = "SELECT * \n" .
"FROM moneda {SQL_Where} {SQL_OrderBy}";
            list($this->idMoneda->BoundColumn, $this->idMoneda->TextColumn, $this->idMoneda->DBFormat) = array("idMoneda", "descripcion", "");
            $this->activo = & new clsControl(ccsCheckBox, "activo", "Activo", ccsInteger, "", CCGetRequestParam("activo", $Method, NULL), $this);
            $this->activo->CheckedValue = $this->activo->GetParsedValue(1);
            $this->activo->UncheckedValue = $this->activo->GetParsedValue(0);
            $this->orden = & new clsControl(ccsTextBox, "orden", "Orden", ccsInteger, "", CCGetRequestParam("orden", $Method, NULL), $this);
        }
    }
//End Class_Initialize Event

//Initialize Method @3-2832F4DC
    function Initialize()
    {

        if(!$this->Visible)
            return;

        $this->DataSource->Parameters["urlid"] = CCGetFromGet("id", NULL);
    }
//End Initialize Method

//Validate Method @3-EC05C9FC
    function Validate()
    {
        global $CCSLocales;
        $Validation = true;
        $Where = "";
        $Validation = ($this->id->Validate() && $Validation);
        $Validation = ($this->idZona->Validate() && $Validation);
        $Validation = ($this->idOperacion->Validate() && $Validation);
        $Validation = ($this->idTipo->Validate() && $Validation);
        $Validation = ($this->descripcion->Validate() && $Validation);
        $Validation = ($this->dormitorios->Validate() && $Validation);
        $Validation = ($this->valor->Validate() && $Validation);
        $Validation = ($this->valor_num->Validate() && $Validation);
        $Validation = ($this->idMoneda->Validate() && $Validation);
        $Validation = ($this->activo->Validate() && $Validation);
        $Validation = ($this->orden->Validate() && $Validation);
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "OnValidate", $this);
        $Validation =  $Validation && ($this->id->Errors->Count() == 0);
        $Validation =  $Validation && ($this->idZona->Errors->Count() == 0);
        $Validation =  $Validation && ($this->idOperacion->Errors->Count() == 0);
        $Validation =  $Validation && ($this->idTipo->Errors->Count() == 0);
        $Validation =  $Validation && ($this->descripcion->Errors->Count() == 0);
        $Validation =  $Validation && ($this->dormitorios->Errors->Count() == 0);
        $Validation =  $Validation && ($this->valor->Errors->Count() == 0);
        $Validation =  $Validation && ($this->valor_num->Errors->Count() == 0);
        $Validation =  $Validation && ($this->idMoneda->Errors->Count() == 0);
        $Validation =  $Validation && ($this->activo->Errors->Count() == 0);
        $Validation =  $Validation && ($this->orden->Errors->Count() == 0);
        return (($this->Errors->Count() == 0) && $Validation);
    }
//End Validate Method

//CheckErrors Method @3-AB23EE42
    function CheckErrors()
    {
        $errors = false;
        $errors = ($errors || $this->id->Errors->Count());
        $errors = ($errors || $this->idZona->Errors->Count());
        $errors = ($errors || $this->idOperacion->Errors->Count());
        $errors = ($errors || $this->idTipo->Errors->Count());
        $errors = ($errors || $this->descripcion->Errors->Count());
        $errors = ($errors || $this->dormitorios->Errors->Count());
        $errors = ($errors || $this->valor->Errors->Count());
        $errors = ($errors || $this->valor_num->Errors->Count());
        $errors = ($errors || $this->idMoneda->Errors->Count());
        $errors = ($errors || $this->activo->Errors->Count());
        $errors = ($errors || $this->orden->Errors->Count());
        $errors = ($errors || $this->Errors->Count());
        $errors = ($errors || $this->DataSource->Errors->Count());
        return $errors;
    }
//End CheckErrors Method

//MasterDetail @3-ED598703
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

//Operation Method @3-B908BA44
    function Operation()
    {
        if(!$this->Visible)
            return;

        global $Redirect;
        global $FileName;

        $this->DataSource->Prepare();
        if(!$this->FormSubmitted) {
            $this->EditMode = $this->DataSource->AllParametersSet;
            return;
        }

        if($this->FormSubmitted) {
            $this->PressedButton = $this->EditMode ? "Button_Update" : "Button_Insert";
            if($this->Button_Insert->Pressed) {
                $this->PressedButton = "Button_Insert";
            } else if($this->Button_Update->Pressed) {
                $this->PressedButton = "Button_Update";
            } else if($this->Button_Delete->Pressed) {
                $this->PressedButton = "Button_Delete";
            }
        }
        $Redirect = $FileName . "?" . CCGetQueryString("QueryString", array("ccsForm"));
        if($this->PressedButton == "Button_Delete") {
            if(!CCGetEvent($this->Button_Delete->CCSEvents, "OnClick", $this->Button_Delete) || !$this->DeleteRow()) {
                $Redirect = "";
            }
        } else if($this->Validate()) {
            if($this->PressedButton == "Button_Insert") {
                if(!CCGetEvent($this->Button_Insert->CCSEvents, "OnClick", $this->Button_Insert) || !$this->InsertRow()) {
                    $Redirect = "";
                }
            } else if($this->PressedButton == "Button_Update") {
                if(!CCGetEvent($this->Button_Update->CCSEvents, "OnClick", $this->Button_Update) || !$this->UpdateRow()) {
                    $Redirect = "";
                }
            }
        } else {
            $Redirect = "";
        }
        if ($Redirect)
            $this->DataSource->close();
    }
//End Operation Method

//InsertRow Method @3-6A901388
    function InsertRow()
    {
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeInsert", $this);
        if(!$this->InsertAllowed) return false;
        $this->DataSource->id->SetValue($this->id->GetValue(true));
        $this->DataSource->idZona->SetValue($this->idZona->GetValue(true));
        $this->DataSource->idOperacion->SetValue($this->idOperacion->GetValue(true));
        $this->DataSource->idTipo->SetValue($this->idTipo->GetValue(true));
        $this->DataSource->descripcion->SetValue($this->descripcion->GetValue(true));
        $this->DataSource->dormitorios->SetValue($this->dormitorios->GetValue(true));
        $this->DataSource->valor->SetValue($this->valor->GetValue(true));
        $this->DataSource->valor_num->SetValue($this->valor_num->GetValue(true));
        $this->DataSource->idMoneda->SetValue($this->idMoneda->GetValue(true));
        $this->DataSource->activo->SetValue($this->activo->GetValue(true));
        $this->DataSource->orden->SetValue($this->orden->GetValue(true));
        $this->DataSource->Insert();
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterInsert", $this);
        return (!$this->CheckErrors());
    }
//End InsertRow Method

//UpdateRow Method @3-73F8DB01
    function UpdateRow()
    {
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeUpdate", $this);
        if(!$this->UpdateAllowed) return false;
        $this->DataSource->id->SetValue($this->id->GetValue(true));
        $this->DataSource->idZona->SetValue($this->idZona->GetValue(true));
        $this->DataSource->idOperacion->SetValue($this->idOperacion->GetValue(true));
        $this->DataSource->idTipo->SetValue($this->idTipo->GetValue(true));
        $this->DataSource->descripcion->SetValue($this->descripcion->GetValue(true));
        $this->DataSource->dormitorios->SetValue($this->dormitorios->GetValue(true));
        $this->DataSource->valor->SetValue($this->valor->GetValue(true));
        $this->DataSource->valor_num->SetValue($this->valor_num->GetValue(true));
        $this->DataSource->idMoneda->SetValue($this->idMoneda->GetValue(true));
        $this->DataSource->activo->SetValue($this->activo->GetValue(true));
        $this->DataSource->orden->SetValue($this->orden->GetValue(true));
        $this->DataSource->Update();
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterUpdate", $this);
        return (!$this->CheckErrors());
    }
//End UpdateRow Method

//DeleteRow Method @3-299D98C3
    function DeleteRow()
    {
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeDelete", $this);
        if(!$this->DeleteAllowed) return false;
        $this->DataSource->Delete();
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterDelete", $this);
        return (!$this->CheckErrors());
    }
//End DeleteRow Method

//Show Method @3-ACE1F14E
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

        $this->idZona->Prepare();
        $this->idOperacion->Prepare();
        $this->idTipo->Prepare();
        $this->idMoneda->Prepare();

        $RecordBlock = "Record " . $this->ComponentName;
        $ParentPath = $Tpl->block_path;
        $Tpl->block_path = $ParentPath . "/" . $RecordBlock;
        $this->EditMode = $this->EditMode && $this->ReadAllowed;
        if($this->EditMode) {
            if($this->DataSource->Errors->Count()){
                $this->Errors->AddErrors($this->DataSource->Errors);
                $this->DataSource->Errors->clear();
            }
            $this->DataSource->Open();
            if($this->DataSource->Errors->Count() == 0 && $this->DataSource->next_record()) {
                $this->DataSource->SetValues();
                if(!$this->FormSubmitted){
                    $this->id->SetValue($this->DataSource->id->GetValue());
                    $this->idZona->SetValue($this->DataSource->idZona->GetValue());
                    $this->idOperacion->SetValue($this->DataSource->idOperacion->GetValue());
                    $this->idTipo->SetValue($this->DataSource->idTipo->GetValue());
                    $this->descripcion->SetValue($this->DataSource->descripcion->GetValue());
                    $this->dormitorios->SetValue($this->DataSource->dormitorios->GetValue());
                    $this->valor->SetValue($this->DataSource->valor->GetValue());
                    $this->valor_num->SetValue($this->DataSource->valor_num->GetValue());
                    $this->idMoneda->SetValue($this->DataSource->idMoneda->GetValue());
                    $this->activo->SetValue($this->DataSource->activo->GetValue());
                    $this->orden->SetValue($this->DataSource->orden->GetValue());
                }
            } else {
                $this->EditMode = false;
            }
        }

        if($this->FormSubmitted || $this->CheckErrors()) {
            $Error = "";
            $Error = ComposeStrings($Error, $this->id->Errors->ToString());
            $Error = ComposeStrings($Error, $this->idZona->Errors->ToString());
            $Error = ComposeStrings($Error, $this->idOperacion->Errors->ToString());
            $Error = ComposeStrings($Error, $this->idTipo->Errors->ToString());
            $Error = ComposeStrings($Error, $this->descripcion->Errors->ToString());
            $Error = ComposeStrings($Error, $this->dormitorios->Errors->ToString());
            $Error = ComposeStrings($Error, $this->valor->Errors->ToString());
            $Error = ComposeStrings($Error, $this->valor_num->Errors->ToString());
            $Error = ComposeStrings($Error, $this->idMoneda->Errors->ToString());
            $Error = ComposeStrings($Error, $this->activo->Errors->ToString());
            $Error = ComposeStrings($Error, $this->orden->Errors->ToString());
            $Error = ComposeStrings($Error, $this->Errors->ToString());
            $Error = ComposeStrings($Error, $this->DataSource->Errors->ToString());
            $Tpl->SetVar("Error", $Error);
            $Tpl->Parse("Error", false);
        }
        $CCSForm = $this->EditMode ? $this->ComponentName . ":" . "Edit" : $this->ComponentName;
        $this->HTMLFormAction = $FileName . "?" . CCAddParam(CCGetQueryString("QueryString", ""), "ccsForm", $CCSForm);
        $Tpl->SetVar("Action", !$CCSUseAmp ? $this->HTMLFormAction : str_replace("&", "&amp;", $this->HTMLFormAction));
        $Tpl->SetVar("HTMLFormName", $this->ComponentName);
        $Tpl->SetVar("HTMLFormEnctype", $this->FormEnctype);
        $this->Button_Insert->Visible = !$this->EditMode && $this->InsertAllowed;
        $this->Button_Update->Visible = $this->EditMode && $this->UpdateAllowed;
        $this->Button_Delete->Visible = $this->EditMode && $this->DeleteAllowed;

        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeShow", $this);
        $this->Attributes->Show();
        if(!$this->Visible) {
            $Tpl->block_path = $ParentPath;
            return;
        }

        $this->Button_Insert->Show();
        $this->Button_Update->Show();
        $this->Button_Delete->Show();
        $this->id->Show();
        $this->idZona->Show();
        $this->idOperacion->Show();
        $this->idTipo->Show();
        $this->descripcion->Show();
        $this->dormitorios->Show();
        $this->valor->Show();
        $this->valor_num->Show();
        $this->idMoneda->Show();
        $this->activo->Show();
        $this->orden->Show();
        $Tpl->parse();
        $Tpl->block_path = $ParentPath;
        $this->DataSource->close();
    }
//End Show Method

} //End propiedades Class @3-FCB6E20C

class clspropiedadesDataSource extends clsDBConnection1 {  //propiedadesDataSource Class @3-0FC356A5

//DataSource Variables @3-62E7E235
    var $Parent = "";
    var $CCSEvents = "";
    var $CCSEventResult;
    var $ErrorBlock;
    var $CmdExecution;

    var $InsertParameters;
    var $UpdateParameters;
    var $DeleteParameters;
    var $wp;
    var $AllParametersSet;

    var $InsertFields = array();
    var $UpdateFields = array();

    // Datasource fields
    var $id;
    var $idZona;
    var $idOperacion;
    var $idTipo;
    var $descripcion;
    var $dormitorios;
    var $valor;
    var $valor_num;
    var $idMoneda;
    var $activo;
    var $orden;
//End DataSource Variables

//DataSourceClass_Initialize Event @3-CAE5DA1B
    function clspropiedadesDataSource(& $Parent)
    {
        $this->Parent = & $Parent;
        $this->ErrorBlock = "Record propiedades/Error";
        $this->Initialize();
        $this->id = new clsField("id", ccsText, "");
        
        $this->idZona = new clsField("idZona", ccsInteger, "");
        
        $this->idOperacion = new clsField("idOperacion", ccsInteger, "");
        
        $this->idTipo = new clsField("idTipo", ccsInteger, "");
        
        $this->descripcion = new clsField("descripcion", ccsText, "");
        
        $this->dormitorios = new clsField("dormitorios", ccsInteger, "");
        
        $this->valor = new clsField("valor", ccsText, "");
        
        $this->valor_num = new clsField("valor_num", ccsFloat, "");
        
        $this->idMoneda = new clsField("idMoneda", ccsInteger, "");
        
        $this->activo = new clsField("activo", ccsInteger, "");
        
        $this->orden = new clsField("orden", ccsInteger, "");
        

        $this->InsertFields["id"] = array("Name" => "id", "Value" => "", "DataType" => ccsText, "OmitIfEmpty" => 1);
        $this->InsertFields["idZona"] = array("Name" => "idZona", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->InsertFields["idOperacion"] = array("Name" => "idOperacion", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->InsertFields["idTipo"] = array("Name" => "idTipo", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->InsertFields["descripcion"] = array("Name" => "descripcion", "Value" => "", "DataType" => ccsText, "OmitIfEmpty" => 1);
        $this->InsertFields["dormitorios"] = array("Name" => "dormitorios", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->InsertFields["valor"] = array("Name" => "valor", "Value" => "", "DataType" => ccsText, "OmitIfEmpty" => 1);
        $this->InsertFields["valor_num"] = array("Name" => "valor_num", "Value" => "", "DataType" => ccsFloat, "OmitIfEmpty" => 1);
        $this->InsertFields["idMoneda"] = array("Name" => "idMoneda", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->InsertFields["activo"] = array("Name" => "activo", "Value" => "", "DataType" => ccsInteger);
        $this->InsertFields["orden"] = array("Name" => "orden", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->UpdateFields["id"] = array("Name" => "id", "Value" => "", "DataType" => ccsText, "OmitIfEmpty" => 1);
        $this->UpdateFields["idZona"] = array("Name" => "idZona", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->UpdateFields["idOperacion"] = array("Name" => "idOperacion", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->UpdateFields["idTipo"] = array("Name" => "idTipo", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->UpdateFields["descripcion"] = array("Name" => "descripcion", "Value" => "", "DataType" => ccsText, "OmitIfEmpty" => 1);
        $this->UpdateFields["dormitorios"] = array("Name" => "dormitorios", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->UpdateFields["valor"] = array("Name" => "valor", "Value" => "", "DataType" => ccsText, "OmitIfEmpty" => 1);
        $this->UpdateFields["valor_num"] = array("Name" => "valor_num", "Value" => "", "DataType" => ccsFloat, "OmitIfEmpty" => 1);
        $this->UpdateFields["idMoneda"] = array("Name" => "idMoneda", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
        $this->UpdateFields["activo"] = array("Name" => "activo", "Value" => "", "DataType" => ccsInteger);
        $this->UpdateFields["orden"] = array("Name" => "orden", "Value" => "", "DataType" => ccsInteger, "OmitIfEmpty" => 1);
    }
//End DataSourceClass_Initialize Event

//Prepare Method @3-2F4F8EC7
    function Prepare()
    {
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->wp = new clsSQLParameters($this->ErrorBlock);
        $this->wp->AddParameter("1", "urlid", ccsInteger, "", "", $this->Parameters["urlid"], "", false);
        $this->AllParametersSet = $this->wp->AllParamsSet();
        $this->wp->Criterion[1] = $this->wp->Operation(opEqual, "idPropiedad", $this->wp->GetDBValue("1"), $this->ToSQL($this->wp->GetDBValue("1"), ccsInteger),false);
        $this->Where = 
             $this->wp->Criterion[1];
    }
//End Prepare Method

//Open Method @3-C2D42ACC
    function Open()
    {
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeBuildSelect", $this->Parent);
        $this->SQL = "SELECT * \n\n" .
        "FROM propiedades {SQL_Where} {SQL_OrderBy}";
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeExecuteSelect", $this->Parent);
        $this->PageSize = 1;
        $this->query($this->OptimizeSQL(CCBuildSQL($this->SQL, $this->Where, $this->Order)));
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterExecuteSelect", $this->Parent);
    }
//End Open Method

//SetValues Method @3-85E8E48C
    function SetValues()
    {
        $this->id->SetDBValue($this->f("id"));
        $this->idZona->SetDBValue(trim($this->f("idZona")));
        $this->idOperacion->SetDBValue(trim($this->f("idOperacion")));
        $this->idTipo->SetDBValue(trim($this->f("idTipo")));
        $this->descripcion->SetDBValue($this->f("descripcion"));
        $this->dormitorios->SetDBValue(trim($this->f("dormitorios")));
        $this->valor->SetDBValue($this->f("valor"));
        $this->valor_num->SetDBValue(trim($this->f("valor_num")));
        $this->idMoneda->SetDBValue(trim($this->f("idMoneda")));
        $this->activo->SetDBValue(trim($this->f("activo")));
        $this->orden->SetDBValue(trim($this->f("orden")));
    }
//End SetValues Method

//Insert Method @3-917A0F29
    function Insert()
    {
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->CmdExecution = true;
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeBuildInsert", $this->Parent);
        $this->InsertFields["id"]["Value"] = $this->id->GetDBValue(true);
        $this->InsertFields["idZona"]["Value"] = $this->idZona->GetDBValue(true);
        $this->InsertFields["idOperacion"]["Value"] = $this->idOperacion->GetDBValue(true);
        $this->InsertFields["idTipo"]["Value"] = $this->idTipo->GetDBValue(true);
        $this->InsertFields["descripcion"]["Value"] = $this->descripcion->GetDBValue(true);
        $this->InsertFields["dormitorios"]["Value"] = $this->dormitorios->GetDBValue(true);
        $this->InsertFields["valor"]["Value"] = $this->valor->GetDBValue(true);
        $this->InsertFields["valor_num"]["Value"] = $this->valor_num->GetDBValue(true);
        $this->InsertFields["idMoneda"]["Value"] = $this->idMoneda->GetDBValue(true);
        $this->InsertFields["activo"]["Value"] = $this->activo->GetDBValue(true);
        $this->InsertFields["orden"]["Value"] = $this->orden->GetDBValue(true);
        $this->SQL = CCBuildInsert("propiedades", $this->InsertFields, $this);
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeExecuteInsert", $this->Parent);
        if($this->Errors->Count() == 0 && $this->CmdExecution) {
            $this->query($this->SQL);
            $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterExecuteInsert", $this->Parent);
        }
    }
//End Insert Method

//Update Method @3-91FF2BB7
    function Update()
    {
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->CmdExecution = true;
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeBuildUpdate", $this->Parent);
        $this->UpdateFields["id"]["Value"] = $this->id->GetDBValue(true);
        $this->UpdateFields["idZona"]["Value"] = $this->idZona->GetDBValue(true);
        $this->UpdateFields["idOperacion"]["Value"] = $this->idOperacion->GetDBValue(true);
        $this->UpdateFields["idTipo"]["Value"] = $this->idTipo->GetDBValue(true);
        $this->UpdateFields["descripcion"]["Value"] = $this->descripcion->GetDBValue(true);
        $this->UpdateFields["dormitorios"]["Value"] = $this->dormitorios->GetDBValue(true);
        $this->UpdateFields["valor"]["Value"] = $this->valor->GetDBValue(true);
        $this->UpdateFields["valor_num"]["Value"] = $this->valor_num->GetDBValue(true);
        $this->UpdateFields["idMoneda"]["Value"] = $this->idMoneda->GetDBValue(true);
        $this->UpdateFields["activo"]["Value"] = $this->activo->GetDBValue(true);
        $this->UpdateFields["orden"]["Value"] = $this->orden->GetDBValue(true);
        $this->SQL = CCBuildUpdate("propiedades", $this->UpdateFields, $this);
        $this->SQL .= strlen($this->Where) ? " WHERE " . $this->Where : $this->Where;
        if (!strlen($this->Where) && $this->Errors->Count() == 0) 
            $this->Errors->addError($CCSLocales->GetText("CCS_CustomOperationError_MissingParameters"));
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeExecuteUpdate", $this->Parent);
        if($this->Errors->Count() == 0 && $this->CmdExecution) {
            $this->query($this->SQL);
            $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterExecuteUpdate", $this->Parent);
        }
    }
//End Update Method

//Delete Method @3-F11094F1
    function Delete()
    {
        global $CCSLocales;
        global $DefaultDateFormat;
        $this->CmdExecution = true;
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeBuildDelete", $this->Parent);
        $this->SQL = "DELETE FROM propiedades";
        $this->SQL = CCBuildSQL($this->SQL, $this->Where, "");
        if (!strlen($this->Where) && $this->Errors->Count() == 0) 
            $this->Errors->addError($CCSLocales->GetText("CCS_CustomOperationError_MissingParameters"));
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeExecuteDelete", $this->Parent);
        if($this->Errors->Count() == 0 && $this->CmdExecution) {
            $this->query($this->SQL);
            $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterExecuteDelete", $this->Parent);
        }
    }
//End Delete Method

} //End propiedadesDataSource Class @3-FCB6E20C

//Initialize Page @1-DBBAC571
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
$TemplateFileName = "propiedades_maint.html";
$BlockToParse = "main";
$TemplateEncoding = "CP1252";
$ContentType = "text/html";
$PathToRoot = "./";
$Charset = $Charset ? $Charset : "windows-1252";
//End Initialize Page

//Before Initialize @1-E870CEBC
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeInitialize", $MainPage);
//End Before Initialize

//Initialize Objects @1-0D63F38A
$DBConnection1 = new clsDBConnection1();
$MainPage->Connections["Connection1"] = & $DBConnection1;
$Attributes = new clsAttributes("page:");
$MainPage->Attributes = & $Attributes;

// Controls
$menu1 = & new clsmenu1("", "menu1", $MainPage);
$menu1->Initialize();
$propiedades = & new clsRecordpropiedades("", $MainPage);
$MainPage->menu1 = & $menu1;
$MainPage->propiedades = & $propiedades;
$propiedades->Initialize();

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

//Execute Components @1-92A6CF51
$menu1->Operations();
$propiedades->Operation();
//End Execute Components

//Go to destination page @1-EFAD1D14
if($Redirect)
{
    $CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
    $DBConnection1->close();
    header("Location: " . $Redirect);
    $menu1->Class_Terminate();
    unset($menu1);
    unset($propiedades);
    unset($Tpl);
    exit;
}
//End Go to destination page

//Show Page @1-6751AAD6
$menu1->Show();
$propiedades->Show();
$Tpl->block_path = "";
$Tpl->Parse($BlockToParse, false);
if (!isset($main_block)) $main_block = $Tpl->GetVar($BlockToParse);
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeOutput", $MainPage);
if ($CCSEventResult) echo $main_block;
//End Show Page

//Unload Page @1-60EEB0AC
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeUnload", $MainPage);
$DBConnection1->close();
$menu1->Class_Terminate();
unset($menu1);
unset($propiedades);
unset($Tpl);
//End Unload Page


?>
