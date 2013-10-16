<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="False" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<Record id="2" sourceType="Table" urlType="Relative" secured="False" allowInsert="True" allowUpdate="False" allowDelete="False" validateData="True" preserveParameters="GET" returnValueType="Number" returnValueTypeForDelete="Number" returnValueTypeForInsert="Number" returnValueTypeForUpdate="Number" connection="Connection1" name="contacto" dataSource="contacto" errorSummator="Error" wizardCaption="Agregar/Editar Contacto " wizardFormMethod="post" PathID="contacto" returnPage="gracias.ccp">
			<Components>
				<Button id="3" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Insert" operation="Insert" wizardCaption="Agregar" PathID="contactoButton_Insert">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<TextBox id="5" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="nombre" fieldSource="nombre" required="False" caption="Nombre" wizardCaption="Nombre" wizardSize="30" wizardMaxLength="30" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="contactonombre">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<TextBox id="6" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="email" fieldSource="email" required="False" caption="Email" wizardCaption="Email" wizardSize="50" wizardMaxLength="128" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="contactoemail">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<TextBox id="7" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="telefono" fieldSource="telefono" required="False" caption="Telefono" wizardCaption="Telefono" wizardSize="15" wizardMaxLength="15" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="contactotelefono">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<TextArea id="8" visible="Yes" fieldSourceType="DBColumn" dataType="Memo" name="consulta" fieldSource="consulta" required="False" caption="Consulta" wizardCaption="Consulta" wizardSize="50" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardRows="3" PathID="contactoconsulta">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextArea>
			</Components>
			<Events>
				<Event name="AfterExecuteInsert" type="Server">
					<Actions>
						<Action actionName="Custom Code" actionCategory="General" id="9"/>
					</Actions>
				</Event>
			</Events>
			<TableParameters>
				<TableParameter id="4" conditionType="Parameter" useIsNull="False" field="id" parameterSource="id" dataType="Integer" logicOperator="And" searchConditionType="Equal" parameterType="URL" orderNumber="1"/>
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
		<IncludePage id="10" name="menu1" PathID="menu1" page="menu1.ccp">
<Components/>
<Events/>
<Features/>
</IncludePage>
</Components>
	<CodeFiles>
		<CodeFile id="Events" language="PHPTemplates" name="contacto_events.php" forShow="False" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="contacto.php" forShow="True" url="contacto.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Events" language="ASPTemplates" name="contacto_events.asp" forShow="False" comment="'" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="contacto.asp" forShow="True" url="contacto.asp" comment="'" codePage="windows-1252"/>
	</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
