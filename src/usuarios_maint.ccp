<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="True" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<Record id="2" sourceType="Table" urlType="Relative" secured="False" allowInsert="True" allowUpdate="True" allowDelete="True" validateData="True" preserveParameters="GET" returnValueType="Number" returnValueTypeForDelete="Number" returnValueTypeForInsert="Number" returnValueTypeForUpdate="Number" connection="Connection1" name="usuarios" dataSource="usuarios" errorSummator="Error" wizardCaption="Agregar/Editar Usuarios " wizardFormMethod="post" returnPage="usuarios_list.ccp" PathID="usuarios">
			<Components>
				<Button id="3" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Insert" operation="Insert" wizardCaption="Agregar" PathID="usuariosButton_Insert">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<Button id="4" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Update" operation="Update" wizardCaption="Enviar" PathID="usuariosButton_Update">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<Button id="5" urlType="Relative" enableValidation="False" isDefault="False" name="Button_Delete" operation="Delete" wizardCaption="Borrar" PathID="usuariosButton_Delete">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<TextBox id="7" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="login" fieldSource="login" required="True" caption="Login" wizardCaption="Login" wizardSize="20" wizardMaxLength="20" wizardIsPassword="False" PathID="usuarioslogin">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<TextBox id="8" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="password" fieldSource="password" required="True" caption="Password" wizardCaption="Password" wizardSize="20" wizardMaxLength="20" wizardIsPassword="False" PathID="usuariospassword">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<ListBox id="9" visible="Yes" fieldSourceType="DBColumn" dataType="Integer" name="idPerfil" fieldSource="idPerfil" required="True" caption="Id Perfil" wizardCaption="Id Perfil" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" PathID="usuariosidPerfil" sourceType="Table" connection="Connection1" dataSource="perfil" boundColumn="idPerfil" textColumn="descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
					<TableParameters/>
					<SPParameters/>
					<SQLParameters/>
					<JoinTables/>
					<JoinLinks/>
					<Fields/>
				</ListBox>
				<TextBox id="10" visible="Yes" fieldSourceType="DBColumn" dataType="Integer" name="idlogin" fieldSource="idlogin" required="False" caption="Idlogin" wizardCaption="Idlogin" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" PathID="usuariosidlogin">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
			</Components>
			<Events/>
			<TableParameters>
				<TableParameter id="6" conditionType="Parameter" useIsNull="False" field="idlogin" parameterSource="idlogin" dataType="Integer" logicOperator="And" searchConditionType="Equal" parameterType="URL" orderNumber="1"/>
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
	</Components>
	<CodeFiles>
		<CodeFile id="Code" language="PHPTemplates" name="usuarios_maint.php" forShow="True" url="usuarios_maint.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="usuarios_maint.asp" forShow="True" url="usuarios_maint.asp" comment="'" codePage="windows-1252"/>
</CodeFiles>
	<SecurityGroups>
		<Group id="11" groupID="100"/>
	</SecurityGroups>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
