<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="True" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<Record id="2" sourceType="Table" urlType="Relative" secured="False" allowInsert="False" allowUpdate="False" allowDelete="False" validateData="True" preserveParameters="None" returnValueType="Number" returnValueTypeForDelete="Number" returnValueTypeForInsert="Number" returnValueTypeForUpdate="Number" name="tipo_propiedadSearch" returnPage="tipo_propiedad_list.ccp" wizardCaption=" Tipo Propiedad Buscar" wizardOrientation="Vertical" wizardFormMethod="post" PathID="tipo_propiedadSearch">
			<Components>
				<Button id="3" urlType="Relative" enableValidation="True" isDefault="False" name="Button_DoSearch" operation="Search" wizardCaption="Buscar" PathID="tipo_propiedadSearchButton_DoSearch">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<TextBox id="4" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="s_descripcion" wizardCaption="Descripcion" wizardSize="30" wizardMaxLength="30" wizardIsPassword="False" PathID="tipo_propiedadSearchs_descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
			</Components>
			<Events/>
			<TableParameters/>
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
		<Grid id="6" secured="False" sourceType="Table" returnValueType="Number" defaultPageSize="20" name="tipo_propiedad" connection="Connection1" pageSizeLimit="100" wizardCaption=" Tipo Propiedad Lista de" wizardGridType="Tabular" wizardAllowSorting="True" wizardSortingType="SimpleDir" wizardUsePageScroller="True" wizardAllowInsert="True" wizardAltRecord="False" wizardRecordSeparator="False" wizardAltRecordType="Controls" dataSource="tipo_propiedad">
			<Components>
				<Link id="8" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="tipo_propiedad_Insert" hrefSource="tipo_propiedad_maint.ccp" removeParameters="idTipo" wizardThemeItem="NavigatorLink" wizardDefaultValue="Agregar Nuevo" PathID="tipo_propiedadtipo_propiedad_Insert">
					<Components/>
					<Events/>
					<LinkParameters/>
					<Attributes/>
					<Features/>
				</Link>
				<Sorter id="10" visible="True" name="Sorter_idTipo" column="idTipo" wizardCaption="Id Tipo" wizardSortingType="SimpleDir" wizardControl="idTipo" wizardAddNbsp="False" PathID="tipo_propiedadSorter_idTipo">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="11" visible="True" name="Sorter_descripcion" column="descripcion" wizardCaption="Descripcion" wizardSortingType="SimpleDir" wizardControl="descripcion" wizardAddNbsp="False" PathID="tipo_propiedadSorter_descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Link id="13" visible="Yes" fieldSourceType="DBColumn" dataType="Integer" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="idTipo" fieldSource="idTipo" wizardCaption="Id Tipo" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" hrefSource="tipo_propiedad_maint.ccp" PathID="tipo_propiedadidTipo">
					<Components/>
					<Events/>
					<LinkParameters>
						<LinkParameter id="14" sourceType="DataField" format="yyyy-mm-dd" name="idTipo" source="idTipo"/>
					</LinkParameters>
					<Attributes/>
					<Features/>
				</Link>
				<Label id="16" fieldSourceType="DBColumn" dataType="Text" html="False" name="descripcion" fieldSource="descripcion" wizardCaption="Descripcion" wizardSize="30" wizardMaxLength="30" wizardIsPassword="False" wizardAddNbsp="True" PathID="tipo_propiedaddescripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Navigator id="17" size="10" type="Simple" pageSizes="1;5;10;25;50" name="Navigator" wizardFirst="True" wizardPrev="True" wizardFirstText="|&lt;" wizardPrevText="&lt;&lt;" wizardNextText="&gt;&gt;" wizardLastText="&gt;|" wizardNext="True" wizardLast="True" wizardPageNumbers="Simple" wizardSize="10" wizardTotalPages="True" wizardHideDisabled="True" wizardOfText="de" wizardImagesScheme="Simple">
					<Components/>
					<Events>
						<Event name="BeforeShow" type="Server">
							<Actions>
								<Action actionName="Hide-Show Component" actionCategory="General" id="18" action="Hide" conditionType="Parameter" dataType="Integer" condition="LessThan" name1="TotalPages" sourceType1="SpecialValue" name2="2" sourceType2="Expression"/>
							</Actions>
						</Event>
					</Events>
					<Attributes/>
					<Features/>
				</Navigator>
			</Components>
			<Events/>
			<TableParameters>
				<TableParameter id="9" conditionType="Parameter" useIsNull="False" field="descripcion" parameterSource="s_descripcion" dataType="Text" logicOperator="And" searchConditionType="Contains" parameterType="URL" orderNumber="1"/>
			</TableParameters>
			<JoinTables>
				<JoinTable id="7" tableName="tipo_propiedad" posWidth="-1" posHeight="-1" posLeft="-1" posRight="-1"/>
			</JoinTables>
			<JoinLinks/>
			<Fields>
				<Field id="12" tableName="tipo_propiedad" fieldName="idTipo"/>
				<Field id="15" tableName="tipo_propiedad" fieldName="descripcion"/>
			</Fields>
			<SPParameters/>
			<SQLParameters/>
			<SecurityGroups/>
			<Attributes/>
			<Features/>
		</Grid>
		<IncludePage id="20" name="menu1" PathID="menu1" page="menu1.ccp">
<Components/>
<Events/>
<Features/>
</IncludePage>
</Components>
	<CodeFiles>
		<CodeFile id="Events" language="PHPTemplates" name="tipo_propiedad_list_events.php" forShow="False" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="tipo_propiedad_list.php" forShow="True" url="tipo_propiedad_list.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Events" language="ASPTemplates" name="tipo_propiedad_list_events.asp" forShow="False" comment="'" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="tipo_propiedad_list.asp" forShow="True" url="tipo_propiedad_list.asp" comment="'" codePage="windows-1252"/>
	</CodeFiles>
	<SecurityGroups>
		<Group id="19" groupID="100"/>
	</SecurityGroups>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
