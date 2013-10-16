<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="True" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<Record id="2" sourceType="Table" urlType="Relative" secured="False" allowInsert="True" allowUpdate="True" allowDelete="True" validateData="True" preserveParameters="GET" returnValueType="Number" returnValueTypeForDelete="Number" returnValueTypeForInsert="Number" returnValueTypeForUpdate="Number" connection="Connection1" name="tipo_propiedad" dataSource="tipo_propiedad" errorSummator="Error" wizardCaption="Agregar/Editar Tipo Propiedad " wizardFormMethod="post" returnPage="tipo_propiedad_list.ccp" PathID="tipo_propiedad">
			<Components>
				<Button id="3" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Insert" operation="Insert" wizardCaption="Agregar" PathID="tipo_propiedadButton_Insert">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<Button id="4" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Update" operation="Update" wizardCaption="Enviar" PathID="tipo_propiedadButton_Update">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<Button id="5" urlType="Relative" enableValidation="False" isDefault="False" name="Button_Delete" operation="Delete" wizardCaption="Borrar" PathID="tipo_propiedadButton_Delete">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<TextBox id="7" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="descripcion" fieldSource="descripcion" required="True" caption="Descripcion" wizardCaption="Descripcion" wizardSize="30" wizardMaxLength="30" wizardIsPassword="False" PathID="tipo_propiedaddescripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
			</Components>
			<Events/>
			<TableParameters>
				<TableParameter id="6" conditionType="Parameter" useIsNull="False" field="idTipo" parameterSource="idTipo" dataType="Integer" logicOperator="And" searchConditionType="Equal" parameterType="URL" orderNumber="1"/>
			</TableParameters>
			<SPParameters/>
			<SQLParameters/>
			<JoinTables/>
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
		<IncludePage id="9" name="menu1" PathID="menu1" page="menu1.ccp">
<Components/>
<Events/>
<Features/>
</IncludePage>
</Components>
	<CodeFiles>
		<CodeFile id="Code" language="PHPTemplates" name="tipo_propiedad_maint.php" forShow="True" url="tipo_propiedad_maint.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="tipo_propiedad_maint.asp" forShow="True" url="tipo_propiedad_maint.asp" comment="'" codePage="windows-1252"/>
	</CodeFiles>
	<SecurityGroups>
		<Group id="8" groupID="100"/>
	</SecurityGroups>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
