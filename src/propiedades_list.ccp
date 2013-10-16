<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="True" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0" accessDeniedPage="acc_denegado.ccp">
	<Components>
		<Record id="2" sourceType="Table" urlType="Relative" secured="False" allowInsert="False" allowUpdate="False" allowDelete="False" validateData="True" preserveParameters="None" returnValueType="Number" returnValueTypeForDelete="Number" returnValueTypeForInsert="Number" returnValueTypeForUpdate="Number" name="propiedadesSearch" returnPage="propiedades_list.ccp" wizardCaption=" Propiedades Buscar" wizardOrientation="Vertical" wizardFormMethod="post" PathID="propiedadesSearch">
			<Components>
				<Button id="3" urlType="Relative" enableValidation="True" isDefault="False" name="Button_DoSearch" operation="Search" wizardCaption="Buscar" PathID="propiedadesSearchButton_DoSearch">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Button>
				<TextBox id="4" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="s_descripcion" wizardCaption="Descripcion" wizardSize="50" wizardMaxLength="50" wizardIsPassword="False" PathID="propiedadesSearchs_descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<TextBox id="5" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="s_valor" wizardCaption="Valor" wizardSize="9" wizardMaxLength="9" wizardIsPassword="False" PathID="propiedadesSearchs_valor">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</TextBox>
				<ListBox id="47" visible="Yes" fieldSourceType="DBColumn" sourceType="Table" dataType="Integer" returnValueType="Number" name="s_tipo" wizardEmptyCaption="Seleccionar Valor" PathID="propiedadesSearchs_tipo" connection="Connection1" dataSource="tipo_propiedad" boundColumn="idTipo" textColumn="descripcion">
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
		<Grid id="6" secured="False" sourceType="Table" returnValueType="Number" defaultPageSize="20" name="propiedades" connection="Connection1" pageSizeLimit="100" wizardCaption=" Propiedades Lista de" wizardGridType="Tabular" wizardAllowSorting="True" wizardSortingType="SimpleDir" wizardUsePageScroller="True" wizardAllowInsert="True" wizardAltRecord="False" wizardRecordSeparator="False" wizardAltRecordType="Controls" dataSource="propiedades" activeCollection="TableParameters">
			<Components>
				<Link id="8" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="propiedades_Insert" hrefSource="propiedades_maint.ccp" removeParameters="id" wizardThemeItem="NavigatorLink" wizardDefaultValue="Agregar Nuevo" PathID="propiedadespropiedades_Insert">
					<Components/>
					<Events/>
					<LinkParameters/>
					<Attributes/>
					<Features/>
				</Link>
				<Sorter id="11" visible="True" name="Sorter_id" column="id" wizardCaption="Id" wizardSortingType="SimpleDir" wizardControl="id" wizardAddNbsp="False" PathID="propiedadesSorter_id">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="12" visible="True" name="Sorter_idZona" column="idZona" wizardCaption="Id Zona" wizardSortingType="SimpleDir" wizardControl="idZona" wizardAddNbsp="False" PathID="propiedadesSorter_idZona">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="13" visible="True" name="Sorter_idOperacion" column="idOperacion" wizardCaption="Id Operacion" wizardSortingType="SimpleDir" wizardControl="idOperacion" wizardAddNbsp="False" PathID="propiedadesSorter_idOperacion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="14" visible="True" name="Sorter_idTipo" column="idTipo" wizardCaption="Id Tipo" wizardSortingType="SimpleDir" wizardControl="idTipo" wizardAddNbsp="False" PathID="propiedadesSorter_idTipo">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="15" visible="True" name="Sorter_descripcion" column="descripcion" wizardCaption="Descripcion" wizardSortingType="SimpleDir" wizardControl="descripcion" wizardAddNbsp="False" PathID="propiedadesSorter_descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="16" visible="True" name="Sorter_dormitorios" column="dormitorios" wizardCaption="Dormitorios" wizardSortingType="SimpleDir" wizardControl="dormitorios" wizardAddNbsp="False" PathID="propiedadesSorter_dormitorios">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="17" visible="True" name="Sorter_valor" column="valor" wizardCaption="Valor" wizardSortingType="SimpleDir" wizardControl="valor" wizardAddNbsp="False" PathID="propiedadesSorter_valor">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="18" visible="True" name="Sorter_activo" column="activo" wizardCaption="Activo" wizardSortingType="SimpleDir" wizardControl="activo" wizardAddNbsp="False" PathID="propiedadesSorter_activo">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Sorter id="19" visible="True" name="Sorter_orden" column="orden" wizardCaption="Orden" wizardSortingType="SimpleDir" wizardControl="orden" wizardAddNbsp="False" PathID="propiedadesSorter_orden">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Sorter>
				<Link id="21" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="id" fieldSource="id" wizardCaption="Id" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" hrefSource="propiedades_maint.ccp" PathID="propiedadesid" wizardUseTemplateBlock="False">
					<Components/>
					<Events/>
					<LinkParameters>
						<LinkParameter id="22" sourceType="DataField" format="yyyy-mm-dd" name="id" source="idPropiedad"/>
					</LinkParameters>
					<Attributes/>
					<Features/>
				</Link>
				<Label id="24" fieldSourceType="DBColumn" dataType="Text" html="False" name="idZona" fieldSource="idZona" wizardCaption="Id Zona" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" PathID="propiedadesidZona">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="26" fieldSourceType="DBColumn" dataType="Text" html="False" name="idOperacion" fieldSource="idOperacion" wizardCaption="Id Operacion" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" PathID="propiedadesidOperacion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="28" fieldSourceType="DBColumn" dataType="Text" html="False" name="idTipo" fieldSource="idTipo" wizardCaption="Id Tipo" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" PathID="propiedadesidTipo">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="30" fieldSourceType="DBColumn" dataType="Text" html="False" name="descripcion" fieldSource="descripcion" wizardCaption="Descripcion" wizardSize="50" wizardMaxLength="50" wizardIsPassword="False" wizardAddNbsp="True" PathID="propiedadesdescripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="32" fieldSourceType="DBColumn" dataType="Integer" html="False" name="dormitorios" fieldSource="dormitorios" wizardCaption="Dormitorios" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" PathID="propiedadesdormitorios">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="34" fieldSourceType="DBColumn" dataType="Text" html="False" name="valor" fieldSource="valor" wizardCaption="Valor" wizardSize="9" wizardMaxLength="9" wizardIsPassword="False" wizardAddNbsp="True" PathID="propiedadesvalor">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="36" fieldSourceType="DBColumn" dataType="Integer" html="False" name="activo" fieldSource="activo" wizardCaption="Activo" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" PathID="propiedadesactivo">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Label id="38" fieldSourceType="DBColumn" dataType="Integer" html="False" name="orden" fieldSource="orden" wizardCaption="Orden" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardAddNbsp="True" wizardAlign="right" PathID="propiedadesorden">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
				<Navigator id="39" size="10" type="Simple" pageSizes="1;5;10;25;50" name="Navigator" wizardFirst="True" wizardPrev="True" wizardFirstText="|&lt;" wizardPrevText="&lt;&lt;" wizardNextText="&gt;&gt;" wizardLastText="&gt;|" wizardNext="True" wizardLast="True" wizardPageNumbers="Simple" wizardSize="10" wizardTotalPages="True" wizardHideDisabled="True" wizardOfText="de" wizardImagesScheme="Simple">
					<Components/>
					<Events>
						<Event name="BeforeShow" type="Server">
							<Actions>
								<Action actionName="Hide-Show Component" actionCategory="General" id="40" action="Hide" conditionType="Parameter" dataType="Integer" condition="LessThan" name1="TotalPages" sourceType1="SpecialValue" name2="2" sourceType2="Expression"/>
							</Actions>
						</Event>
					</Events>
					<Attributes/>
					<Features/>
				</Navigator>
				<Link id="41" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Page" urlType="Relative" preserveParameters="GET" name="Link1" PathID="propiedadesLink1" hrefSource="attach.ccp" wizardUseTemplateBlock="False">
					<Components/>
					<Events/>
					<LinkParameters>
						<LinkParameter id="42" sourceType="DataField" format="yyyy-mm-dd" name="id" source="idPropiedad"/>
					</LinkParameters>
					<Attributes/>
					<Features/>
				</Link>
				<Label id="44" fieldSourceType="DBColumn" dataType="Text" html="False" name="moneda" PathID="propiedadesmoneda" fieldSource="idMoneda">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
			</Components>
			<Events>
				<Event name="BeforeShowRow" type="Server">
					<Actions>
						<Action actionName="Custom Code" actionCategory="General" id="43"/>
					</Actions>
				</Event>
			</Events>
			<TableParameters>
				<TableParameter id="10" conditionType="Parameter" useIsNull="False" field="valor" parameterSource="s_valor" dataType="Text" logicOperator="And" searchConditionType="Contains" parameterType="URL" orderNumber="2"/>
				<TableParameter id="48" conditionType="Parameter" useIsNull="False" field="idTipo" dataType="Integer" searchConditionType="Contains" parameterType="URL" logicOperator="And" parameterSource="s_tipo"/>
				<TableParameter id="50" conditionType="Parameter" useIsNull="False" field="id" dataType="Text" searchConditionType="Contains" parameterType="URL" logicOperator="And" parameterSource="s_descripcion"/>
</TableParameters>
			<JoinTables>
				<JoinTable id="7" tableName="propiedades" posWidth="115" posHeight="180" posLeft="10" posRight="-1" posTop="10"/>
			</JoinTables>
			<JoinLinks/>
			<Fields>
				<Field id="20" tableName="propiedades" fieldName="id"/>
				<Field id="23" tableName="propiedades" fieldName="idZona"/>
				<Field id="25" tableName="propiedades" fieldName="idOperacion"/>
				<Field id="27" tableName="propiedades" fieldName="idTipo"/>
				<Field id="29" tableName="propiedades" fieldName="descripcion"/>
				<Field id="31" tableName="propiedades" fieldName="dormitorios"/>
				<Field id="33" tableName="propiedades" fieldName="valor"/>
				<Field id="35" tableName="propiedades" fieldName="activo"/>
				<Field id="37" tableName="propiedades" fieldName="orden"/>
				<Field id="45" tableName="propiedades" fieldName="idMoneda"/>
				<Field id="49" tableName="propiedades" fieldName="idPropiedad"/>
			</Fields>
			<SPParameters/>
			<SQLParameters/>
			<SecurityGroups/>
			<Attributes/>
			<Features/>
		</Grid>
		<IncludePage id="46" name="menu1" PathID="menu1" page="menu1.ccp">
			<Components/>
			<Events/>
			<Features/>
		</IncludePage>
	</Components>
	<CodeFiles>
		<CodeFile id="Events" language="PHPTemplates" name="propiedades_list_events.php" forShow="False" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="propiedades_list.php" forShow="True" url="propiedades_list.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Events" language="ASPTemplates" name="propiedades_list_events.asp" forShow="False" comment="'" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="propiedades_list.asp" forShow="True" url="propiedades_list.asp" comment="'" codePage="windows-1252"/>
	</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
