<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="True" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0" accessDeniedPage="acc_denegado.ccp">
	<Components>
		<Grid id="2" secured="False" sourceType="Table" returnValueType="Number" defaultPageSize="10" connection="Connection1" dataSource="fotos" name="fotos" pageSizeLimit="100" wizardCaption=" Fotos Lista de" wizardGridType="Tabular" wizardSortingType="SimpleDir" wizardAllowInsert="True" wizardAltRecord="False" wizardAltRecordType="Style" wizardRecordSeparator="False" wizardNoRecords="No hay registros" activeCollection="TableParameters">
			<Components>
				<Sorter id="5" visible="True" name="Sorter_descripcion" column="descripcion" wizardCaption="Descripcion" wizardSortingType="SimpleDir" wizardControl="descripcion" wizardAddNbsp="False" PathID="fotosSorter_descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Label id="8" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Database" urlType="Relative" preserveParameters="None" name="descripcion" fieldSource="descripcion" wizardCaption="Descripcion" wizardSize="50" wizardMaxLength="50" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardAddNbsp="True" hrefSource="attach.ccp" wizardThemeItem="GridA" PathID="fotosdescripcion">
					<Components/>
					<Events/>
					<LinkParameters>
						<LinkParameter id="9" sourceType="DataField" format="yyyy-mm-dd" name="idFoto" source="idFoto"/>
					</LinkParameters>
					<Attributes/>
					<Features/>
				</Label>
				<Image id="11" fieldSourceType="DBColumn" dataType="Text" html="False" name="url" fieldSource="url" wizardCaption="Url" wizardSize="50" wizardMaxLength="128" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardAddNbsp="True" PathID="fotosurl" visible="Yes">
					<Components/>
					<Events>
					</Events>
					<Attributes/>
					<Features/>
				</Image>
				<Link id="20" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="Link1" PathID="fotosLink1" wizardUseTemplateBlock="False" hrefSource="attach.ccp">
					<Components/>
					<Events/>
					<LinkParameters>
						<LinkParameter id="21" sourceType="DataField" name="del" source="idFoto"/>
					</LinkParameters>
					<Attributes/>
					<Features/>
				</Link>
			</Components>
			<Events/>
			<TableParameters>
				<TableParameter id="32" conditionType="Parameter" useIsNull="False" field="id" dataType="Integer" searchConditionType="Equal" parameterType="URL" logicOperator="And" defaultValue="-1" parameterSource="id"/>
			</TableParameters>
			<JoinTables>
				<JoinTable id="31" tableName="fotos" posLeft="10" posTop="10" posWidth="95" posHeight="120"/>
			</JoinTables>
			<JoinLinks/>
			<Fields>
				<Field id="3" tableName="fotos" fieldName="idFoto"/>
				<Field id="7" tableName="fotos" fieldName="descripcion"/>
				<Field id="10" tableName="fotos" fieldName="url"/>
			</Fields>
			<SPParameters/>
			<SQLParameters/>
			<SecurityGroups/>
			<Attributes/>
			<Features/>
		</Grid>
		<Record id="23" sourceType="Table" urlType="Relative" secured="False" allowInsert="True" allowUpdate="False" allowDelete="False" validateData="True" preserveParameters="GET" returnValueType="Number" returnValueTypeForDelete="Number" returnValueTypeForInsert="Number" returnValueTypeForUpdate="Number" connection="Connection1" name="NewRecord1" dataSource="fotos" errorSummator="Error" wizardCaption="Agregar/Editar Fotos " wizardFormMethod="post" PathID="NewRecord1">
			<Components>
				<Button id="24" urlType="Relative" enableValidation="True" isDefault="False" name="Button_Insert" operation="Insert" wizardCaption="Agregar" PathID="NewRecord1Button_Insert">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<Hidden id="26" fieldSourceType="DBColumn" dataType="Integer" name="id" fieldSource="id" required="True" caption="Id" wizardCaption="Id" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="NewRecord1id">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Hidden>
				<TextBox id="28" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="descripcion" fieldSource="descripcion" required="False" caption="Descripcion" wizardCaption="Descripcion" wizardSize="50" wizardMaxLength="50" wizardIsPassword="False" wizardUseTemplateBlock="False" PathID="NewRecord1descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<FileUpload id="29" fieldSourceType="DBColumn" allowedFileMasks="*.jpg;*.gif" fileSizeLimit="1200000" dataType="Text" tempFileFolder="%TEMP" name="FileUpload1" PathID="NewRecord1FileUpload1" fieldSource="url" processedFileFolder="images">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</FileUpload>
			</Components>
			<Events/>
			<TableParameters>
				<TableParameter id="25" conditionType="Parameter" useIsNull="False" field="idFoto" parameterSource="idFoto" dataType="Integer" logicOperator="And" searchConditionType="Equal" parameterType="URL" orderNumber="1"/>
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
		<CodeFile id="Events" language="PHPTemplates" name="attach_events.php" forShow="False" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="attach.php" forShow="True" url="attach.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Events" language="ASPTemplates" name="attach_events.asp" forShow="False" comment="'" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="attach.asp" forShow="True" url="attach.asp" comment="'" codePage="windows-1252"/>
	</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events>
		<Event name="AfterInitialize" type="Server">
			<Actions>
				<Action actionName="Custom Code" actionCategory="General" id="30"/>
			</Actions>
		</Event>
	</Events>
</Page>
