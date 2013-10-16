<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="False" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<IncludePage id="2" name="menu1" PathID="menu1" page="menu1.ccp">
			<Components/>
			<Events/>
			<Features/>
		</IncludePage>
		<Record id="3" sourceType="Table" urlType="Relative" secured="False" allowInsert="True" allowUpdate="True" allowDelete="True" validateData="True" preserveParameters="GET" returnValueType="Number" returnValueTypeForDelete="Number" returnValueTypeForInsert="Number" returnValueTypeForUpdate="Number" connection="Connection1" name="propiedades" dataSource="propiedades" errorSummator="Error" wizardCaption="Agregar/Editar Propiedades " wizardFormMethod="post" PathID="propiedades" activeCollection="TableParameters">
			<Components>
				<Button id="4" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Insert" operation="Insert" wizardCaption="Agregar" PathID="propiedadesButton_Insert">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<Button id="5" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Update" operation="Update" wizardCaption="Enviar" PathID="propiedadesButton_Update">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<Button id="6" urlType="Relative" enableValidation="False" isDefault="False" name="Button_Delete" operation="Delete" wizardCaption="Borrar" PathID="propiedadesButton_Delete">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<TextBox id="8" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="id" fieldSource="id" required="True" caption="Id" wizardCaption="Id" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="propiedadesid">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<ListBox id="9" visible="Yes" fieldSourceType="DBColumn" sourceType="Table" dataType="Integer" returnValueType="Number" name="idZona" fieldSource="idZona" required="True" caption="Id Zona" wizardCaption="Id Zona" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardEmptyCaption="Seleccionar Valor" PathID="propiedadesidZona" connection="Connection1" dataSource="zonas" boundColumn="idZona" textColumn="descripcion">
					<Components/>
					<Events/>
					<TableParameters/>
					<SPParameters/>
					<SQLParameters/>
					<JoinTables/>
					<JoinLinks/>
					<Fields/>
					<Attributes/>
					<Features/>
				</ListBox>
				<ListBox id="10" visible="Yes" fieldSourceType="DBColumn" sourceType="Table" dataType="Integer" returnValueType="Number" name="idOperacion" fieldSource="idOperacion" required="True" caption="Id Operacion" wizardCaption="Id Operacion" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardEmptyCaption="Seleccionar Valor" PathID="propiedadesidOperacion" connection="Connection1" dataSource="operaciones" boundColumn="idOperacion" textColumn="descripcion">
					<Components/>
					<Events/>
					<TableParameters/>
					<SPParameters/>
					<SQLParameters/>
					<JoinTables/>
					<JoinLinks/>
					<Fields/>
					<Attributes/>
					<Features/>
				</ListBox>
				<ListBox id="11" visible="Yes" fieldSourceType="DBColumn" sourceType="Table" dataType="Integer" returnValueType="Number" name="idTipo" fieldSource="idTipo" required="True" caption="Id Tipo" wizardCaption="Id Tipo" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardEmptyCaption="Seleccionar Valor" PathID="propiedadesidTipo" connection="Connection1" dataSource="tipo_propiedad" boundColumn="idTipo" textColumn="descripcion">
					<Components/>
					<Events/>
					<TableParameters/>
					<SPParameters/>
					<SQLParameters/>
					<JoinTables/>
					<JoinLinks/>
					<Fields/>
					<Attributes/>
					<Features/>
				</ListBox>
				<TextArea id="12" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="descripcion" fieldSource="descripcion" required="True" caption="Descripcion" wizardCaption="Descripcion" wizardSize="50" wizardMaxLength="250" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardRows="3" PathID="propiedadesdescripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextArea>
				<TextBox id="13" visible="Yes" fieldSourceType="DBColumn" dataType="Integer" name="dormitorios" fieldSource="dormitorios" required="False" caption="Dormitorios" wizardCaption="Dormitorios" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="propiedadesdormitorios">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<TextBox id="14" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="valor" fieldSource="valor" required="False" caption="Valor" wizardCaption="Valor" wizardSize="50" wizardMaxLength="50" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="propiedadesvalor">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<TextBox id="15" visible="Yes" fieldSourceType="DBColumn" dataType="Float" name="valor_num" fieldSource="valor_num" required="False" caption="Valor Num" wizardCaption="Valor Num" wizardSize="12" wizardMaxLength="12" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="propiedadesvalor_num">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<ListBox id="16" visible="Yes" fieldSourceType="DBColumn" sourceType="Table" dataType="Integer" returnValueType="Number" name="idMoneda" fieldSource="idMoneda" required="False" caption="Id Moneda" wizardCaption="Id Moneda" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardEmptyCaption="Seleccionar Valor" PathID="propiedadesidMoneda" connection="Connection1" dataSource="moneda" boundColumn="idMoneda" textColumn="descripcion">
					<Components/>
					<Events/>
					<TableParameters/>
					<SPParameters/>
					<SQLParameters/>
					<JoinTables/>
					<JoinLinks/>
					<Fields/>
					<Attributes/>
					<Features/>
				</ListBox>
				<CheckBox id="17" visible="Yes" fieldSourceType="DBColumn" dataType="Integer" name="activo" fieldSource="activo" required="True" caption="Activo" wizardCaption="Activo" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" checkedValue="1" uncheckedValue="0" PathID="propiedadesactivo">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</CheckBox>
				<TextBox id="18" visible="Yes" fieldSourceType="DBColumn" dataType="Integer" name="orden" fieldSource="orden" required="False" caption="Orden" wizardCaption="Orden" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="propiedadesorden">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
			</Components>
			<Events/>
			<TableParameters>
				<TableParameter id="7" conditionType="Parameter" useIsNull="False" field="idPropiedad" dataType="Integer" logicOperator="And" searchConditionType="Equal" parameterType="URL" orderNumber="1" parameterSource="id"/>
			</TableParameters>
			<SPParameters/>
			<SQLParameters/>
			<JoinTables>
				<JoinTable id="19" tableName="propiedades" posLeft="10" posTop="10" posWidth="115" posHeight="180"/>
			</JoinTables>
			<JoinLinks/>
			<Fields/>
			<ISPParameters/>
			<ISQLParameters/>
			<IFormElements/>
			<USPParameters/>
			<USQLParameters/>
			<UConditions/>
			<UFormElements/>
			<DSPParameters/>
			<DSQLParameters/>
			<DConditions/>
			<SecurityGroups/>
			<Attributes/>
			<Features/>
		</Record>
	</Components>
	<CodeFiles>
		<CodeFile id="Code" language="ASPTemplates" name="propiedades_maint.asp" forShow="True" url="propiedades_maint.asp" comment="'" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="propiedades_maint.php" forShow="True" url="propiedades_maint.php" comment="//" codePage="windows-1252"/>
</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
