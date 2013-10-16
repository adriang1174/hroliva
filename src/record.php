<?php
//Include Common Files @1-C90D5747
define("RelativePath", ".");
define("PathToCurrentPage", "/");
define("FileName", "record.php");
include_once(RelativePath . "/Common.php");
include_once(RelativePath . "/Template.php");
include_once(RelativePath . "/Sorter.php");
include_once(RelativePath . "/Navigator.php");
//End Include Common Files

class clsGridpropiedades { //propiedades class @2-9DCFE072

//Variables @2-AC1EDBB9

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
//End Variables

//Class_Initialize Event @2-B08505E3
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
            $this->PageSize = 10;
        else
            $this->PageSize = intval($this->PageSize);
        if ($this->PageSize > 100)
            $this->PageSize = 100;
        if($this->PageSize == 0)
            $this->Errors->addError("<p>Form: Grid " . $this->ComponentName . "<br>Error: (CCS06) Invalid page size.</p>");
        $this->PageNumber = intval(CCGetParam($this->ComponentName . "Page", 1));
        if ($this->PageNumber <= 0) $this->PageNumber = 1;

        $this->RowOpenTag = & new clsPanel("RowOpenTag", $this);
        $this->RowComponents = & new clsPanel("RowComponents", $this);
        $this->zona = & new clsControl(ccsLabel, "zona", "zona", ccsText, "", CCGetRequestParam("zona", ccsGet, NULL), $this);
        $this->dormitorios = & new clsControl(ccsLabel, "dormitorios", "dormitorios", ccsInteger, "", CCGetRequestParam("dormitorios", ccsGet, NULL), $this);
        $this->valor = & new clsControl(ccsLabel, "valor", "valor", ccsText, "", CCGetRequestParam("valor", ccsGet, NULL), $this);
        $this->id = & new clsControl(ccsLabel, "id", "id", ccsText, "", CCGetRequestParam("id", ccsGet, NULL), $this);
        $this->Image1 = & new clsControl(ccsImage, "Image1", "Image1", ccsText, "", CCGetRequestParam("Image1", ccsGet, NULL), $this);
        $this->descripcion = & new clsControl(ccsLabel, "descripcion", "descripcion", ccsText, "", CCGetRequestParam("descripcion", ccsGet, NULL), $this);
        $this->operacion = & new clsControl(ccsLabel, "operacion", "operacion", ccsText, "", CCGetRequestParam("operacion", ccsGet, NULL), $this);
        $this->tipo = & new clsControl(ccsLabel, "tipo", "tipo", ccsText, "", CCGetRequestParam("tipo", ccsGet, NULL), $this);
        $this->idPropiedad = & new clsControl(ccsHidden, "idPropiedad", "idPropiedad", ccsText, "", CCGetRequestParam("idPropiedad", ccsGet, NULL), $this);
        $this->valor_num = & new clsControl(ccsHidden, "valor_num", "valor_num", ccsFloat, "", CCGetRequestParam("valor_num", ccsGet, NULL), $this);
        $this->RowCloseTag = & new clsPanel("RowCloseTag", $this);
        $this->Navigator = & new clsNavigator($this->ComponentName, "Navigator", $FileName, 10, tpCentered, $this);
        $this->Navigator->PageSizes = array("1", "5", "10", "25", "50");
        $this->RowComponents->AddComponent("zona", $this->zona);
        $this->RowComponents->AddComponent("dormitorios", $this->dormitorios);
        $this->RowComponents->AddComponent("valor", $this->valor);
        $this->RowComponents->AddComponent("id", $this->id);
        $this->RowComponents->AddComponent("Image1", $this->Image1);
        $this->RowComponents->AddComponent("descripcion", $this->descripcion);
        $this->RowComponents->AddComponent("operacion", $this->operacion);
        $this->RowComponents->AddComponent("tipo", $this->tipo);
        $this->RowComponents->AddComponent("idPropiedad", $this->idPropiedad);
        $this->RowComponents->AddComponent("valor_num", $this->valor_num);
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

//Show Method @2-657B6622
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
        $this->Attributes->SetValue("numberOfColumns", 1);
        $this->Attributes->Show();

        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeShow", $this);
        if(!$this->Visible) return;

        $GridBlock = "Grid " . $this->ComponentName;
        $ParentPath = $Tpl->block_path;
        $Tpl->block_path = $ParentPath . "/" . $GridBlock;


        if (!$this->IsEmpty) {
            $this->ControlsVisible["RowOpenTag"] = $this->RowOpenTag->Visible;
            $this->ControlsVisible["RowComponents"] = $this->RowComponents->Visible;
            $this->ControlsVisible["zona"] = $this->zona->Visible;
            $this->ControlsVisible["dormitorios"] = $this->dormitorios->Visible;
            $this->ControlsVisible["valor"] = $this->valor->Visible;
            $this->ControlsVisible["id"] = $this->id->Visible;
            $this->ControlsVisible["Image1"] = $this->Image1->Visible;
            $this->ControlsVisible["descripcion"] = $this->descripcion->Visible;
            $this->ControlsVisible["operacion"] = $this->operacion->Visible;
            $this->ControlsVisible["tipo"] = $this->tipo->Visible;
            $this->ControlsVisible["idPropiedad"] = $this->idPropiedad->Visible;
            $this->ControlsVisible["valor_num"] = $this->valor_num->Visible;
            $this->ControlsVisible["RowCloseTag"] = $this->RowCloseTag->Visible;
            while ($this->ForceIteration || (($this->RowNumber < $this->PageSize) &&  ($this->HasRecord = $this->DataSource->has_next_record()))) {
                $this->RowNumber++;
                if ($this->HasRecord) {
                    $this->DataSource->next_record();
                    $this->DataSource->SetValues();
                }
                $Tpl->block_path = $ParentPath . "/" . $GridBlock . "/Row";
                $this->zona->SetValue($this->DataSource->zona->GetValue());
                $this->dormitorios->SetValue($this->DataSource->dormitorios->GetValue());
                $this->valor->SetValue($this->DataSource->valor->GetValue());
                $this->id->SetValue($this->DataSource->id->GetValue());
                $this->descripcion->SetValue($this->DataSource->descripcion->GetValue());
                $this->operacion->SetValue($this->DataSource->operacion->GetValue());
                $this->tipo->SetValue($this->DataSource->tipo->GetValue());
                $this->idPropiedad->SetValue($this->DataSource->idPropiedad->GetValue());
                $this->valor_num->SetValue($this->DataSource->valor_num->GetValue());
                $this->Attributes->SetValue("rowNumber", $this->RowNumber);
                $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeShowRow", $this);
                $this->Attributes->Show();
                $this->RowOpenTag->Show();
                $this->RowComponents->Show();
                $this->RowCloseTag->Show();
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
        $this->Navigator->Show();
        $Tpl->parse();
        $Tpl->block_path = $ParentPath;
        $this->DataSource->close();
    }
//End Show Method

//GetErrors Method @2-D47F4924
    function GetErrors()
    {
        $errors = "";
        $errors = ComposeStrings($errors, $this->zona->Errors->ToString());
        $errors = ComposeStrings($errors, $this->dormitorios->Errors->ToString());
        $errors = ComposeStrings($errors, $this->valor->Errors->ToString());
        $errors = ComposeStrings($errors, $this->id->Errors->ToString());
        $errors = ComposeStrings($errors, $this->Image1->Errors->ToString());
        $errors = ComposeStrings($errors, $this->descripcion->Errors->ToString());
        $errors = ComposeStrings($errors, $this->operacion->Errors->ToString());
        $errors = ComposeStrings($errors, $this->tipo->Errors->ToString());
        $errors = ComposeStrings($errors, $this->idPropiedad->Errors->ToString());
        $errors = ComposeStrings($errors, $this->valor_num->Errors->ToString());
        $errors = ComposeStrings($errors, $this->Errors->ToString());
        $errors = ComposeStrings($errors, $this->DataSource->Errors->ToString());
        return $errors;
    }
//End GetErrors Method

} //End propiedades Class @2-FCB6E20C

class clspropiedadesDataSource extends clsDBConnection1 {  //propiedadesDataSource Class @2-0FC356A5

//DataSource Variables @2-D08B9E92
    var $Parent = "";
    var $CCSEvents = "";
    var $CCSEventResult;
    var $ErrorBlock;
    var $CmdExecution;

    var $CountSQL;
    var $wp;


    // Datasource fields
    var $zona;
    var $dormitorios;
    var $valor;
    var $id;
    var $descripcion;
    var $operacion;
    var $tipo;
    var $idPropiedad;
    var $valor_num;
//End DataSource Variables

//DataSourceClass_Initialize Event @2-11111025
    function clspropiedadesDataSource(& $Parent)
    {
        $this->Parent = & $Parent;
        $this->ErrorBlock = "Grid propiedades";
        $this->Initialize();
        $this->zona = new clsField("zona", ccsText, "");
        
        $this->dormitorios = new clsField("dormitorios", ccsInteger, "");
        
        $this->valor = new clsField("valor", ccsText, "");
        
        $this->id = new clsField("id", ccsText, "");
        
        $this->descripcion = new clsField("descripcion", ccsText, "");
        
        $this->operacion = new clsField("operacion", ccsText, "");
        
        $this->tipo = new clsField("tipo", ccsText, "");
        
        $this->idPropiedad = new clsField("idPropiedad", ccsText, "");
        
        $this->valor_num = new clsField("valor_num", ccsFloat, "");
        

    }
//End DataSourceClass_Initialize Event

//SetOrder Method @2-2BE46D8B
    function SetOrder($SorterName, $SorterDirection)
    {
        $this->Order = "orden";
        $this->Order = CCGetOrder($this->Order, $SorterName, $SorterDirection, 
            "");
    }
//End SetOrder Method

//Prepare Method @2-14D6CD9D
    function Prepare()
    {
        global $CCSLocales;
        global $DefaultDateFormat;
    }
//End Prepare Method

//Open Method @2-1B26D472
    function Open()
    {
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeBuildSelect", $this->Parent);
        $this->CountSQL = "SELECT COUNT(*)\n\n" .
        "FROM (((propiedades INNER JOIN zonas ON\n\n" .
        "propiedades.idZona = zonas.idZona) INNER JOIN operaciones ON\n\n" .
        "propiedades.idOperacion = operaciones.idOperacion) INNER JOIN tipo_propiedad ON\n\n" .
        "propiedades.idTipo = tipo_propiedad.idTipo) INNER JOIN moneda ON\n\n" .
        "propiedades.idMoneda = moneda.idMoneda";
        $this->SQL = "SELECT zonas.descripcion AS zonas_descripcion, operaciones.descripcion AS operaciones_descripcion, tipo_propiedad.descripcion AS tipo_propiedad_descripcion,\n\n" .
        "moneda.descripcion AS moneda_descripcion, idPropiedad, id, propiedades.idZona AS propiedades_idZona, propiedades.idOperacion AS propiedades_idOperacion,\n\n" .
        "propiedades.idTipo AS propiedades_idTipo, propiedades.descripcion AS descripcion, dormitorios, valor AS valor, propiedades.idMoneda AS propiedades_idMoneda,\n\n" .
        "activo, orden, valor_num \n\n" .
        "FROM (((propiedades INNER JOIN zonas ON\n\n" .
        "propiedades.idZona = zonas.idZona) INNER JOIN operaciones ON\n\n" .
        "propiedades.idOperacion = operaciones.idOperacion) INNER JOIN tipo_propiedad ON\n\n" .
        "propiedades.idTipo = tipo_propiedad.idTipo) INNER JOIN moneda ON\n\n" .
        "propiedades.idMoneda = moneda.idMoneda {SQL_Where} {SQL_OrderBy}";
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "BeforeExecuteSelect", $this->Parent);
        if ($this->CountSQL) 
            $this->RecordsCount = CCGetDBValue(CCBuildSQL($this->CountSQL, $this->Where, ""), $this);
        else
            $this->RecordsCount = "CCS not counted";
        $this->query($this->OptimizeSQL(CCBuildSQL($this->SQL, $this->Where, $this->Order)));
        $this->CCSEventResult = CCGetEvent($this->CCSEvents, "AfterExecuteSelect", $this->Parent);
    }
//End Open Method

//SetValues Method @2-C2E4F6ED
    function SetValues()
    {
        $this->zona->SetDBValue($this->f("zonas_descripcion"));
        $this->dormitorios->SetDBValue(trim($this->f("dormitorios")));
        $this->valor->SetDBValue($this->f("valor"));
        $this->id->SetDBValue($this->f("id"));
        $this->descripcion->SetDBValue($this->f("descripcion"));
        $this->operacion->SetDBValue($this->f("operaciones_descripcion"));
        $this->tipo->SetDBValue($this->f("tipo_propiedad_descripcion"));
        $this->idPropiedad->SetDBValue($this->f("idPropiedad"));
        $this->valor_num->SetDBValue(trim($this->f("valor_num")));
    }
//End SetValues Method

} //End propiedadesDataSource Class @2-FCB6E20C

//Initialize Page @1-A0DB26C7
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
$TemplateFileName = "record.html";
$BlockToParse = "main";
$TemplateEncoding = "CP1252";
$ContentType = "text/html";
$PathToRoot = "./";
$Charset = $Charset ? $Charset : "windows-1252";
//End Initialize Page

//Include events file @1-B262AA10
include_once("./record_events.php");
//End Include events file

//Before Initialize @1-E870CEBC
$CCSEventResult = CCGetEvent($CCSEvents, "BeforeInitialize", $MainPage);
//End Before Initialize

//Initialize Objects @1-4A985418
$DBConnection1 = new clsDBConnection1();
$MainPage->Connections["Connection1"] = & $DBConnection1;
$Attributes = new clsAttributes("page:");
$MainPage->Attributes = & $Attributes;

// Controls
$propiedades = & new clsGridpropiedades("", $MainPage);
$MainPage->propiedades = & $propiedades;
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
