<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="False" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<Grid id="2" secured="False" sourceType="Table" returnValueType="Number" defaultPageSize="1" connection="Connection1" dataSource="fotos" name="fotos" pageSizeLimit="100" wizardCaption=" Fotos Galeria" wizardGridType="Gallery" wizardSortingType="SimpleDir" wizardAllowInsert="False" wizardAltRecord="False" wizardAltRecordType="Style" wizardRecordSeparator="False" wizardNoRecords="No hay registros" numberOfColumns="1" rowsPerPage="1" recordsNumber="1" activeCollection="TableParameters" pasteAsReplace="pasteAsReplace">
			<Components>
				<Panel id="6" visible="True" name="RowOpenTag">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Panel>
				<Panel id="7" visible="True" name="RowComponents" wizardAddNbsp="True">
					<Components>
						<Image id="8" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="url" fieldSource="url" wizardCaption="Url" wizardSize="50" wizardMaxLength="128" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardAddNbsp="True" width="200" PathID="fotosRowComponentsurl">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Image>
					</Components>
					<Events/>
					<Attributes/>
					<Features/>
				</Panel>
				<Panel id="9" visible="True" name="RowCloseTag">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Panel>
				<Navigator id="10" size="10" pageSizes="1;5;10;25;50" name="Navigator" wizardPagingType="Custom" wizardFirst="False" wizardFirstText="Inicio" wizardPrev="True" wizardPrevText="Anterior" wizardNext="True" wizardNextText="Siguiente" wizardLast="False" wizardLastText="Final" wizardImages="Images" wizardSize="10" wizardTotalPages="True" wizardHideDisabled="False" wizardOfText="de" wizardImagesScheme="Simple" type="Simple">
					<Components/>
					<Events>
						<Event name="BeforeShow" type="Server">
							<Actions>
								<Action actionName="Hide-Show Component" actionCategory="General" id="11" action="Hide" conditionType="Parameter" dataType="Integer" condition="LessThan" name1="TotalPages" sourceType1="SpecialValue" name2="2" sourceType2="Expression"/>
							</Actions>
						</Event>
					</Events>
					<Attributes/>
					<Features/>
				</Navigator>
			</Components>
			<Events>
				<Event name="BeforeShowRow" type="Server">
					<Actions>
						<Action actionName="Gallery Layout" actionCategory="General" id="4"/>
					</Actions>
				</Event>
			</Events>
			<TableParameters>
				<TableParameter id="13" conditionType="Parameter" useIsNull="False" field="id" dataType="Integer" searchConditionType="Equal" parameterType="URL" logicOperator="And" defaultValue="-1" parameterSource="p"/>
			</TableParameters>
			<JoinTables>
				<JoinTable id="12" tableName="fotos" posLeft="10" posTop="10" posWidth="95" posHeight="104"/>
			</JoinTables>
			<JoinLinks/>
			<Fields/>
			<SPParameters/>
			<SQLParameters/>
			<SecurityGroups/>
			<Attributes>
				<Attribute id="3" name="numberOfColumns" sourceType="Expression" source="1"/>
			</Attributes>
			<Features/>
		</Grid>
	</Components>
	<CodeFiles>
		<CodeFile id="Events" language="PHPTemplates" name="gallery_events.php" forShow="False" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="gallery.php" forShow="True" url="gallery.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Events" language="ASPTemplates" name="gallery_events.asp" forShow="False" comment="'" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="gallery.asp" forShow="True" url="gallery.asp" comment="'" codePage="windows-1252"/>
	</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
