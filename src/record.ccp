<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="False" urlType="Relative" isIncluded="False" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0" wizardUsePageScroller="True">
	<Components>
		<Grid id="2" secured="False" sourceType="Table" returnValueType="Number" defaultPageSize="10" connection="Connection1" name="propiedades" pageSizeLimit="100" wizardCaption=" Propiedades Galeria" wizardGridType="Gallery" wizardSortingType="SimpleDir" wizardAllowInsert="False" wizardAltRecord="False" wizardAltRecordType="Style" wizardRecordSeparator="False" wizardNoRecords="No hay registros" numberOfColumns="1" rowsPerPage="10" recordsNumber="10" activeCollection="SQLParameters" parameterTypeListName="ParameterTypeList" dataSource="propiedades, zonas, operaciones, tipo_propiedad, moneda" orderBy="orden">
			<Components>
				<Panel id="14" visible="True" name="RowOpenTag">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Panel>
				<Panel id="15" visible="True" name="RowComponents">
					<Components>
						<Label id="20" fieldSourceType="DBColumn" dataType="Text" html="False" name="zona" fieldSource="zonas_descripcion" wizardCaption="Descripcion" wizardSize="50" wizardMaxLength="50" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardAddNbsp="True" PathID="propiedadesRowComponentszona">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Label>
						<Label id="21" fieldSourceType="DBColumn" dataType="Integer" html="False" name="dormitorios" fieldSource="dormitorios" wizardCaption="Dormitorios" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardAddNbsp="True" PathID="propiedadesRowComponentsdormitorios">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Label>
						<Label id="22" fieldSourceType="DBColumn" dataType="Text" html="False" name="valor" fieldSource="valor" wizardCaption="Valor" wizardSize="9" wizardMaxLength="9" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardAddNbsp="True" PathID="propiedadesRowComponentsvalor">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Label>
						<Label id="34" fieldSourceType="DBColumn" dataType="Text" html="False" name="id" PathID="propiedadesRowComponentsid" fieldSource="id">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Label>
						<Image id="35" visible="Yes" fieldSourceType="DBColumn" dataType="Text" name="Image1" PathID="propiedadesRowComponentsImage1">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Image>
						<Label id="77" fieldSourceType="DBColumn" dataType="Text" html="False" name="descripcion" fieldSource="descripcion" wizardCaption="Dormitorios" wizardSize="10" wizardMaxLength="10" wizardIsPassword="False" wizardUseTemplateBlock="False" wizardAddNbsp="True" PathID="propiedadesRowComponentsdescripcion">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Label>
						<Label id="52" fieldSourceType="DBColumn" dataType="Text" html="False" name="operacion" PathID="propiedadesRowComponentsoperacion" fieldSource="operaciones_descripcion">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Label>
						<Label id="53" fieldSourceType="DBColumn" dataType="Text" html="False" name="tipo" PathID="propiedadesRowComponentstipo" fieldSource="tipo_propiedad_descripcion">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Label>
						<Hidden id="97" fieldSourceType="DBColumn" dataType="Text" name="idPropiedad" PathID="propiedadesRowComponentsidPropiedad" fieldSource="idPropiedad">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Hidden>
						<Hidden id="99" fieldSourceType="DBColumn" dataType="Float" name="valor_num" PathID="propiedadesRowComponentsvalor_num" fieldSource="valor_num">
							<Components/>
							<Events/>
							<Attributes/>
							<Features/>
						</Hidden>
					</Components>
					<Events/>
					<Attributes/>
					<Features/>
				</Panel>
				<Panel id="25" visible="True" name="RowCloseTag">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Panel>
				<Navigator id="26" size="10" pageSizes="1;5;10;25;50" name="Navigator" wizardPagingType="Custom" wizardFirst="False" wizardFirstText="Inicio" wizardPrev="True" wizardPrevText="Anterior" wizardNext="True" wizardNextText="Siguiente" wizardLast="False" wizardLastText="Final" wizardSize="10" wizardTotalPages="False" wizardHideDisabled="False" wizardOfText="de" wizardPageSize="False" type="Centered" wizardPageNumbers="Centered">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Navigator>
			</Components>
			<Events>
				<Event name="BeforeShowRow" type="Server">
					<Actions>
						<Action actionName="Gallery Layout" actionCategory="General" id="4"/>
						<Action actionName="Custom Code" actionCategory="General" id="36"/>
					</Actions>
				</Event>
				<Event name="BeforeBuildSelect" type="Server">
					<Actions>
						<Action actionName="Custom Code" actionCategory="General" id="56"/>
					</Actions>
				</Event>
			</Events>
			<TableParameters>
			</TableParameters>
			<JoinTables>
				<JoinTable id="63" tableName="propiedades" posLeft="10" posTop="10" posWidth="185" posHeight="180"/>
				<JoinTable id="64" tableName="zonas" posLeft="257" posTop="16" posWidth="95" posHeight="88"/>
				<JoinTable id="68" tableName="operaciones" posLeft="391" posTop="80" posWidth="95" posHeight="88"/>
				<JoinTable id="72" tableName="tipo_propiedad" posLeft="356" posTop="178" posWidth="95" posHeight="88"/>
				<JoinTable id="79" tableName="moneda" schemaName="hrolivapropiedades" posLeft="209" posTop="201" posWidth="95" posHeight="88"/>
			</JoinTables>
			<JoinLinks>
				<JoinTable2 id="65" tableLeft="propiedades" tableRight="zonas" fieldLeft="propiedades.idZona" fieldRight="zonas.idZona" joinType="inner" conditionType="Equal"/>
				<JoinTable2 id="69" tableLeft="propiedades" tableRight="operaciones" fieldLeft="propiedades.idOperacion" fieldRight="operaciones.idOperacion" joinType="inner" conditionType="Equal"/>
				<JoinTable2 id="73" tableLeft="propiedades" tableRight="tipo_propiedad" fieldLeft="propiedades.idTipo" fieldRight="tipo_propiedad.idTipo" joinType="inner" conditionType="Equal"/>
				<JoinTable2 id="80" tableLeft="propiedades" tableRight="moneda" fieldLeft="propiedades.idMoneda" fieldRight="moneda.idMoneda" joinType="inner" conditionType="Equal"/>
			</JoinLinks>
			<Fields>
				<Field id="67" tableName="zonas" fieldName="zonas.descripcion" alias="zonas_descripcion"/>
				<Field id="71" tableName="operaciones" fieldName="operaciones.descripcion" alias="operaciones_descripcion"/>
				<Field id="75" tableName="tipo_propiedad" fieldName="tipo_propiedad.descripcion" alias="tipo_propiedad_descripcion"/>
				<Field id="82" tableName="moneda" fieldName="moneda.descripcion" alias="moneda_descripcion"/>
				<Field id="86" tableName="propiedades" fieldName="idPropiedad"/>
				<Field id="87" tableName="propiedades" fieldName="id"/>
				<Field id="88" tableName="propiedades" fieldName="propiedades.idZona" alias="propiedades_idZona"/>
				<Field id="89" tableName="propiedades" fieldName="propiedades.idOperacion" alias="propiedades_idOperacion"/>
				<Field id="90" tableName="propiedades" fieldName="propiedades.idTipo" alias="propiedades_idTipo"/>
				<Field id="91" tableName="propiedades" fieldName="propiedades.descripcion" alias="descripcion"/>
				<Field id="92" tableName="propiedades" fieldName="dormitorios"/>
				<Field id="93" tableName="propiedades" fieldName="valor" alias="valor"/>
				<Field id="94" tableName="propiedades" fieldName="propiedades.idMoneda" alias="propiedades_idMoneda"/>
				<Field id="95" tableName="propiedades" fieldName="activo"/>
				<Field id="96" tableName="propiedades" fieldName="orden"/>
				<Field id="98" tableName="propiedades" fieldName="valor_num"/>
			</Fields>
			<SPParameters/>
			<SQLParameters>
				<SQLParameter id="57" parameterType="URL" variable="s_idZona" dataType="Integer" parameterSource="s_idZona" defaultValue="0"/>
				<SQLParameter id="58" parameterType="URL" variable="s_idOperacion" dataType="Integer" parameterSource="s_idOperacion" defaultValue="0"/>
				<SQLParameter id="59" parameterType="URL" variable="s_idTipo" dataType="Integer" parameterSource="s_idTipo" defaultValue="0"/>
				<SQLParameter id="60" parameterType="URL" variable="s_dormitorios" dataType="Integer" parameterSource="s_dormitorios" defaultValue="0"/>
				<SQLParameter id="61" parameterType="URL" variable="s_valor" dataType="Integer" parameterSource="s_valor" defaultValue="0"/>
				<SQLParameter id="62" parameterType="Expression" variable="Expr0" dataType="Integer" parameterSource="1" defaultValue="1"/>
			</SQLParameters>
			<SecurityGroups/>
			<Attributes>
				<Attribute id="3" name="numberOfColumns" sourceType="Expression" source="1"/>
			</Attributes>
			<Features/>
		</Grid>
	</Components>
	<CodeFiles>
		<CodeFile id="Events" language="PHPTemplates" name="record_events.php" forShow="False" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="PHPTemplates" name="record.php" forShow="True" url="record.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Events" language="ASPTemplates" name="record_events.asp" forShow="False" comment="'" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="record.asp" forShow="True" url="record.asp" comment="'" codePage="windows-1252"/>
	</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
